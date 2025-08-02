import 'package:base_project_repo/core/constants/enums/exception_enums.dart';
import 'package:base_project_repo/core/presentation/widgets/common_empty_widget.dart';
import 'package:base_project_repo/features/order_feature/presentation/logic/offers_cubit/offer_cubit.dart';
import 'package:base_project_repo/features/order_feature/presentation/logic/offers_cubit/offer_states.dart';
import 'package:base_project_repo/features/order_feature/presentation/widget/offer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/constants/app_constants.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_error_widget.dart';
import '/core/presentation/widgets/common_loading_widget.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';

class OfferListScreen extends StatefulWidget {
  const OfferListScreen({Key? key}) : super(key: key);

  @override
  State<OfferListScreen> createState() => _OfferListScreenState();
}

class _OfferListScreenState extends State<OfferListScreen> {
  late OfferCubit offerCubit;

  @override
  void initState() {
    super.initState();
    offerCubit = OfferCubit.get(context);
    offerCubit.getOfferList();
    offerCubit.scrollController = ScrollController();
    offerCubit.scrollController.addListener(
      () {
        offerCubit.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblMyOffers,
        withBack: false,
        centerTitle: false,
        leadingWidth: AppConstants.padding24,
      ),
      body: BlocConsumer<OfferCubit, OfferStates>(
          listener: (BuildContext offerCtx, OfferStates offerState) {
        if (offerState is OfferErrorState) {
          checkUserAuth(context: offerCtx, errorType: offerState.error!.type);
          showSnackBar(
              context: offerCtx,
              title: offerState.error!.type.getErrorMessage(context) ??
                  offerState.error!.errorMassage);
        }
      }, builder: (BuildContext offerCtx, OfferStates offerState) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getWidgetWidth(AppConstants.padding16)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (offerState is OfferLoadingState) ...<Widget>[
                  const Expanded(child: CommonLoadingWidget())
                ] else if (offerState is OfferErrorState) ...<Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CommonError(
                          errorType: offerState.error!.type,
                          withButton: true,
                          onTap: () => offerCubit.getOfferList(),
                        ),
                      ],
                    ),
                  )
                ] else if (offerState is OfferEmptyState ||
                    offerCubit.offerList.isEmpty) ...<Widget>[
                  getSpaceHeight(AppConstants.padding36),
                  EmptyScreen(
                    imageString: IconPath.emptyIcon,
                    imageHeight: 200,
                    imageWidth: 110,
                    titleKey: AppLocalizations.of(context)!.lblNoData,
                    description:
                        AppLocalizations.of(context)!.lblNoOffersDescription,
                  )
                ] else ...<Widget>[
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                          vertical: getWidgetHeight(AppConstants.padding16),
                          horizontal: getWidgetWidth(
                            AppConstants.padding4,
                          )),
                      shrinkWrap: true,
                      controller: offerCubit.scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: offerCubit.offerList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return getSpaceHeight(AppConstants.padding16);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            OfferItem(
                              offerModel: offerCubit.offerList[index],
                            ),
                            if (index >= offerCubit.offerList.length &&
                                offerCubit.hasMoreData)
                              const CommonLoadingWidget()
                            else
                              const SizedBox()
                          ],
                        );
                      },
                    ),
                  )
                ]
              ]),
        );
      }),
    );
  }
}

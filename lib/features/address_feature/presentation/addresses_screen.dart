import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/presentation/routes/route_argument.dart';
import 'package:base_project_repo/core/presentation/routes/route_names.dart';
import 'package:base_project_repo/core/presentation/widgets/common_empty_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_error_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/loading_widgets/scale_transition_loader_widget.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/address_cubit/address_cubit.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/address_cubit/address_states.dart';
import 'package:base_project_repo/features/address_feature/presentation/widgets/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({
    super.key,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late AddressCubit addressCubit;

  @override
  void initState() {
    super.initState();
    addressCubit = AddressCubit.get(context);
    addressCubit.getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        centerTitle: false,
        leadingWidth: getWidgetWidth(AppConstants.padding16),
        customTitleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblAddress,
          textWeight: FontWeight.w500,
        ),
        customActionWidget: InkWell(
          onTap: () {
            context.pushNamed(RouteNames.addNewAddressPageRoute,
                extra: RouteArgument(onAddressSuccess: () {
              addressCubit.getAddressList();
            }));
          },
          child: CommonTitleText(
            textKey: AppLocalizations.of(context)!.lblAddAddress,
            textWeight: FontWeight.w500,
            textFontSize: AppConstants.fontSize14,
            textColor: AppConstants.greenColor,
          ),
        ),
      ),
      body: BlocConsumer<AddressCubit, AddressStates>(
        builder: (BuildContext context, AddressStates state) {
          if (state is AddressErrorState) {
            return CommonError(
              errorMassage: state.error!.errorMassage,
              withButton: true,
              onTap: () {
                addressCubit.getAddressList();
              },
            );
          } else if (state is AddressLoadingState) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.padding16,
                vertical: AppConstants.padding16,
              ),
              child: ListView.separated(
                itemBuilder: (BuildContext itemCtx, int itemPos) {
                  return LoadingShimmer();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return getSpaceHeight(AppConstants.padding8);
                },
                itemCount: 10,
              ),
            );
          } else if (state is AddressEmptyState) {
            return EmptyScreen(
              imageString: IconPath.emptyIcon,
              titleKey: AppLocalizations.of(context)!.lblNoAddress,
              description: AppLocalizations.of(context)!.lblAddressDescription,
              imageHeight: 200,
              imageWidth: 120,
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.padding16,
                vertical: AppConstants.padding16,
              ),
              child: ListView.separated(
                itemBuilder: (BuildContext itemCtx, int itemPos) {
                  return AddressWidget(
                    addressModel: addressCubit.addressList[itemPos],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return getSpaceHeight(AppConstants.padding8);
                },
                itemCount: addressCubit.addressList.length,
              ),
            );
          }
        },
        listener: (BuildContext context, AddressStates state) {},
      ),
    );
  }
}

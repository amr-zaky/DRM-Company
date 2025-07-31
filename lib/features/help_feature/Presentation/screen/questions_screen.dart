import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/keys/icon_path.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/helpers/shared_texts.dart';
import '../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/widgets/common_empty_widget.dart';
import '../../../../core/presentation/widgets/common_error_widget.dart';
import '../../../../core/presentation/widgets/common_loading_widget.dart';
import '../../../../core/presentation/widgets/common_text_form_field_widget.dart';
import '../logic/help_cubit/help_cubit.dart';
import '../logic/help_cubit/help_states.dart';
import '../widget/question_widget.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  late HelpCubit helpCubit;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    helpCubit = HelpCubit.get(context);
    searchController = TextEditingController();
    helpCubit.getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblHelpCenterTitle,
      ),
      body: GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getWidgetWidth(AppConstants.padding16),
              ),
              child: BlocConsumer<HelpCubit, HelpStates>(
                listener: (BuildContext helpCtx, HelpStates helpState) {},
                builder: (BuildContext helpCtx, HelpStates helpState) {
                  if (helpState is HelpGetQuestionLoadingState) {
                    return SizedBox(
                        height: SharedText.screenHeight - 120,
                        child: const CommonLoadingWidget());
                  } else if (helpState is HelpGetQuestionFailState) {
                    return CommonError(
                      withButton: true,
                      errorType: helpState.error.type,
                      errorMassage: helpState.error.errorMassage,
                      onTap: () {
                        helpCubit.getQuestions();
                      },
                    );
                  } else if (helpState is HelpGetQuestionEmptyState) {
                    return EmptyScreen(
                      imageString: IconPath.emptyIcon,
                      imageWidth: 250,
                      imageHeight: 200,
                      titleKey:
                          AppLocalizations.of(context)!.lblNoQuestionFound,
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        CommonTextFormField(
                          controller: searchController,
                          hintKey: AppLocalizations.of(context)!.lblSearchTitle,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: CommonAssetSvgImageWidget(
                              imageString: IconPath.searchIcon,
                              height: 14,
                              width: 14,
                            ),
                          ),
                          radius: getWidgetWidth(56),
                          onChanged: (String? str) {
                            helpCubit.search(str!);
                            return str;
                          },
                        ),
                        getSpaceHeight(AppConstants.padding16),
                        if (helpCubit.questionList.isEmpty) ...<Widget>[
                          EmptyScreen(
                            imageString: IconPath.emptyIcon,
                            imageWidth: 250,
                            imageHeight: 200,
                            titleKey: AppLocalizations.of(context)!
                                .lblNoQuestionFound,
                          )
                        ] else ...<Widget>[
                          ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) =>
                                Column(
                              children: <Widget>[
                                QuestionWidget(
                                    faqModel: helpCubit.questionList[index]),
                                if (helpState
                                        is HelpGetMoreQuestionLoadingState &&
                                    helpCubit.questionList.length - 1 == index)
                                  const CommonLoadingWidget()
                              ],
                            ),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    getSpaceHeight(AppConstants.padding16),
                            itemCount: helpCubit.questionList.length,
                          ),
                        ],
                      ],
                    );
                  }
                },
              )),
        ),
      ),
    );
  }
}

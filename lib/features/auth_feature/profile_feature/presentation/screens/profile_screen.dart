import 'package:base_project_repo/core/presentation/widgets/form_input_widgets/email_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../logic/profile_cubit/profile_cubit.dart';
import '../logic/profile_cubit/profile_states.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/enums/exception_enums.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/routes/route_names.dart';
import '/core/presentation/widgets/common_global_button.dart';
import '/core/presentation/widgets/common_person_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import '/core/presentation/widgets/form_input_widgets/name_form_widget.dart';
import '/core/presentation/widgets/form_input_widgets/phone_form_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileCubit _profileCubit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _profileCubit = BlocProvider.of<ProfileCubit>(context);
    _profileCubit.initialController();
  }

  @override
  void dispose() {
    _profileCubit.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        pageTitle: AppLocalizations.of(context)!.lblProfileSetting,
        centerTitle: false,
      ),
      backgroundColor: AppConstants.lightWhiteColor,
      body: BlocConsumer<ProfileCubit, ProfileCubitStates>(
        listener: (BuildContext profileCtx, ProfileCubitStates profileState) {
          if (profileState is ProfileUpdateFailedState) {
            showSnackBar(
              context: profileCtx,
              title: profileState.error.type.getErrorMessage(context) ??
                  profileState.error.errorMassage,
            );
          } else if (profileState is RemovePhotoSuccessState) {
            profileCtx.read<ProfileCubit>().getUserProfileData();
          } else if (profileState is ProfileUpdateSuccessState) {
            showSnackBar(
                context: profileCtx,
                title: AppLocalizations.of(context)!.lblProfileUpdateSuccess,
                color: AppConstants.successColor);
            context.pushReplacementNamed(RouteNames.mainBottomNavPageRoute);
          }
        },
        builder: (BuildContext profileCtx, ProfileCubitStates profileState) {
          return Stack(
            children: <Widget>[
              InkWell(
                hoverColor: AppConstants.transparent,
                focusColor: AppConstants.transparent,
                splashColor: AppConstants.transparent,
                highlightColor: AppConstants.transparent,
                onTap: () {
                  hideKeyboard(context);
                },
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidgetWidth(AppConstants.padding16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        getSpaceHeight(AppConstants.padding24),

                        ///profile image
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CommonPersonImageWidget(
                                context: profileCtx,
                                pickedImage: _profileCubit.imageXFile,
                                cacheImage: SharedText.currentUser?.image,
                                pickPhoto: _profileCubit.photoPicked,
                                deletePhoto: _profileCubit.deleteImageFunc),
                          ],
                        ),

                        getSpaceHeight(AppConstants.padding16),

                        /// name
                        NameFormWidget(
                          nameController: _profileCubit.userNameController,
                          nameOnChanged: (String? value) {
                            setState(() {});
                            return null;
                          },
                        ),

                        getSpaceHeight(AppConstants.padding16),

                        /// phone
                        EmailFormWidget(
                          emailController: _profileCubit.emailController,
                          emailOnChanged: (String? value) {
                            setState(() {});
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Center(
                    child: CommonGlobalButton(
                      buttonText: AppLocalizations.of(context)!.lblSaveChanges,
                      onPressedFunction: () {
                        if (formKey.currentState!.validate()) {
                          profileCtx.read<ProfileCubit>().updateUserProfile(
                              name: _profileCubit.userNameController.text,
                              email: _profileCubit.emailController.text ==
                                      SharedText.currentUser!.phone!
                                  ? null
                                  : _profileCubit.emailController.text,
                              image:
                                  profileCtx.read<ProfileCubit>().imageXFile);
                        }
                      },
                      isEnable:
                          _profileCubit.userNameController.text.isNotEmpty &&
                              _profileCubit.emailController.text.isNotEmpty,
                      isLoading: profileState is ProfileUpdateLoadingState,
                      buttonBackgroundColor: AppConstants.appBarTitleColor,
                      radius: AppConstants.borderRadius8,
                      buttonTextSize: AppConstants.fontSize18,
                    ),
                  ),
                  getSpaceHeight(50),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

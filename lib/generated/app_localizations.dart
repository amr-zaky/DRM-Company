import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @lblLanguageName.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get lblLanguageName;

  /// No description provided for @lblValidate.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get lblValidate;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Default Repository App'**
  String get title;

  /// No description provided for @title22.
  ///
  /// In en, this message translates to:
  /// **'Default Repository App 22'**
  String get title22;

  /// No description provided for @title2.
  ///
  /// In en, this message translates to:
  /// **'Default Repository App 22'**
  String get title2;

  /// No description provided for @lblNoData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get lblNoData;

  /// No description provided for @lblSignup.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get lblSignup;

  /// No description provided for @lblName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get lblName;

  /// No description provided for @lblEnterName.
  ///
  /// In en, this message translates to:
  /// **'Enter user name'**
  String get lblEnterName;

  /// No description provided for @lblEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get lblEmail;

  /// No description provided for @lblPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get lblPassword;

  /// No description provided for @lblPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get lblPhone;

  /// No description provided for @lblConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get lblConfirm;

  /// No description provided for @lblHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Have account?'**
  String get lblHaveAccount;

  /// No description provided for @lblSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get lblSignIn;

  /// No description provided for @lblJoinWith.
  ///
  /// In en, this message translates to:
  /// **'Or you join with'**
  String get lblJoinWith;

  /// No description provided for @lblNameIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name is empty'**
  String get lblNameIsEmpty;

  /// No description provided for @lblEmailIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email is empty'**
  String get lblEmailIsEmpty;

  /// No description provided for @lblPasswordIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password is empty'**
  String get lblPasswordIsEmpty;

  /// No description provided for @lblPhoneIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Phone is empty'**
  String get lblPhoneIsEmpty;

  /// No description provided for @lblNameBadFormat.
  ///
  /// In en, this message translates to:
  /// **'Name in bad format'**
  String get lblNameBadFormat;

  /// No description provided for @lblEmailBadFormat.
  ///
  /// In en, this message translates to:
  /// **'Email in bad format'**
  String get lblEmailBadFormat;

  /// No description provided for @lblLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get lblLogin;

  /// No description provided for @lblPhoneValidate.
  ///
  /// In en, this message translates to:
  /// **'Your Phone must be 11 digit'**
  String get lblPhoneValidate;

  /// No description provided for @lblPasswordValidate.
  ///
  /// In en, this message translates to:
  /// **'Your password must be more than 6 character'**
  String get lblPasswordValidate;

  /// No description provided for @lblIsForgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget password?'**
  String get lblIsForgetPassword;

  /// No description provided for @lblForgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget password'**
  String get lblForgetPassword;

  /// No description provided for @lblDoNotHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Haven’t account?'**
  String get lblDoNotHaveAccount;

  /// No description provided for @lblCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get lblCurrentPassword;

  /// No description provided for @lblNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get lblNewPassword;

  /// No description provided for @lblConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get lblConfirmPassword;

  /// No description provided for @lblPhoneOtpIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'OTP is empty'**
  String get lblPhoneOtpIsEmpty;

  /// No description provided for @lblLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading . . .'**
  String get lblLoading;

  /// No description provided for @lblPasswordMustBeMoreThan.
  ///
  /// In en, this message translates to:
  /// **'The password should not be less than 8 letters and numbers'**
  String get lblPasswordMustBeMoreThan;

  /// No description provided for @lblPleaseConfirmOnTerms.
  ///
  /// In en, this message translates to:
  /// **'Agree to the terms and conditions'**
  String get lblPleaseConfirmOnTerms;

  /// No description provided for @lblCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get lblCreateAccount;

  /// No description provided for @lblOutTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Our Terms and Conditions'**
  String get lblOutTermsAndConditions;

  /// No description provided for @lblAccept.
  ///
  /// In en, this message translates to:
  /// **'I Accept'**
  String get lblAccept;

  /// No description provided for @lblPasswordDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Re-type password don`t match password'**
  String get lblPasswordDontMatch;

  /// No description provided for @lblRetypePassword.
  ///
  /// In en, this message translates to:
  /// **'Re-type Password'**
  String get lblRetypePassword;

  /// No description provided for @lblComplexPasswordValidationUpperAndLower.
  ///
  /// In en, this message translates to:
  /// **'Password Should have lower and Upper case Characters'**
  String get lblComplexPasswordValidationUpperAndLower;

  /// No description provided for @lblComplexPasswordValidationSc.
  ///
  /// In en, this message translates to:
  /// **'Password Should have Special Characters'**
  String get lblComplexPasswordValidationSc;

  /// No description provided for @lblEnterComplexPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Complex Password'**
  String get lblEnterComplexPassword;

  /// No description provided for @lblNameLength.
  ///
  /// In en, this message translates to:
  /// **'Name Length must be more than one character'**
  String get lblNameLength;

  /// No description provided for @lblAddProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Add Profile Picture'**
  String get lblAddProfilePicture;

  /// No description provided for @lblOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get lblOptional;

  /// No description provided for @lblRemoveImage.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get lblRemoveImage;

  /// No description provided for @lblSignUpSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get lblSignUpSuccess;

  /// No description provided for @lblProfileUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile update successfully'**
  String get lblProfileUpdateSuccess;

  /// No description provided for @lblChangePasswordUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password Change successfully'**
  String get lblChangePasswordUpdateSuccess;

  /// No description provided for @lblCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get lblCamera;

  /// No description provided for @lblGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get lblGallery;

  /// No description provided for @lblTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a picture'**
  String get lblTakePhoto;

  /// No description provided for @lblCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get lblCancel;

  /// No description provided for @lblWrongHappen.
  ///
  /// In en, this message translates to:
  /// **'Something wrong happen'**
  String get lblWrongHappen;

  /// No description provided for @lblSendYou.
  ///
  /// In en, this message translates to:
  /// **'We will send you'**
  String get lblSendYou;

  /// No description provided for @lblVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'a verification code to your email address'**
  String get lblVerificationCode;

  /// No description provided for @lblSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get lblSubmit;

  /// No description provided for @lblEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get lblEnterEmail;

  /// No description provided for @lblVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get lblVerify;

  /// No description provided for @lblEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get lblEnterPassword;

  /// No description provided for @lblCreateNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create a new Password'**
  String get lblCreateNewPassword;

  /// No description provided for @lblEnterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get lblEnterVerificationCode;

  /// No description provided for @lblSendToYourEmail.
  ///
  /// In en, this message translates to:
  /// **'A message has been sent to a mobile number'**
  String get lblSendToYourEmail;

  /// No description provided for @lblVerificationCodeSt.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get lblVerificationCodeSt;

  /// No description provided for @lblSecond.
  ///
  /// In en, this message translates to:
  /// **'Sec'**
  String get lblSecond;

  /// No description provided for @lblDontRecieveCode.
  ///
  /// In en, this message translates to:
  /// **'Don’t receive code? '**
  String get lblDontRecieveCode;

  /// No description provided for @lblResend.
  ///
  /// In en, this message translates to:
  /// **'Re-send'**
  String get lblResend;

  /// No description provided for @lblRetry.
  ///
  /// In en, this message translates to:
  /// **'retry'**
  String get lblRetry;

  /// No description provided for @lblNotification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get lblNotification;

  /// No description provided for @lblClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get lblClearAll;

  /// No description provided for @lblNoNotification.
  ///
  /// In en, this message translates to:
  /// **'No Notification Found'**
  String get lblNoNotification;

  /// No description provided for @lblNoNotificationDescription.
  ///
  /// In en, this message translates to:
  /// **'you do not have any notification yet'**
  String get lblNoNotificationDescription;

  /// No description provided for @lblEnterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter the mobile number'**
  String get lblEnterPhoneNumber;

  /// No description provided for @lblHello.
  ///
  /// In en, this message translates to:
  /// **'Hello ,'**
  String get lblHello;

  /// No description provided for @lblHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get lblHome;

  /// No description provided for @lblEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get lblEdit;

  /// No description provided for @lblDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get lblDeleteAccount;

  /// No description provided for @lblDeleteThisAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you wish to delete your Account\nDeleting your account removes all your \ninformation and requests'**
  String get lblDeleteThisAccount;

  /// No description provided for @lblYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get lblYes;

  /// No description provided for @lblNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get lblNo;

  /// No description provided for @lblChangePassWord.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get lblChangePassWord;

  /// No description provided for @lblLogOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get lblLogOut;

  /// No description provided for @lblIsLogOut.
  ///
  /// In en, this message translates to:
  /// **'Do you want to log out ?'**
  String get lblIsLogOut;

  /// No description provided for @lblOldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get lblOldPassword;

  /// No description provided for @lblSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get lblSave;

  /// No description provided for @lblNoResultFound.
  ///
  /// In en, this message translates to:
  /// **'No result found'**
  String get lblNoResultFound;

  /// No description provided for @lblCallSupport.
  ///
  /// In en, this message translates to:
  /// **'Call Support'**
  String get lblCallSupport;

  /// No description provided for @lbCallSupportDesc.
  ///
  /// In en, this message translates to:
  /// **'Is there any problem , and you want to call support'**
  String get lbCallSupportDesc;

  /// No description provided for @lblEGP.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get lblEGP;

  /// No description provided for @lblOldRequest.
  ///
  /// In en, this message translates to:
  /// **'Previous request'**
  String get lblOldRequest;

  /// No description provided for @lblAddRating.
  ///
  /// In en, this message translates to:
  /// **'Add Rating'**
  String get lblAddRating;

  /// No description provided for @lblCancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get lblCancelRequest;

  /// No description provided for @lblRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get lblRating;

  /// No description provided for @lblTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get lblTotal;

  /// No description provided for @lblAddRate.
  ///
  /// In en, this message translates to:
  /// **'Add rating'**
  String get lblAddRate;

  /// No description provided for @lblHowWas.
  ///
  /// In en, this message translates to:
  /// **'how was'**
  String get lblHowWas;

  /// No description provided for @lblOption.
  ///
  /// In en, this message translates to:
  /// **'option'**
  String get lblOption;

  /// No description provided for @lblSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get lblSend;

  /// No description provided for @lblRatingError.
  ///
  /// In en, this message translates to:
  /// **'This filed is required'**
  String get lblRatingError;

  /// No description provided for @lblOldPasswordDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'the old password must be not equal the new password'**
  String get lblOldPasswordDoNotMatch;

  /// No description provided for @lblAccountActivated.
  ///
  /// In en, this message translates to:
  /// **'The Account Activated successfully'**
  String get lblAccountActivated;

  /// No description provided for @lblTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get lblTo;

  /// No description provided for @lblMinute.
  ///
  /// In en, this message translates to:
  /// **'Minute'**
  String get lblMinute;

  /// No description provided for @lblUpdateRequest.
  ///
  /// In en, this message translates to:
  /// **'If the request didn\'t change click here'**
  String get lblUpdateRequest;

  /// No description provided for @lblNewPasswordSet.
  ///
  /// In en, this message translates to:
  /// **'Your password have been reset'**
  String get lblNewPasswordSet;

  /// No description provided for @lblSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get lblSearchTitle;

  /// No description provided for @lblCheckInternet.
  ///
  /// In en, this message translates to:
  /// **'please check your internet connection and try again'**
  String get lblCheckInternet;

  /// No description provided for @lblSearchHere.
  ///
  /// In en, this message translates to:
  /// **'Search here . . .'**
  String get lblSearchHere;

  /// No description provided for @lblNoResultFount.
  ///
  /// In en, this message translates to:
  /// **'No result found'**
  String get lblNoResultFount;

  /// No description provided for @lblAdjustYourSearch.
  ///
  /// In en, this message translates to:
  /// **'Please adjust your search'**
  String get lblAdjustYourSearch;

  /// No description provided for @lblMarkAsRead.
  ///
  /// In en, this message translates to:
  /// **'mark as read'**
  String get lblMarkAsRead;

  /// No description provided for @lblDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get lblDelete;

  /// No description provided for @lblTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get lblTermsAndConditions;

  /// No description provided for @lblSetting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get lblSetting;

  /// No description provided for @lblMyAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get lblMyAccount;

  /// No description provided for @lblAppSetting.
  ///
  /// In en, this message translates to:
  /// **'Account setting'**
  String get lblAppSetting;

  /// No description provided for @lblProfileSetting.
  ///
  /// In en, this message translates to:
  /// **'Profile Setting'**
  String get lblProfileSetting;

  /// No description provided for @lblSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get lblSelectLanguage;

  /// No description provided for @lblArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get lblArabic;

  /// No description provided for @lblFAQ.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get lblFAQ;

  /// No description provided for @lblQuestionNotFound.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t find your question ?'**
  String get lblQuestionNotFound;

  /// No description provided for @lblOpenTicket.
  ///
  /// In en, this message translates to:
  /// **'Open ticket'**
  String get lblOpenTicket;

  /// No description provided for @lblNoQuestionFound.
  ///
  /// In en, this message translates to:
  /// **'No Question found'**
  String get lblNoQuestionFound;

  /// No description provided for @lblSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get lblSubject;

  /// No description provided for @lblRequestSendSuccess.
  ///
  /// In en, this message translates to:
  /// **'Request sent successfully'**
  String get lblRequestSendSuccess;

  /// No description provided for @lblSubjectIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Subject Is Empty'**
  String get lblSubjectIsEmpty;

  /// No description provided for @lblDescriptionIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Description Is Empty '**
  String get lblDescriptionIsEmpty;

  /// No description provided for @lblDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get lblDescription;

  /// No description provided for @lblSendRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get lblSendRequestTitle;

  /// No description provided for @lblHelpCenterTitle.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get lblHelpCenterTitle;

  /// No description provided for @lblHelpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help and support'**
  String get lblHelpAndSupport;

  /// No description provided for @lblEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get lblEnglish;

  /// No description provided for @lblSureToLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout your account?'**
  String get lblSureToLogout;

  /// No description provided for @lblBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get lblBack;

  /// No description provided for @lblChangeMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Change Mobile Number'**
  String get lblChangeMobileNumber;

  /// No description provided for @lblWrongPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Wrong phone number'**
  String get lblWrongPhoneNumber;

  /// No description provided for @lblOldPhone.
  ///
  /// In en, this message translates to:
  /// **'Old mobile number'**
  String get lblOldPhone;

  /// No description provided for @lblNewPhone.
  ///
  /// In en, this message translates to:
  /// **'New mobile number'**
  String get lblNewPhone;

  /// No description provided for @lblToConfirmChangingPhone.
  ///
  /// In en, this message translates to:
  /// **'To confirm changing the mobile number to '**
  String get lblToConfirmChangingPhone;

  /// No description provided for @lblEnterPasswordForAccount.
  ///
  /// In en, this message translates to:
  /// **'Enter the password for your account.'**
  String get lblEnterPasswordForAccount;

  /// No description provided for @lblChangeNumber.
  ///
  /// In en, this message translates to:
  /// **'Change Mobile Number'**
  String get lblChangeNumber;

  /// No description provided for @lblDeleteAccountPassword.
  ///
  /// In en, this message translates to:
  /// **'For your Safety and Security\nPlease, Enter your Password and click next'**
  String get lblDeleteAccountPassword;

  /// No description provided for @lblNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get lblNext;

  /// No description provided for @lblDeleteAccountNote.
  ///
  /// In en, this message translates to:
  /// **'Please, Note that\nIn case you delete your account you can not mange services and payment history'**
  String get lblDeleteAccountNote;

  /// No description provided for @lblHaveProblem.
  ///
  /// In en, this message translates to:
  /// **'Have a problem ?'**
  String get lblHaveProblem;

  /// No description provided for @lblEmptyReason.
  ///
  /// In en, this message translates to:
  /// **'There is no Reason for your action'**
  String get lblEmptyReason;

  /// No description provided for @lblDeleteAccountReasonsTitle.
  ///
  /// In en, this message translates to:
  /// **'Could you tell us why you want to delete your account'**
  String get lblDeleteAccountReasonsTitle;

  /// No description provided for @lblTicketReasonsTitle.
  ///
  /// In en, this message translates to:
  /// **'Could you tell us what is your problem ?'**
  String get lblTicketReasonsTitle;

  /// No description provided for @lblWriteNote.
  ///
  /// In en, this message translates to:
  /// **'Write Your reason'**
  String get lblWriteNote;

  /// No description provided for @lblFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'this Field Required'**
  String get lblFieldRequired;

  /// No description provided for @lblWriteYourComment.
  ///
  /// In en, this message translates to:
  /// **'Write your comments'**
  String get lblWriteYourComment;

  /// No description provided for @lblSAR.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get lblSAR;

  /// No description provided for @lblSelectReason.
  ///
  /// In en, this message translates to:
  /// **'Select Problem Reason'**
  String get lblSelectReason;

  /// No description provided for @lblProblemDes.
  ///
  /// In en, this message translates to:
  /// **'Problem description'**
  String get lblProblemDes;

  /// No description provided for @lblSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get lblSupport;

  /// No description provided for @lblIdIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'ID number is empty'**
  String get lblIdIsEmpty;

  /// No description provided for @lblIDValidate.
  ///
  /// In en, this message translates to:
  /// **'Your ID number must be 10 digit'**
  String get lblIDValidate;

  /// No description provided for @lblIDNumber.
  ///
  /// In en, this message translates to:
  /// **'Identification card number'**
  String get lblIDNumber;

  /// No description provided for @lblResendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Resend verification code,'**
  String get lblResendVerificationCode;

  /// No description provided for @lblWelcomeInRDM.
  ///
  /// In en, this message translates to:
  /// **'Welcome in RDM'**
  String get lblWelcomeInRDM;

  /// No description provided for @lblOnBoardingSub1.
  ///
  /// In en, this message translates to:
  /// **'We help you find the right truck'**
  String get lblOnBoardingSub1;

  /// No description provided for @lblOnBoardingSub2.
  ///
  /// In en, this message translates to:
  /// **'All you need to do is set your location and choose the truck type.'**
  String get lblOnBoardingSub2;

  /// No description provided for @lblOnBoardingSub3.
  ///
  /// In en, this message translates to:
  /// **'Our service providers will contact you \n as soon as possible.'**
  String get lblOnBoardingSub3;

  /// No description provided for @lblUseOurFeature.
  ///
  /// In en, this message translates to:
  /// **'Take advantage of our great features'**
  String get lblUseOurFeature;

  /// No description provided for @lblForEsayLife.
  ///
  /// In en, this message translates to:
  /// **'RDM for easy life '**
  String get lblForEsayLife;

  /// No description provided for @lblSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get lblSkip;

  /// No description provided for @lblLetsGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started'**
  String get lblLetsGetStarted;

  /// No description provided for @lblOr.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get lblOr;

  /// No description provided for @lblNewAccount.
  ///
  /// In en, this message translates to:
  /// **'New User, '**
  String get lblNewAccount;

  /// No description provided for @lblDiscoverNewOpportunities.
  ///
  /// In en, this message translates to:
  /// **'Discover unique investment opportunities'**
  String get lblDiscoverNewOpportunities;

  /// No description provided for @lblBePartOfEconomic.
  ///
  /// In en, this message translates to:
  /// **'And be part of the economic transformation'**
  String get lblBePartOfEconomic;

  /// No description provided for @lblSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get lblSaveChanges;

  /// No description provided for @lblPasswordMatchOld.
  ///
  /// In en, this message translates to:
  /// **'Current password should not match with new password'**
  String get lblPasswordMatchOld;

  /// No description provided for @lblConfirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get lblConfirmNewPassword;

  /// No description provided for @lblNewUser.
  ///
  /// In en, this message translates to:
  /// **'New user'**
  String get lblNewUser;

  /// No description provided for @lblGustUser.
  ///
  /// In en, this message translates to:
  /// **'Gust User'**
  String get lblGustUser;

  /// No description provided for @lblLoginPls.
  ///
  /// In en, this message translates to:
  /// **'Please log in'**
  String get lblLoginPls;

  /// No description provided for @lblToFullTry.
  ///
  /// In en, this message translates to:
  /// **'To get a complete user experience'**
  String get lblToFullTry;

  /// No description provided for @lblWriteProblemDes.
  ///
  /// In en, this message translates to:
  /// **'Write the problem in detail'**
  String get lblWriteProblemDes;

  /// No description provided for @lblCallUs.
  ///
  /// In en, this message translates to:
  /// **'Call with us'**
  String get lblCallUs;

  /// No description provided for @lblWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get lblWhatsApp;

  /// No description provided for @lblPhoneCall.
  ///
  /// In en, this message translates to:
  /// **'Phone Call'**
  String get lblPhoneCall;

  /// No description provided for @lblWriteHere.
  ///
  /// In en, this message translates to:
  /// **'Write your massage'**
  String get lblWriteHere;

  /// No description provided for @lblAddReport.
  ///
  /// In en, this message translates to:
  /// **'Add a Problem'**
  String get lblAddReport;

  /// No description provided for @lblYourProblems.
  ///
  /// In en, this message translates to:
  /// **'My Problems'**
  String get lblYourProblems;

  /// No description provided for @lblClosedTicket.
  ///
  /// In en, this message translates to:
  /// **'Close ticket'**
  String get lblClosedTicket;

  /// No description provided for @lblYourTickets.
  ///
  /// In en, this message translates to:
  /// **'Your tickets'**
  String get lblYourTickets;

  /// No description provided for @lblOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get lblOpen;

  /// No description provided for @lblClose.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get lblClose;

  /// No description provided for @lblMakeSureAllDataClear.
  ///
  /// In en, this message translates to:
  /// **'Make sure all data clear'**
  String get lblMakeSureAllDataClear;

  /// No description provided for @lblPhotoRestriction.
  ///
  /// In en, this message translates to:
  /// **'You can upload a maximum of 4 photos, no more than 6 MB in size'**
  String get lblPhotoRestriction;

  /// No description provided for @lblAddPic.
  ///
  /// In en, this message translates to:
  /// **'Add Picture'**
  String get lblAddPic;

  /// No description provided for @lblProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Profile Picture'**
  String get lblProfilePicture;

  /// No description provided for @lblDeleteImage.
  ///
  /// In en, this message translates to:
  /// **'Delete Image'**
  String get lblDeleteImage;

  /// No description provided for @lblMaxLengthReach.
  ///
  /// In en, this message translates to:
  /// **'You have reached the max length of images'**
  String get lblMaxLengthReach;

  /// No description provided for @lblAlreadyUser.
  ///
  /// In en, this message translates to:
  /// **'Already have an account, '**
  String get lblAlreadyUser;

  /// No description provided for @lblWelcomeAgain.
  ///
  /// In en, this message translates to:
  /// **'Welcome Again'**
  String get lblWelcomeAgain;

  /// No description provided for @lblEnjoyOurService.
  ///
  /// In en, this message translates to:
  /// **'Enjoy with us distinctive and fast calls to transport your belongings easily.'**
  String get lblEnjoyOurService;

  /// No description provided for @lblWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get lblWelcome;

  /// No description provided for @lblCodeWillSendToPhone.
  ///
  /// In en, this message translates to:
  /// **'A confirmation code will be sent to your mobile number'**
  String get lblCodeWillSendToPhone;

  /// No description provided for @lblResendVerification.
  ///
  /// In en, this message translates to:
  /// **'Resend verification code, '**
  String get lblResendVerification;

  /// No description provided for @lblContainers.
  ///
  /// In en, this message translates to:
  /// **'Truck'**
  String get lblContainers;

  /// No description provided for @lblCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get lblCart;

  /// No description provided for @lblRDM.
  ///
  /// In en, this message translates to:
  /// **'ردم  RDM'**
  String get lblRDM;

  /// No description provided for @lblWeMoveYourContainer.
  ///
  /// In en, this message translates to:
  /// **'Reliable truck transport'**
  String get lblWeMoveYourContainer;

  /// No description provided for @lblSeeMore.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get lblSeeMore;

  /// No description provided for @lblOrder.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get lblOrder;

  /// No description provided for @lblAboutProduct.
  ///
  /// In en, this message translates to:
  /// **'About Service'**
  String get lblAboutProduct;

  /// No description provided for @lblCurrency.
  ///
  /// In en, this message translates to:
  /// **'RS'**
  String get lblCurrency;

  /// No description provided for @lblAddress.
  ///
  /// In en, this message translates to:
  /// **'Saved Address'**
  String get lblAddress;

  /// No description provided for @lblAddAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get lblAddAddress;

  /// No description provided for @lblNoAddressYet.
  ///
  /// In en, this message translates to:
  /// **'No Address Yet'**
  String get lblNoAddressYet;

  /// No description provided for @lblAddYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter your current location'**
  String get lblAddYourLocation;

  /// No description provided for @lblAddNewAddressDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the site where you want to request the service, and we will provide you with our services as soon as possible.'**
  String get lblAddNewAddressDesc;

  /// No description provided for @lblPickLocation.
  ///
  /// In en, this message translates to:
  /// **'Pick location'**
  String get lblPickLocation;

  /// No description provided for @lblAddressName.
  ///
  /// In en, this message translates to:
  /// **'Address Name'**
  String get lblAddressName;

  /// No description provided for @lblYouMustPickALocation.
  ///
  /// In en, this message translates to:
  /// **'You must pick a location'**
  String get lblYouMustPickALocation;

  /// No description provided for @lblAddressNameIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Address name is empty'**
  String get lblAddressNameIsEmpty;

  /// No description provided for @lblAddressDescription.
  ///
  /// In en, this message translates to:
  /// **'Add the address \n for quick access later'**
  String get lblAddressDescription;

  /// No description provided for @lblNoAddress.
  ///
  /// In en, this message translates to:
  /// **'No Address'**
  String get lblNoAddress;

  /// No description provided for @lblYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your Location '**
  String get lblYourLocation;

  /// No description provided for @lblOrderService.
  ///
  /// In en, this message translates to:
  /// **'Order Service'**
  String get lblOrderService;

  /// No description provided for @lblOrderNow.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get lblOrderNow;

  /// No description provided for @lblDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get lblDate;

  /// No description provided for @lblOrderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get lblOrderDetails;

  /// No description provided for @lblOrderDate.
  ///
  /// In en, this message translates to:
  /// **'Service Order Date'**
  String get lblOrderDate;

  /// No description provided for @lblOrderAddress.
  ///
  /// In en, this message translates to:
  /// **'Service Order Address'**
  String get lblOrderAddress;

  /// No description provided for @lblYourOrderSend.
  ///
  /// In en, this message translates to:
  /// **'Your order has been sent successfully'**
  String get lblYourOrderSend;

  /// No description provided for @lblThxFromRDM.
  ///
  /// In en, this message translates to:
  /// **'Thank you for using RDM'**
  String get lblThxFromRDM;

  /// No description provided for @lblYouMustPickADate.
  ///
  /// In en, this message translates to:
  /// **'You must pick a date'**
  String get lblYouMustPickADate;

  /// No description provided for @lblMyOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get lblMyOrders;

  /// No description provided for @lblNoOrders.
  ///
  /// In en, this message translates to:
  /// **'There is No Orders'**
  String get lblNoOrders;

  /// No description provided for @lblNoOrdersDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the service \n and we will reach you wherever you are'**
  String get lblNoOrdersDescription;

  /// No description provided for @lblCurrentOrder.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get lblCurrentOrder;

  /// No description provided for @lblOld.
  ///
  /// In en, this message translates to:
  /// **'Old'**
  String get lblOld;

  /// No description provided for @lblQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get lblQuantity;

  /// No description provided for @lblCancelMyOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel My Order'**
  String get lblCancelMyOrder;

  /// No description provided for @lblOrderStatus.
  ///
  /// In en, this message translates to:
  /// **'Order Status : '**
  String get lblOrderStatus;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

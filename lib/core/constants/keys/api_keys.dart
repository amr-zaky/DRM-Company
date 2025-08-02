class ApiKeys {
  /// user type key
  static const String userTypeKey = "/provider";

  ///Auth Keys
  static const String loginKey = "$userTypeKey/login";
  static const String singUpKey = "$userTypeKey/register";
  static const String logOutKey = "$userTypeKey/logout";

  ///profile keys
  static const String profileKey = "$userTypeKey/profile";
  static const String updateProfileKey = "$userTypeKey/profile/update";
  static const String deleteProfileKey = "$userTypeKey/profile/deleteAccount";
  static const String deletePhotoProfileKey = "$userTypeKey/delete-image";
  static const String checkPasswordKey = "$userTypeKey/profile/checkPassword";

  ///Password keys
  static const String changePasswordKey = "$userTypeKey/changePassword";
  static const String forgetPasswordKey = "$userTypeKey/sendOtp";
  static const String resetPasswordKey = "$userTypeKey/resetPassword";

  ///Otp Keys
  static const String checkAndVerifyKey = "$userTypeKey/checkOtpAndActivate";
  static const String checkOtpKey = "$userTypeKey/checkOtp";
  static const String reSendOtpKey = "$userTypeKey/sendOtp";

  ///notification keys
  static const String notificationKey = "/notifications";
  static const String clearNotificationKey = "$notificationKey/clear";
  static const String toggleNotificationKey = "$notificationKey/toggle";
  static const String readNotificationKey = "/read";

  ///Setting keys
  static const String termsKey = "/terms";
  static const String faqKey = "/faqs";
  static const String contactKey = "/contact_us";
  static const String questionKey = "/question";
  static const String answerKey = "/question/answer";

  ///product
  static const String productKey = "/product";

  static const String addressKey = "/account-address";

  static const String orderKey = "/order";
  static const String orderCurrentKey = "/companyOrders/current";
  static const String orderHistoryKey = "/companyOrders/history";
  static const String offerKey = "/companyOrders/offer";
  static const String updateOrderKey = "/companyOrders";


  static const String rateKey = "/rate/store";



  ///Setting
  static const String settingKey = "/setting";
  static const String termsAndConditionsPageKey = "/cms_page/2";
  static const String aboutUsPageKey = "/cms_page/1";
  static const String policyPageKey = "/cms_page/3";

  /// Phone
  static const String changePhoneKey = '$userTypeKey/profile/changePhone';

  /// Reasons
  static const String reasonsKey = '/ticket_category';

  ///ticket keys
  static const String ticketList = "/ticket";
  static const String ticketComments = "/ticket_message";
  static const String ticketCategory = "/ticket_category";
  static const String openTicket = "/ticket";
  static const String addComment = "/ticket_message";
}

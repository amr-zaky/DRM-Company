import 'package:base_project_repo/features/address_feature/presentation/add_new_address.dart';
import 'package:base_project_repo/features/address_feature/presentation/addresses_screen.dart';
import 'package:base_project_repo/features/order_feature/presentation/screen/confirm_order_screen.dart';
import 'package:base_project_repo/features/order_feature/presentation/screen/offer_details_screen.dart';
import 'package:base_project_repo/features/order_feature/presentation/screen/order_details_screen.dart';
import 'package:base_project_repo/features/product_feature/presentation/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth_feature/OTP_feature/presentation/screens/verification_code_screen.dart';
import '../../../features/auth_feature/delete_account_feature/presentation/screens/delete_account_enter_password_screen.dart';
import '../../../features/auth_feature/delete_account_feature/presentation/screens/delete_account_note_screen.dart';
import '../../../features/auth_feature/delete_account_feature/presentation/screens/delete_account_reasons_screen.dart';
import '../../../features/auth_feature/login_feature/presentation/screens/login_home_page.dart';
import '../../../features/auth_feature/onBoarding_feature/presentation/screen/on_boarding_screen.dart';
import '../../../features/auth_feature/password_feature/presentation/screens/chanage_password_screen.dart';
import '../../../features/auth_feature/password_feature/presentation/screens/forget_password_screen.dart';
import '../../../features/auth_feature/password_feature/presentation/screens/new_password_screen.dart';
import '../../../features/auth_feature/phone_feature/presentation/screens/change_phone_number_screen.dart';
import '../../../features/auth_feature/profile_feature/presentation/screens/profile_screen.dart';
import '../../../features/auth_feature/sign_up_feature/presentation/screens/sign_up_screen.dart';
import '../../../features/auth_feature/splash_feature/presentation/screens/splash_screen_home_page.dart';
import '../../../features/help_feature/Presentation/screen/add_contact_screen.dart';
import '../../../features/help_feature/Presentation/screen/help_support_screen.dart';
import '../../../features/help_feature/Presentation/screen/questions_screen.dart';
import '../../../features/notification_feature/presentation/notification_screen.dart';
import '../../../features/setting_feature/presentation/Screen/account_settings_home_page.dart';
import '../../../features/setting_feature/presentation/Screen/setting_page_screen.dart';
import '../../../features/ticket_feature/Presentation/screen/chat_screen.dart';
import '../../../features/ticket_feature/Presentation/screen/open_ticket_screen.dart';
import '../../../features/ticket_feature/Presentation/screen/ticket_screen.dart';
import '../../feature/bottom_nav/screen/bottom_nav_bar.dart';
import '../../feature/download_pdf/screen/pdf_view_home_page.dart';
import 'route_animation.dart';
import 'route_argument.dart';
import 'route_names.dart';

final GoRouter router = GoRouter(
  initialLocation: RouteNames.splashPageRoute,
  routes: <RouteBase>[
    GoRoute(
      path: RouteNames.splashPageRoute,
      name: RouteNames.splashPageRoute,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          RouteAnimation.animatedPageFromCenterRightToCenterLeft(
              state, const SplashHomePage()),
    ),
    GoRoute(
      path: RouteNames.onBoardingPageRoute,
      name: RouteNames.onBoardingPageRoute,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          RouteAnimation.animatedPageFromCenterRightToCenterLeft(state,
              OnBoardingScreen(routeArgument: state.extra as RouteArgument)),
    ),
    GoRoute(
        path: RouteNames.loginHomePageRoute,
        name: RouteNames.loginHomePageRoute,
        routes: <RouteBase>[
          GoRoute(
              path: RouteNames.forgetPasswordPageRoute,
              name: RouteNames.forgetPasswordPageRoute,
              routes: <RouteBase>[
                GoRoute(
                    path: RouteNames.newPasswordPageRoute,
                    name: RouteNames.newPasswordPageRoute,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                            state,
                            NewPasswordScreen(
                              routeArgument: state.extra as RouteArgument,
                            ))),
              ],
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                      state, const ForgetPasswordScreen())),
          GoRoute(
              path: RouteNames.singUpPageRoute,
              name: RouteNames.singUpPageRoute,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                      state, const SignUpPage())),
          GoRoute(
              path: RouteNames.verificationCodePageRoute,
              name: RouteNames.verificationCodePageRoute,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                    state,
                    VerificationCodeScreen(
                      routeArgument: state.extra as RouteArgument,
                    ));
              })
        ],
        pageBuilder: (BuildContext context, GoRouterState state) =>
            RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                state, const LoginHomePage())),
    GoRoute(
        path: RouteNames.mainBottomNavPageRoute,
        name: RouteNames.mainBottomNavPageRoute,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                state, const BottomNavBar())),
    GoRoute(
        path: RouteNames.notificationPageRoute,
        name: RouteNames.notificationPageRoute,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                state, const NotificationListScreen())),
    GoRoute(
        path: RouteNames.profilePageRoute,
        name: RouteNames.profilePageRoute,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                state, const ProfileScreen())),
    GoRoute(
      path: RouteNames.settingPageRoute,
      name: RouteNames.settingPageRoute,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          RouteAnimation.animatedPageFromCenterRightToCenterLeft(
              state,
              SettingPageScreen(
                routeArgument: state.extra as RouteArgument,
              )),
    ),
    GoRoute(
        path: RouteNames.accountSettingPageRoute,
        name: RouteNames.accountSettingPageRoute,
        routes: <RouteBase>[
          GoRoute(
              path: RouteNames.changePasswordPageRoute,
              name: RouteNames.changePasswordPageRoute,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                      state, const ChangePasswordScreen())),
          GoRoute(
              path: RouteNames.changePhoneNumberScreenRoute,
              name: RouteNames.changePhoneNumberScreenRoute,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                      state, const ChangePhoneNumberScreen())),
          GoRoute(
              path: RouteNames.deleteAccountNoteScreenRoute,
              name: RouteNames.deleteAccountNoteScreenRoute,
              routes: <RouteBase>[
                GoRoute(
                    path: RouteNames.deleteAccountEnterPasswordScreenRoute,
                    name: RouteNames.deleteAccountEnterPasswordScreenRoute,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                            state, const DeleteAccountEnterPasswordScreen())),
                GoRoute(
                    path: RouteNames.deleteAccountReasonRoute,
                    name: RouteNames.deleteAccountReasonRoute,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                            state, const DeleteAccountReasonScreen())),
              ],
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                      state, const DeleteAccountNoteScreen())),
        ],
        pageBuilder: (BuildContext context, GoRouterState state) =>
            RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                state, const AccountSettingsHomePage())),
    GoRoute(
        path: RouteNames.helpAndSupportPageRoute,
        name: RouteNames.helpAndSupportPageRoute,
        routes: <RouteBase>[
          GoRoute(
              path: RouteNames.contactPageRoute,
              name: RouteNames.contactPageRoute,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                      state, const ContactScreen())),
          GoRoute(
              path: RouteNames.questionsPageRoute,
              name: RouteNames.questionsPageRoute,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                      state, const FAQScreen())),
          GoRoute(
              path: RouteNames.ticketListPageRoute,
              name: RouteNames.ticketListPageRoute,
              routes: <RouteBase>[
                GoRoute(
                    path: RouteNames.ticketChatPageRoute,
                    name: RouteNames.ticketChatPageRoute,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                            state,
                            TicketChat(
                              routeArgument: state.extra as RouteArgument,
                            ))),
                GoRoute(
                    path: RouteNames.openTicketPageRoute,
                    name: RouteNames.openTicketPageRoute,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                            state, const OpenTicketScreen())),
              ],
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                      state, const TicketsScreen())),
        ],
        pageBuilder: (BuildContext context, GoRouterState state) =>
            RouteAnimation.animatedPageFromCenterRightToCenterLeft(
                state, const HelpAndSupportScreen())),
    GoRoute(
      path: RouteNames.documentPageRoute,
      name: RouteNames.documentPageRoute,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          RouteAnimation.animatedPageFromCenterRightToCenterLeft(
              state,
              PdfViewHomePage(
                routeArgument: state.extra as RouteArgument,
              )),
    ),
    GoRoute(
      path: RouteNames.productDetailsPageRoute,
      name: RouteNames.productDetailsPageRoute,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          RouteAnimation.animatedPageFromCenterRightToCenterLeft(
              state,
              ProductDetailsScreen(
                routeArgument: state.extra as RouteArgument,
              )),
    ),
    GoRoute(
      path: RouteNames.addNewAddressPageRoute,
      name: RouteNames.addNewAddressPageRoute,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          RouteAnimation.animatedPageFromCenterRightToCenterLeft(
              state,
              AddNewAddressScreen(
                routeArgument: state.extra as RouteArgument,
              )),
    ),
    GoRoute(
      path: RouteNames.addressPageRoute,
      name: RouteNames.addressPageRoute,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          RouteAnimation.animatedPageFromCenterRightToCenterLeft(
              state, const AddressScreen()),
    ),
    GoRoute(
      path: RouteNames.orderConfirmPageRoute,
      name: RouteNames.orderConfirmPageRoute,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          RouteAnimation.animatedPageFromCenterRightToCenterLeft(
              state, const ConfirmOrdersScreen()),
    ),
    GoRoute(
      path: RouteNames.orderDetailsPageRoute,
      name: RouteNames.orderDetailsPageRoute,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          RouteAnimation.animatedPageFromCenterRightToCenterLeft(
              state,
              OrdersDetailsScreen(
                routeArgument: state.extra as RouteArgument,
              )),
    ),
    GoRoute(
      path: RouteNames.offerDetailsPageRoute,
      name: RouteNames.offerDetailsPageRoute,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          RouteAnimation.animatedPageFromCenterRightToCenterLeft(
              state,
              OfferDetailsScreen(
                routeArgument: state.extra as RouteArgument,
              )),
    ),
  ],
);

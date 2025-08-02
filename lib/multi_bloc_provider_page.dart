import 'package:base_project_repo/features/address_feature/presentation/logic/add_address_cubit/add_address_cubit.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/home_address_cubit/home_address_cubit.dart';
import 'package:base_project_repo/features/home_feature/logic/home_offers_cubit/home_offer_cubit.dart';
import 'package:base_project_repo/features/home_feature/logic/home_orders_cubit/home_order_cubit.dart';
import 'package:base_project_repo/features/order_feature/presentation/logic/offers_cubit/offer_cubit.dart';
import 'package:base_project_repo/features/product_feature/presentation/logic/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/feature/bottom_nav/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import 'core/feature/download_pdf/logic/download_file_cubit.dart';
import 'core/feature/filter_feature/presentation/logic/search_filter_cubit/search_filter_cubit.dart';
import 'core/feature/pick_multi_image/presentation/logic/pick_image_cubit.dart';
import 'features/address_feature/presentation/logic/address_cubit/address_cubit.dart';
import 'features/auth_feature/OTP_feature/presentation/logic/otp_cubit/otp_cubit.dart';
import 'features/auth_feature/OTP_feature/presentation/logic/timer_cubit/timer_cubit.dart';
import 'features/auth_feature/delete_account_feature/presentation/logic/delete_account_cubit.dart';
import 'features/auth_feature/login_feature/presentation/logic/login_cubit/login_cubit.dart';
import 'features/auth_feature/logout_feature/presentation/logic/logout_cubit/logout_cubit.dart';
import 'features/auth_feature/onBoarding_feature/presentation/logic/on_boarding_cubit/on_boarding_cubit.dart';
import 'features/auth_feature/password_feature/presentation/logic/password_cubit/password_cubit.dart';
import 'features/auth_feature/phone_feature/presentation/logic/phone_cubit/phone_cubit.dart';
import 'features/auth_feature/profile_feature/presentation/logic/profile_cubit/profile_cubit.dart';
import 'features/auth_feature/sign_up_feature/presentation/logic/sign_up_cubit/sign_up_cubit.dart';
import 'features/auth_feature/splash_feature/presentation/logic/splash_cubit/splash_cubit.dart';
import 'features/help_feature/Presentation/logic/help_cubit/help_cubit.dart';
import 'features/language_feature/presentation/logic/language_cubit/language_cubit.dart';
import 'features/notification_feature/presentation/logic/notification_cubit.dart';
import 'features/order_feature/presentation/logic/create_order_cubit/create_order_cubit.dart';
import 'features/order_feature/presentation/logic/orders_cubit/order_cubit.dart';
import 'features/order_feature/presentation/logic/update_order_cubit/update_order_cubit.dart';
import 'features/pick_location_feature/presentation/logic/Recommendation_Place/recommendation_place_cubit.dart';
import 'features/pick_location_feature/presentation/logic/google_map_Cubit/google_map_cubit.dart';
import 'features/setting_feature/presentation/logic/setting_cubit/setting_cubit.dart';
import 'features/ticket_feature/Presentation/logic/ticket_chat_cubit/ticket_chat_cubit.dart';
import 'features/ticket_feature/Presentation/logic/ticket_cubit/ticket_cubit.dart';
import 'injection_container.dart' as di;

class MultiBlocProvidersPage extends StatefulWidget {
  const MultiBlocProvidersPage({Key? key, required this.body})
      : super(key: key);
  final Widget body;

  @override
  State<StatefulWidget> createState() => _MultiBlocProvidersPageState();
}

class _MultiBlocProvidersPageState extends State<MultiBlocProvidersPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // ignore: always_specify_types
      providers: [
        BlocProvider<LangCubit>(
            lazy: false, create: (_) => di.sl<LangCubit>()..getLang()),
        BlocProvider<SplashCubit>(create: (_) => di.sl<SplashCubit>()),
        BlocProvider<OnBoardingCubit>(create: (_) => di.sl<OnBoardingCubit>()),
        BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
        BlocProvider<LogoutCubit>(create: (_) => di.sl<LogoutCubit>()),
        BlocProvider<DeleteAccountCubit>(
            create: (_) => di.sl<DeleteAccountCubit>()),
        BlocProvider<SignUpCubit>(create: (_) => di.sl<SignUpCubit>()),
        BlocProvider<TimerCubit>(create: (_) => di.sl<TimerCubit>()),
        BlocProvider<OtpCubit>(create: (_) => di.sl<OtpCubit>()),
        BlocProvider<PasswordCubit>(create: (_) => di.sl<PasswordCubit>()),
        BlocProvider<BottomNavCubit>(create: (_) => di.sl<BottomNavCubit>()),
        BlocProvider<HelpCubit>(create: (_) => di.sl<HelpCubit>()),
        BlocProvider<ProfileCubit>(create: (_) => di.sl<ProfileCubit>()),
        BlocProvider<SettingCubit>(
            lazy: false, create: (_) => di.sl<SettingCubit>()..getSetting()),
        BlocProvider<PhoneCubit>(create: (_) => di.sl<PhoneCubit>()),
        BlocProvider<NotificationCubit>(
            create: (_) => di.sl<NotificationCubit>()),
        BlocProvider<TicketChatCubit>(create: (_) => di.sl<TicketChatCubit>()),
        BlocProvider<TicketCubit>(create: (_) => di.sl<TicketCubit>()),
        BlocProvider<AllFilterCubit>(create: (_) => di.sl<AllFilterCubit>()),
        BlocProvider<PickImageCubit>(create: (_) => di.sl<PickImageCubit>()),
        BlocProvider<DownloadFileCubit>(
            create: (_) => di.sl<DownloadFileCubit>()),
        BlocProvider<ProductCubit>(
          create: (_) => di.sl<ProductCubit>(),
        ),
        BlocProvider<HomeAddressCubit>(
          create: (_) => di.sl<HomeAddressCubit>(),
        ),
        BlocProvider<AddressCubit>(
          create: (_) => di.sl<AddressCubit>(),
        ),
        BlocProvider<OrderCubit>(
          create: (_) => di.sl<OrderCubit>(),
        ),
        BlocProvider<UpdateOrderCubit>(
          create: (_) => di.sl<UpdateOrderCubit>(),
        ),
        BlocProvider<OfferCubit>(
          create: (_) => di.sl<OfferCubit>(),
        ),
        BlocProvider<HomeOrderCubit>(
          create: (_) => di.sl<HomeOrderCubit>(),
        ),
        BlocProvider<HomeOfferCubit>(
          create: (_) => di.sl<HomeOfferCubit>(),
        ),
        BlocProvider<AddNewAddressCubit>(
          create: (_) => di.sl<AddNewAddressCubit>(),
        ),
        BlocProvider<GoogleMapCubit>(create: (_) => di.sl<GoogleMapCubit>()),
        BlocProvider<CreateOrderCubit>(
            create: (_) => di.sl<CreateOrderCubit>()),
        BlocProvider<RecommendationPlaceCubit>(
            create: (_) => di.sl<RecommendationPlaceCubit>()),
      ],
      child: widget.body,
    );
  }
}

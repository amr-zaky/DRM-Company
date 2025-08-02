import 'package:base_project_repo/features/home_feature/home_injector.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/data_source/local_source/auth_local_data_source.dart';
import 'core/feature/bottom_nav/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import 'core/feature/download_pdf/logic/download_file_cubit.dart';
import 'core/feature/filter_feature/presentation/logic/search_filter_cubit/search_filter_cubit.dart';
import 'core/feature/pick_multi_image/presentation/logic/pick_image_cubit.dart';
import 'core/helpers/connectivity/connection_checker.dart';
import 'features/address_feature/address_ingector.dart';
import 'features/auth_feature/OTP_feature/data/data_source/otp_remote_data_source.dart';
import 'features/auth_feature/OTP_feature/data/repository/otp_repository.dart';
import 'features/auth_feature/OTP_feature/domain/interface/otp_interface.dart';
import 'features/auth_feature/OTP_feature/domain/use_cases/otp_ues_cases.dart';
import 'features/auth_feature/OTP_feature/presentation/logic/otp_cubit/otp_cubit.dart';
import 'features/auth_feature/OTP_feature/presentation/logic/timer_cubit/timer_cubit.dart';
import 'features/auth_feature/delete_account_feature/data/data_source/delete_account_data_sources.dart';
import 'features/auth_feature/delete_account_feature/data/repository/delete_account_repository.dart';
import 'features/auth_feature/delete_account_feature/domain/repository/delete_account_interface.dart';
import 'features/auth_feature/delete_account_feature/domain/use_cases/delete_account_use_case.dart';
import 'features/auth_feature/delete_account_feature/presentation/logic/delete_account_cubit.dart';
import 'features/auth_feature/login_feature/data/data_source/login_remote_data_source.dart';
import 'features/auth_feature/login_feature/data/repository/login_repository.dart';
import 'features/auth_feature/login_feature/domain/interface/login_interface.dart';
import 'features/auth_feature/login_feature/domain/use_cases/login_use_case.dart';
import 'features/auth_feature/login_feature/presentation/logic/login_cubit/login_cubit.dart';
import 'features/auth_feature/logout_feature/data/data_source/logout_remote_data_source.dart';
import 'features/auth_feature/logout_feature/data/repository/logout_repository.dart';
import 'features/auth_feature/logout_feature/domain/interface/logout_interface.dart';
import 'features/auth_feature/logout_feature/domain/use_cases/logout_use_case.dart';
import 'features/auth_feature/logout_feature/presentation/logic/logout_cubit/logout_cubit.dart';
import 'features/auth_feature/onBoarding_feature/data/repository/on_boarding_repository.dart';
import 'features/auth_feature/onBoarding_feature/domain/interface/on_boarding_interface.dart';
import 'features/auth_feature/onBoarding_feature/domain/use_cases/use_case.dart';
import 'features/auth_feature/onBoarding_feature/presentation/logic/on_boarding_cubit/on_boarding_cubit.dart';
import 'features/auth_feature/password_feature/data/data_source/password_remote_data_source.dart';
import 'features/auth_feature/password_feature/data/repository/password_repository.dart';
import 'features/auth_feature/password_feature/domain/interface/password_interface.dart';
import 'features/auth_feature/password_feature/domain/use_cases/password_use_case.dart';
import 'features/auth_feature/password_feature/presentation/logic/password_cubit/password_cubit.dart';
import 'features/auth_feature/phone_feature/data/data_source/phone_data_source.dart';
import 'features/auth_feature/phone_feature/data/repository/phone_repository.dart';
import 'features/auth_feature/phone_feature/domain/interface/phone_interface.dart';
import 'features/auth_feature/phone_feature/domain/use_cases/phone_use_case.dart';
import 'features/auth_feature/phone_feature/presentation/logic/phone_cubit/phone_cubit.dart';
import 'features/auth_feature/profile_feature/data/data_source/profile_remote_data_source.dart';
import 'features/auth_feature/profile_feature/data/repository/profile_repository.dart';
import 'features/auth_feature/profile_feature/domain/interface/profile_interface.dart';
import 'features/auth_feature/profile_feature/domain/use_cases/profile_ues_case.dart';
import 'features/auth_feature/profile_feature/presentation/logic/profile_cubit/profile_cubit.dart';
import 'features/auth_feature/sign_up_feature/data/data_source/sign_up_remote_data_source.dart';
import 'features/auth_feature/sign_up_feature/data/repository/sign_up_repository.dart';
import 'features/auth_feature/sign_up_feature/domain/interface/signup_interface.dart';
import 'features/auth_feature/sign_up_feature/domain/use_cases/sign_up_use_case.dart';
import 'features/auth_feature/sign_up_feature/presentation/logic/sign_up_cubit/sign_up_cubit.dart';
import 'features/auth_feature/splash_feature/data/data_source/splash_remote_data_source.dart';
import 'features/auth_feature/splash_feature/data/repository/splash_repository.dart';
import 'features/auth_feature/splash_feature/domain/interface/splash_interface.dart';
import 'features/auth_feature/splash_feature/domain/use_cases/splash_use_case.dart';
import 'features/auth_feature/splash_feature/presentation/logic/splash_cubit/splash_cubit.dart';
import 'features/help_feature/Data/data_source/remote_data_source.dart';
import 'features/help_feature/Data/repository/help_repository.dart';
import 'features/help_feature/Domain/repository/help_interface.dart';
import 'features/help_feature/Domain/ues_cases/help_ues_cases.dart';
import 'features/help_feature/Presentation/logic/help_cubit/help_cubit.dart';
import 'features/language_feature/data/data_source/local_data_source.dart';
import 'features/language_feature/data/data_source/remote_data_source.dart';
import 'features/language_feature/data/repository/lang_repository.dart';
import 'features/language_feature/domain/interface/lang_interface.dart';
import 'features/language_feature/domain/use_case/lang_use_case.dart';
import 'features/language_feature/presentation/logic/language_cubit/language_cubit.dart';
import 'features/notification_feature/data/data_source/remote_data_source.dart';
import 'features/notification_feature/data/repository/notification_repository.dart';
import 'features/notification_feature/domain/repository/notification_interface.dart';
import 'features/notification_feature/domain/ues_cases/notification_ues_cases.dart';
import 'features/notification_feature/presentation/logic/notification_cubit.dart';
import 'features/order_feature/order_ingector.dart';
import 'features/pick_location_feature/map_injection_file.dart';
import 'features/product_feature/product_ingector.dart';
import 'features/setting_feature/data/data_sources/local_data_sources.dart';
import 'features/setting_feature/data/data_sources/remote_data_sources.dart';
import 'features/setting_feature/data/repository/setting_repository.dart';
import 'features/setting_feature/domain/repository/setting_interface.dart';
import 'features/setting_feature/domain/ues_cases/setting_ues_cases.dart';
import 'features/setting_feature/presentation/logic/setting_cubit/setting_cubit.dart';
import 'features/ticket_feature/Data/data_source/remote_ticket_date_source.dart';
import 'features/ticket_feature/Data/reposiroty/ticket_repository.dart';
import 'features/ticket_feature/Domain/reposiroty/ticket_interface.dart';
import 'features/ticket_feature/Domain/ues_cases/ticket_use_case.dart';
import 'features/ticket_feature/Presentation/logic/ticket_chat_cubit/ticket_chat_cubit.dart';
import 'features/ticket_feature/Presentation/logic/ticket_cubit/ticket_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  ///Bloc
  setupProductInjection();
  setupAddressInjection();
  setupInjectionMap();
  setupOrderInjection();
  setupHomeInjection();
  sl.registerFactory(() => SplashCubit(sl()));
  sl.registerFactory(() => OnBoardingCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => LogoutCubit(sl()));
  sl.registerFactory(() => DeleteAccountCubit(sl()));
  sl.registerFactory(() => SignUpCubit(sl()));
  sl.registerFactory(() => OtpCubit(sl()));
  sl.registerFactory(() => TimerCubit());
  sl.registerFactory(() => PasswordCubit(sl()));
  sl.registerFactory(() => ProfileCubit(sl()));
  sl.registerFactory(() => PhoneCubit(sl()));

  sl.registerFactory(() => BottomNavCubit());
  sl.registerFactory(() => LangCubit(sl()));
  sl.registerFactory(() => SettingCubit(sl()));
  sl.registerFactory(() => NotificationCubit(sl()));
  sl.registerFactory(() => HelpCubit(sl()));
  sl.registerFactory(() => TicketCubit(sl()));
  sl.registerFactory(() => TicketChatCubit(sl()));
  sl.registerFactory(() => AllFilterCubit());
  sl.registerFactory(() => PickImageCubit());
  sl.registerFactory(() => DownloadFileCubit());

  ///User case
  sl.registerLazySingleton(() => SplashUseCase(repository: sl()));
  sl.registerLazySingleton(() => OnBoardingUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));
  sl.registerLazySingleton(() => OtpUseCases(sl()));
  sl.registerLazySingleton(() => PasswordUseCases(sl()));
  sl.registerLazySingleton(() => ProfileUseCases(sl()));
  sl.registerLazySingleton(() => PhoneUseCase(sl()));

  sl.registerLazySingleton(() => LangUseCase(sl()));
  sl.registerLazySingleton(() => SettingUserCase(sl()));
  sl.registerLazySingleton(() => NotificationUesCases(sl()));
  sl.registerLazySingleton(() => HelpUesCases(sl()));
  sl.registerLazySingleton(() => TicketUseCase(sl()));

  ///repo
  sl.registerLazySingleton<SplashInterface>(() => SplashRepository(
      auhLocalDataSourceInterface: sl(), remoteDataSourceInterface: sl()));
  sl.registerLazySingleton<OnBoardingRepositoryInterface>(
      () => OnBoardingRepository(sl()));
  sl.registerLazySingleton<LoginInterface>(() => LoginRepository(
        auhLocalDataSourceInterface: sl(),
        authRemoteDataSourceInterface: sl(),
        connectionCheckerInterface: sl(),
      ));
  sl.registerLazySingleton<LogoutInterface>(() => LogoutRepository(
        auhLocalDataSourceInterface: sl(),
        authRemoteDataSourceInterface: sl(),
        connectionCheckerInterface: sl(),
      ));
  sl.registerLazySingleton<OtpRepositoryInterface>(() => OtpRepository(
        remoteDataSourceInterface: sl(),
        auhLocalDataSourceInterface: sl(),
        connectionCheckerInterface: sl(),
      ));
  sl.registerLazySingleton<DeleteAccountInterface>(
      () => DeleteAccountRepository(
            auhLocalDataSourceInterface: sl(),
            dataSource: sl(),
            connectionCheckerInterface: sl(),
          ));
  sl.registerLazySingleton<SignUpInterface>(() => SignUpRepository(
        remoteDataSourceInterface: sl(),
        connectionCheckerInterface: sl(),
      ));
  sl.registerLazySingleton<PasswordRepositoryInterface>(
      () => PasswordRepository(
            remoteDataSourceInterface: sl(),
            connectionCheckerInterface: sl(),
          ));
  sl.registerLazySingleton<ProfileInterface>(() => ProfileRepository(
        remoteDataSourceInterface: sl(),
        localDataSourceInterface: sl(),
        connectionCheckerInterface: sl(),
      ));
  sl.registerLazySingleton<PhoneInterface>(() => PhoneRepository(
        phoneDataSource: sl(),
        connectionCheckerInterface: sl(),
      ));
  sl.registerLazySingleton<TicketInterface>(() => TicketRepository(
        ticketRemoteDataSource: sl(),
        connectionCheckerInterface: sl(),
      ));
  sl.registerLazySingleton<LangInterface>(() => LangRepository(
      localDataSourceInterface: sl(), remoteDataSourceInterface: sl()));
  sl.registerLazySingleton<HelpInterface>(() => HelpRepository(
        remoteDataScoursInterface: sl(),
        connectionCheckerInterface: sl(),
      ));
  sl.registerLazySingleton<SettingRepositoryInterface>(() => SettingRepository(
        localDataSourceInterface: sl(),
        remoteDataSourceInterface: sl(),
        connectionCheckerInterface: sl(),
      ));
  sl.registerLazySingleton<NotificationListRepositoryInterface>(
      () => NotificationListRepository(
            remoteDataScoursInterface: sl(),
            connectionCheckerInterface: sl(),
          ));

  sl.registerLazySingleton<ConnectionCheckerInterface>(
      () => ConnectionChecker(InternetConnectionChecker()));

  ///local data source
  sl.registerLazySingleton<LanguageLocalDataSourceInterface>(
      () => LanguageLocalDataSourceImp());
  sl.registerLazySingleton<SettingLocalDataSourceInterface>(
      () => SettingLocalDataSourceImp());
  sl.registerLazySingleton<AuthLocalDataSourceInterface>(
      () => AuthLocalDataSourceImp());

  ///remote data source
  sl.registerLazySingleton<OtpRemoteDataSourceInterface>(
      () => OtpRemoteDataSourceImp());
  sl.registerLazySingleton<PasswordRemoteDataSourceInterface>(
      () => PasswordRemoteDataSourceImpl());
  sl.registerLazySingleton<ProfileRemoteDataSourceInterface>(
      () => ProfileRemoteDataSourceImpl());
  sl.registerLazySingleton<LoginRemoteDataSourceInterface>(
      () => LoginRemoteDataSourceImp());
  sl.registerLazySingleton<LogoutRemoteDataSourceInterface>(
      () => LogoutRemoteDataSourceImp());
  sl.registerLazySingleton<SignUphRemoteDataSourceInterface>(
      () => SignUphRemoteDataSourceImp());
  sl.registerLazySingleton<DeleteAccountDataSource>(
      () => DeleteAccountDataSourceImp());
  sl.registerLazySingleton<PhoneDataSource>(() => PhoneDataSourceImpl());
  sl.registerLazySingleton<SplashRemoteDataSourceInterface>(
      () => SplashRemoteDataSourceImp());
  sl.registerLazySingleton<HelpRemoteDataScoursInterface>(
      () => HelpRemoteDataScoursImp());
  sl.registerLazySingleton<LanguageRemoteDataSourceInterface>(
      () => LanguageRemoteDataSourceImp());
  sl.registerLazySingleton<SettingRemoteDataSourceInterface>(
      () => SettingRemoteDataSourceImpl());
  sl.registerLazySingleton<TicketRemoteDataScoursInterface>(
      () => TicketRemoteDataScoursImp());
  sl.registerLazySingleton<NotificationRemoteDataScoursInterface>(
      () => NotificationRemoteDataScoursImpl());
}

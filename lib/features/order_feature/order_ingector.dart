import '/features/order_feature/data/data_source/remote_data_source.dart';
import '/features/order_feature/data/repository/order_repository.dart';
import '/features/order_feature/domain/repository/order_repository_interface.dart';
import '/features/order_feature/domain/ues_cases/order_cases.dart';
import '/features/order_feature/presentation/logic/create_order_cubit/create_order_cubit.dart';
import '/features/order_feature/presentation/logic/update_order_cubit/update_order_cubit.dart';
import '/injection_container.dart';
import 'presentation/logic/offers_cubit/offer_cubit.dart';
import 'presentation/logic/orders_cubit/order_cubit.dart';

void setupOrderInjection() {
  sl.registerLazySingleton<OrderRemoteDataScoursInterface>(
      () => OrdersRemoteDataScoursImp());


  sl.registerFactory<OrdersRepositoryInterface>(
    () => OrdersRepositoryImp(
      remoteDataScoursInterface: sl(),
      connectionCheckerInterface: sl(),
    ),
  );
  sl.registerLazySingleton<OrdersUesCases>(
    () => OrdersUesCases(
      sl(),
    ),
  );
  sl.registerFactory(() => CreateOrderCubit(sl()));
  sl.registerFactory(() => OrderCubit(sl()));
  sl.registerFactory(() => UpdateOrderCubit(sl()));
  sl.registerFactory(() => OfferCubit(sl()));
}

import '/features/product_feature/data/data_source/remote_data_source.dart';
import '/features/product_feature/domain/repository/product_interface.dart';
import '/features/product_feature/domain/ues_cases/product_ues_cases.dart';
import '/features/product_feature/presentation/logic/product_cubit.dart';
import '/injection_container.dart';

import 'data/repository/product_repository.dart';

void setupProductInjection() {
  sl.registerLazySingleton<ProductRemoteDataScoursInterface>(
      () => ProductRemoteDataScoursImp());

  sl.registerLazySingleton<ProductInterface>(
    () => ProductRepository(
      remoteDataScoursInterface: sl(),
      connectionCheckerInterface: sl(),
    ),
  );

  sl.registerLazySingleton<ProductUesCases>(
    () => ProductUesCases(
      sl(),
    ),
  );
  sl.registerFactory(() => ProductCubit(sl()));
}

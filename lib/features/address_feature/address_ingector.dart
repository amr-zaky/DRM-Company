import 'package:base_project_repo/features/address_feature/domain/ues_cases/address_ues_cases.dart';
import 'package:base_project_repo/features/address_feature/presentation/logic/home_address_cubit/home_address_cubit.dart';

import 'presentation/logic/add_address_cubit/add_address_cubit.dart';
import 'presentation/logic/address_cubit/address_cubit.dart';
import '/features/product_feature/domain/ues_cases/product_ues_cases.dart';
import '/injection_container.dart';

import 'data/data_source/remote_data_source.dart';
import 'data/repository/address_repository.dart';
import 'domain/repository/address_interface.dart';

void setupAddressInjection() {
  sl.registerLazySingleton<AddressRemoteDataScoursInterface>(
      () => AddressRemoteDataScoursImp());

  sl.registerLazySingleton<AddressInterface>(
    () => AddressRepository(
      remoteDataScoursInterface: sl(),
      connectionCheckerInterface: sl(),
    ),
  );

  sl.registerLazySingleton<AddressUesCases>(
    () => AddressUesCases(
      sl(),
    ),
  );
  sl.registerFactory(() => HomeAddressCubit(sl()));
  sl.registerFactory(() => AddressCubit(sl()));
  sl.registerFactory(() => AddNewAddressCubit(sl()));
}

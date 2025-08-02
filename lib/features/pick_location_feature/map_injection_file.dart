import 'package:base_project_repo/injection_container.dart';

import 'data/data_source/remote_data_source.dart';
import 'data/repository/map_places_repository.dart';
import 'domain/interface/map_places_interface.dart';
import 'domain/use_case/map_use_case.dart';
import 'presentation/logic/Recommendation_Place/recommendation_place_cubit.dart';
import 'presentation/logic/google_map_Cubit/google_map_cubit.dart';

void setupInjectionMap() {
  sl.registerFactory(() => GoogleMapCubit());
  sl.registerFactory(() => RecommendationPlaceCubit(sl()));

  sl.registerLazySingleton(() => MapSearchUseCase(sl()));

  sl.registerLazySingleton<MapPlacesInterface>(() => PlacesRepository(sl()));

  sl.registerLazySingleton<MapRemoteDataSourceInterface>(
      () => MapRemoteDataSourceImpl());
}

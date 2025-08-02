import 'package:base_project_repo/features/home_feature/logic/home_offers_cubit/home_offer_cubit.dart';
import 'package:base_project_repo/features/home_feature/logic/home_orders_cubit/home_order_cubit.dart';
import 'package:base_project_repo/injection_container.dart';

void setupHomeInjection() {
  sl.registerFactory(() => HomeOfferCubit(sl()));
  sl.registerFactory(() => HomeOrderCubit(sl()));
}

import '../../domain/interface/on_boarding_interface.dart';
import '/core/data_source/local_source/auth_local_data_source.dart';

class OnBoardingRepository extends OnBoardingRepositoryInterface {
  OnBoardingRepository(this.auhLocalDataSourceInterface);
  final AuthLocalDataSourceInterface auhLocalDataSourceInterface;

  @override
  Future<void> setUserFirstTime() async {
    await auhLocalDataSourceInterface.setUserFirstTime(false);
  }
}

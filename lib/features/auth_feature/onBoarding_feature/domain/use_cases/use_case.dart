import '../interface/on_boarding_interface.dart';

class OnBoardingUseCase {
  OnBoardingUseCase(this.repository);
  final OnBoardingRepositoryInterface repository;

  Future<void> setUserFirstTime() async {
    await repository.setUserFirstTime();
  }
}

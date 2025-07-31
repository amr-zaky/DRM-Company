abstract class SplashStates {}

class SplashStatesInit extends SplashStates {}

class UserNotFoundState extends SplashStates {
  UserNotFoundState(this.isUserFirstTime);
  bool isUserFirstTime;
}

class UserFoundState extends SplashStates {}

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnectionCheckerInterface {
  Future<bool> isConnected();
}

class ConnectionChecker implements ConnectionCheckerInterface {
  ConnectionChecker(InternetConnectionChecker dependencyConnectionChecker) {
    internetConnectionChecker = dependencyConnectionChecker;
  }

  // Create a private constructor
  late InternetConnectionChecker internetConnectionChecker;

  // Method to check internet connection
  @override
  Future<bool> isConnected() async => internetConnectionChecker.hasConnection;
}

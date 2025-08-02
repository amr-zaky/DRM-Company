import '../../../error_handling/custom_exception.dart';

abstract class DownloadFileCubitStates {}

class DownloadFileInitialState extends DownloadFileCubitStates {}

class DownloadFileLoadingState extends DownloadFileCubitStates {}

class DownloadFileSuccessState extends DownloadFileCubitStates {}

class DownloadFileErrorState extends DownloadFileCubitStates {
  DownloadFileErrorState(this.error);
  final CustomException error;
}

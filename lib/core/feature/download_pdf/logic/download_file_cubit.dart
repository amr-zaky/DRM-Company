import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../../constants/enums/exception_enums.dart';
import '../../../error_handling/custom_exception.dart';
import 'download_file_cubit_states.dart';

class DownloadFileCubit extends Cubit<DownloadFileCubitStates> {
  DownloadFileCubit() : super(DownloadFileInitialState());
  String downloadPath = "/Download";
  int? page = 0;

  void setDownloadPath(String newPath) {
    downloadPath = "/$newPath";
  }

  void setPage(int? pageValue) {
    page = pageValue;
    emit(DownloadFileSuccessState());
  }

  void setError(String errorValue) {
    emit(DownloadFileErrorState(CustomException(
        CustomStatusCodeErrorType.unExcepted,
        errorMassage: errorValue)));
  }

  Future<File> createFileOfPdfUrl({required String fileUrl}) async {
    final Completer<File> completer = Completer<File>();
    try {
      emit(DownloadFileLoadingState());

      ///file name form url
      final String url = fileUrl;
      final String filename = url.substring(url.lastIndexOf("/") + 1);

      ///download and convert to bytes
      final dynamic bytes = await _downloadFileFromUrlAndConvertToBytes(url);

      ///create path to save in
      final String path = await _getFilePath();

      ///save file in local
      final File file = await _saveFieLocal("/$path/$filename", bytes);

      completer.complete(file);
      emit(DownloadFileSuccessState());
    } catch (error) {
      emit(DownloadFileErrorState(CustomException(
        CustomStatusCodeErrorType.unExcepted,
        errorMassage: error.toString(),
      )));
    }

    return completer.future;
  }

  Future<Uint8List> _downloadFileFromUrlAndConvertToBytes(String url) async {
    final HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
    final HttpClientResponse response = await request.close();
    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    return bytes;
  }

  Future<File> _saveFieLocal(String filePath, dynamic bytes) async {
    final File file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<String> _getFilePath() async {
    String path = '';
    Directory? directory;

    if (Platform.isIOS) {
      directory = await getApplicationSupportDirectory();
      await Directory(directory.path)
          .create(recursive: true)
          .then((Directory directory) {
        path = directory.path;
      });
    } else {
      final Directory? root = await getExternalStorageDirectory();
      debugPrint('getDownloadsDirectory: ${root!.existsSync()}');

      final String directoryPath = root.path + downloadPath;
      directory = Directory('directoryPath: $directoryPath');

      directory = await Directory(directoryPath)
          .create(recursive: true)
          .then((Directory value) {
        path = directoryPath;
        Directory('saved directory in path: $directoryPath ** ${value.path}');
        return value;
      });

      if (directory.existsSync()) {
        path = directory.path;
        debugPrint("path is $path");
      }
    }
    return path;
  }
}

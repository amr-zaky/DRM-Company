import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../presentation/routes/route_argument.dart';
import '/core/constants/app_constants.dart';
import '/core/feature/download_pdf/logic/download_file_cubit.dart';
import '/core/feature/download_pdf/logic/download_file_cubit_states.dart';
import '/core/presentation/widgets/common_app_bar_widget.dart';
import '/core/presentation/widgets/common_error_widget.dart';
import '/core/presentation/widgets/common_loading_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';

class PdfViewHomePage extends StatefulWidget {
  const PdfViewHomePage({Key? key, required this.routeArgument})
      : super(key: key);
  final RouteArgument routeArgument;

  @override
  State<StatefulWidget> createState() => _PdfViewHomePageState();
}

class _PdfViewHomePageState extends State<PdfViewHomePage>
    with WidgetsBindingObserver {
  String pdfPath = "";
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  late DownloadFileCubit downloadFileCubit;

  @override
  void initState() {
    super.initState();
    downloadFileCubit = BlocProvider.of<DownloadFileCubit>(context);
    downloadFileCubit
        .createFileOfPdfUrl(
            fileUrl: widget.routeArgument.documentModel!.originalUrl)
        .then((File f) {
      setState(() {
        pdfPath = f.path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        customTitleWidget: CommonTitleText(
            textKey: widget.routeArgument.documentModel!.name,
            textColor: AppConstants.mainTextColor,
            minTextFontSize: AppConstants.fontSize16,
            textWeight: FontWeight.w500),
      ),
      body: BlocConsumer<DownloadFileCubit, DownloadFileCubitStates>(
        listener: (BuildContext downloadCtx,
            DownloadFileCubitStates downloadStates) {},
        builder:
            (BuildContext downloadCtx, DownloadFileCubitStates downloadStates) {
          if (downloadStates is DownloadFileLoadingState) {
            return const CommonLoadingWidget();
          } else if (downloadStates is DownloadFileErrorState) {
            return CommonError(
              errorType: downloadStates.error.type,
              errorMassage: downloadStates.error.errorMassage,
            );
          } else {
            return PDFView(
              filePath: pdfPath,
              swipeHorizontal: true,
              autoSpacing: false,
              defaultPage: downloadFileCubit.page!,
              fitPolicy: FitPolicy.BOTH,
              onRender: (int? page) {
                downloadFileCubit.setPage(page);
              },
              onError: (dynamic error) {
                downloadFileCubit.setError(error);
              },
              onPageError: (int? page, dynamic error) {
                downloadFileCubit.setError(error);
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onPageChanged: (int? page, int? total) {
                downloadFileCubit.setPage(page);
              },
            );
          }
        },
      ),
    );
  }
}

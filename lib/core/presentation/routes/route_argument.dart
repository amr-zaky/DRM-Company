import 'package:base_project_repo/core/model/product_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../features/order_feature/domain/order_model.dart';
import '../../constants/enums/page_enums.dart';
import '../../feature/download_pdf/model/document_model.dart';
import '/features/ticket_feature/Domain/model/ticket_model.dart';

class RouteArgument {
  RouteArgument({
    this.sourcePage,
    this.userCredential,
    this.otp,
    this.isUserFirstTime,
    this.pageTitle,
    this.pageType,
    this.ticketModel,
    this.documentModel,
    this.productModel,
    this.withAutoComplete = false,
    this.onAddressSuccess,
    this.orderModel,
  });

  ///verification
  SourcePageEnum? sourcePage;
  String? userCredential;
  String? otp;

  ///on_boarding
  bool? isUserFirstTime;

  ///setting page
  String? pageTitle;
  String? pageType;

  ///ticket
  TicketModel? ticketModel;

  ///Document
  DocumentModel? documentModel;

  ProductModel? productModel;
  OrderModel? orderModel;
  Function()? onAddressSuccess;
  bool withAutoComplete = false;
}

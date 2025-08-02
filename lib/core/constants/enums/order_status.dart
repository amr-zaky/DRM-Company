import 'package:base_project_repo/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

enum OrderStatus {
  newStatus,
  accepted,
  cancelledbyclient,
  rejectedbycompany,
  cancelledbycompany,
  inway,
  finishing
}

extension OrderStatusExtension on OrderStatus {
  String getStatusValueInApi() {
    final Map<OrderStatus, dynamic> map = <OrderStatus, dynamic>{
      OrderStatus.newStatus: "new",
      OrderStatus.accepted: "accepted",
      OrderStatus.cancelledbyclient: "cancelled by client",
      OrderStatus.cancelledbycompany: "cancelled by company",
      OrderStatus.rejectedbycompany: "reject by company",
      OrderStatus.inway: "in way",
      OrderStatus.finishing: "finishing"
    };

    return map[this];
  }

  OrderStatus getStatusValueInModel(String status) {
    final Map<String, OrderStatus> map = <String, OrderStatus>{
      "new": OrderStatus.newStatus,
      "accepted": OrderStatus.accepted,
      "cancelled by client": OrderStatus.cancelledbyclient,
      "cancelled by company": OrderStatus.cancelledbycompany,
      "in way": OrderStatus.inway,
      "finishing": OrderStatus.finishing,
      "reject by company": OrderStatus.rejectedbycompany,
    };

    return map[status] ?? OrderStatus.newStatus;
  }

  Color getStatusBackGroundColorModel() {
    final Map<OrderStatus, Color> map = <OrderStatus, Color>{
      OrderStatus.newStatus: AppConstants.newStatusColor,
      OrderStatus.accepted: AppConstants.acceptedColor,
      OrderStatus.cancelledbyclient: AppConstants.lightRedColor,
      OrderStatus.cancelledbycompany: AppConstants.lightRedColor,
      OrderStatus.rejectedbycompany: AppConstants.lightRedColor,
      OrderStatus.inway: AppConstants.mainColor,
      OrderStatus.finishing: AppConstants.completedColor,
    };

    return map[this] ?? AppConstants.mainColor;
  }
}

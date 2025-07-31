enum OrderStatus {
  newStatus,
  accepted,
  cancelledbyclient,
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
      OrderStatus.inway: "in way",
      OrderStatus.finishing: "finishing"
    };

    return map[this];
  }
}

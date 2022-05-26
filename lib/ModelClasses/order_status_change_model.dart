class OrderStatusChangeModel {
  OrderStatusChangeModel({
    required this.DeliveryDriverID,
    required this.OrderNumber,
    required this.status,
  });
  late final String DeliveryDriverID;
  late final String OrderNumber;
  late final String status;

  OrderStatusChangeModel.fromJson(Map<String, dynamic> json) {
    DeliveryDriverID = json['DeliveryDriverID'];
    OrderNumber = json['OrderNumber'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['DeliveryDriverID'] = DeliveryDriverID;
    _data['OrderNumber'] = OrderNumber;
    _data['status'] = status;
    return _data;
  }
}

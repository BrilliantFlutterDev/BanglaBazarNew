class OrderReturnModel {
  OrderReturnModel({
    required this.OrderNumber,
    required this.DeliveryDriverID,
    required this.ReturnReason,
  });
  late final String OrderNumber;
  late final String DeliveryDriverID;
  late final String ReturnReason;

  OrderReturnModel.fromJson(Map<String, dynamic> json) {
    OrderNumber = json['OrderNumber'];
    DeliveryDriverID = json['DeliveryDriverID'];
    ReturnReason = json['ReturnReason'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['OrderNumber'] = OrderNumber;
    _data['DeliveryDriverID'] = DeliveryDriverID;
    _data['ReturnReason'] = ReturnReason;
    return _data;
  }
}

class CheckDeliveryDriverResponse {
  CheckDeliveryDriverResponse({
    required this.status,
    required this.deliveryDriverStatus,
  });
  late final bool status;
  late final bool deliveryDriverStatus;

  CheckDeliveryDriverResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    deliveryDriverStatus = json['deliveryDriverStatus'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['deliveryDriverStatus'] = deliveryDriverStatus;
    return _data;
  }
}

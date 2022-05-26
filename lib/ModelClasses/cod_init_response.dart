class CODInitResponse {
  CODInitResponse({
    required this.status,
    required this.message,
    required this.OrderNumber,
  });
  late final bool status;
  late final String message;
  late final String OrderNumber;

  CODInitResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    OrderNumber = json['OrderNumber'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['OrderNumber'] = OrderNumber;
    return _data;
  }
}

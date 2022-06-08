class StripInitResponse {
  StripInitResponse({
    required this.status,
    required this.message,
    required this.OrderNumber,
    required this.OrderTotal,
    required this.Currency,
  });
  late final bool status;
  late final String message;
  late final String OrderNumber;
  late final double OrderTotal;
  late final String Currency;

  StripInitResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    OrderNumber = json['OrderNumber'];
    OrderTotal = double.parse(json['OrderTotal'].toString());
    Currency = json['Currency'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['OrderNumber'] = OrderNumber;
    _data['OrderTotal'] = OrderTotal;
    _data['Currency'] = Currency;
    return _data;
  }
}

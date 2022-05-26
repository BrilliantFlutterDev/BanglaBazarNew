class SSLGetDetailsModel {
  SSLGetDetailsModel({
    required this.OrderNumber,
  });
  late final String OrderNumber;

  SSLGetDetailsModel.fromJson(Map<String, dynamic> json) {
    OrderNumber = json['OrderNumber'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['OrderNumber'] = OrderNumber;
    return _data;
  }
}

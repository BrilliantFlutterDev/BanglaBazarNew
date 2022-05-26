class SSLCommerzInitResponse {
  SSLCommerzInitResponse({
    required this.status,
    required this.message,
    required this.OrderNumber,
    required this.URLLINK,
  });
  late final bool status;
  late final String message;
  late final String OrderNumber;
  late final String URLLINK;

  SSLCommerzInitResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    OrderNumber = json['OrderNumber'];
    URLLINK = json['URL_LINK'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['OrderNumber'] = OrderNumber;
    _data['URL_LINK'] = URLLINK;
    return _data;
  }
}

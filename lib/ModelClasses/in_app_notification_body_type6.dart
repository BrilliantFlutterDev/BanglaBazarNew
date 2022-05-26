class InAppNotificationBodyTypeID6 {
  InAppNotificationBodyTypeID6({
    required this.OrderNumber,
    required this.body,
  });
  late final String? OrderNumber;
  late final String body;

  InAppNotificationBodyTypeID6.fromJson(Map<String, dynamic> json) {
    OrderNumber = json['OrderNumber'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['OrderNumber'] = OrderNumber;
    _data['body'] = body;
    return _data;
  }
}

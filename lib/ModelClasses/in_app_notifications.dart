class InAppNotificationBody {
  InAppNotificationBody({
    required this.body,
  });

  late final String body;

  InAppNotificationBody.fromJson(Map<String, dynamic> json) {
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['body'] = body;
    return _data;
  }
}

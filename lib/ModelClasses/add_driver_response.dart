class AddDriverResponse {
  AddDriverResponse({
    required this.status,
    required this.message,
  });
  late final bool status;
  late final String message;

  AddDriverResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

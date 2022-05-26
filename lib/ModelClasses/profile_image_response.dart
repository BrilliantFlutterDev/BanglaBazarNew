class ProfileImageResponse {
  ProfileImageResponse({
    required this.status,
    required this.message,
    required this.path,
  });
  late final bool status;
  late final String message;
  late final String path;

  ProfileImageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    path = json['Path'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['Path'] = path;
    return _data;
  }
}

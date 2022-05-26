class PathaoAccessTokenResponse {
  PathaoAccessTokenResponse({
    required this.status,
    required this.token,
  });
  late final bool status;
  late final String token;

  PathaoAccessTokenResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['token'] = token;
    return _data;
  }
}

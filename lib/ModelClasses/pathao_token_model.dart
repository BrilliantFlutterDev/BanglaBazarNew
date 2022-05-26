class PathaoTokenModel {
  PathaoTokenModel({
    required this.token,
  });
  late final String token;

  PathaoTokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    return _data;
  }
}

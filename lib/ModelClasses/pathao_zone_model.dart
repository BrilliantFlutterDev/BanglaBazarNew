class PathaoZoneModel {
  PathaoZoneModel({
    required this.token,
    required this.cityId,
  });
  late final String token;
  late final String cityId;

  PathaoZoneModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['city_id'] = cityId;
    return _data;
  }
}

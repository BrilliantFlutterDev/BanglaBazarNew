class PathaoAreaModel {
  PathaoAreaModel({
    required this.token,
    required this.zoneId,
  });
  late final String token;
  late final String zoneId;

  PathaoAreaModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    zoneId = json['zone_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['zone_id'] = zoneId;
    return _data;
  }
}

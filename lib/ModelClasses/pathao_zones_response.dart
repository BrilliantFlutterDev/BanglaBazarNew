class PathaoZonesResponse {
  PathaoZonesResponse({
    required this.status,
    required this.zones,
  });
  late final bool status;
  late final List<Zones> zones;

  PathaoZonesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    zones = List.from(json['zones']).map((e) => Zones.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['zones'] = zones.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Zones {
  Zones({
    required this.zoneId,
    required this.zoneName,
  });
  late final int zoneId;
  late final String zoneName;

  Zones.fromJson(Map<String, dynamic> json) {
    zoneId = json['zone_id'];
    zoneName = json['zone_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['zone_id'] = zoneId;
    _data['zone_name'] = zoneName;
    return _data;
  }
}

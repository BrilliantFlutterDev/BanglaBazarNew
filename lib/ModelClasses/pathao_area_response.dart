class PathaoAreaResponse {
  PathaoAreaResponse({
    required this.status,
    required this.areas,
  });
  late final bool status;
  late final List<Areas> areas;

  PathaoAreaResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    areas = List.from(json['areas']).map((e) => Areas.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['areas'] = areas.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Areas {
  Areas({
    required this.areaId,
    required this.areaName,
    required this.homeDeliveryAvailable,
    required this.pickupAvailable,
  });
  late final int areaId;
  late final String areaName;
  late final bool homeDeliveryAvailable;
  late final bool pickupAvailable;

  Areas.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    areaName = json['area_name'];
    homeDeliveryAvailable = json['home_delivery_available'];
    pickupAvailable = json['pickup_available'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['area_id'] = areaId;
    _data['area_name'] = areaName;
    _data['home_delivery_available'] = homeDeliveryAvailable;
    _data['pickup_available'] = pickupAvailable;
    return _data;
  }
}

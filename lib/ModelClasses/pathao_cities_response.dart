class PathaoCitiesResponse {
  PathaoCitiesResponse({
    required this.status,
    required this.cities,
  });
  late final bool status;
  late final List<Cities> cities;

  PathaoCitiesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    cities = List.from(json['cities']).map((e) => Cities.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['cities'] = cities.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Cities {
  Cities(
      {required this.cityId, required this.cityName, required this.DBCityID});
  late final int cityId;
  late final String cityName;
  late final int DBCityID;

  Cities.fromJson(Map<String, dynamic> json) {
    cityId = json['PathaoCityID'];
    cityName = json['PathaoCityName'];
    DBCityID = json['DBCityID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['PathaoCityID'] = cityId;
    _data['PathaoCityName'] = cityName;
    _data['DBCityID'] = DBCityID;
    return _data;
  }
}

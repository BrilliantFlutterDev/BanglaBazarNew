class GeoLocationResponse {
  GeoLocationResponse({
    required this.countryCode,
    required this.countryName,
    required this.city,
    required this.postal,
    required this.latitude,
    required this.longitude,
    required this.IPv4,
    required this.state,
  });
  late final String countryCode;
  late final String countryName;
  late final String city;
  late final String postal;
  late final double latitude;
  late final double longitude;
  late final String IPv4;
  late final String state;

  GeoLocationResponse.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    countryName = json['country_name'];
    city = json['city'];
    postal = json['postal'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    IPv4 = json['IPv4'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['country_code'] = countryCode;
    _data['country_name'] = countryName;
    _data['city'] = city;
    _data['postal'] = postal;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['IPv4'] = IPv4;
    _data['state'] = state;
    return _data;
  }
}

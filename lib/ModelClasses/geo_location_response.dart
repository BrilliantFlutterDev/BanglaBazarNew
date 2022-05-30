class GeoLocationResponse {
  GeoLocationResponse({
    this.countryCode,
    this.countryName,
    this.city,
    this.postal,
    this.latitude,
    this.longitude,
    this.IPv4,
    this.state,
  });
  late final String? countryCode;
  late final String? countryName;
  late final String? city;
  late final String? postal;
  late final int? latitude;
  late final int? longitude;
  late final String? IPv4;
  late final String? state;

  GeoLocationResponse.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    countryName = json['country_name'];
    city = null;
    postal = null;
    latitude = json['latitude'];
    longitude = json['longitude'];
    IPv4 = json['IPv4'];
    state = null;
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

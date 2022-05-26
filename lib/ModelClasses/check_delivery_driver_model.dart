class CheckDeliveryDriverModel {
  CheckDeliveryDriverModel({
    required this.CityName,
  });
  late final String CityName;

  CheckDeliveryDriverModel.fromJson(Map<String, dynamic> json) {
    CityName = json['CityName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CityName'] = CityName;
    return _data;
  }
}

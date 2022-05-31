class PathaoPriceCalculationModel {
  PathaoPriceCalculationModel(
      {required this.token,
      required this.recipientCity,
      required this.recipientZone,
      required this.ProductIDs,
      required this.DBCityID});
  late final String token;
  late final String recipientCity;
  late final String recipientZone;
  late final List<String> ProductIDs;
  late final String DBCityID;

  PathaoPriceCalculationModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    recipientCity = json['recipient_city'];
    recipientZone = json['recipient_zone'];
    ProductIDs = List.castFrom<dynamic, String>(json['ProductIDs']);
    DBCityID = json['DBCityID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['recipient_city'] = recipientCity;
    _data['recipient_zone'] = recipientZone;
    _data['ProductIDs'] = ProductIDs;
    _data['DBCityID'] = DBCityID;
    return _data;
  }
}

class PathaoPriceCalculationModel {
  PathaoPriceCalculationModel({
    required this.token,
    required this.recipientCity,
    required this.recipientZone,
    required this.ProductIDs,
  });
  late final String token;
  late final String recipientCity;
  late final String recipientZone;
  late final List<String> ProductIDs;

  PathaoPriceCalculationModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    recipientCity = json['recipient_city'];
    recipientZone = json['recipient_zone'];
    ProductIDs = List.castFrom<dynamic, String>(json['ProductIDs']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['recipient_city'] = recipientCity;
    _data['recipient_zone'] = recipientZone;
    _data['ProductIDs'] = ProductIDs;
    return _data;
  }
}

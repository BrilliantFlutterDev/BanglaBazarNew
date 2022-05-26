class AllowedVendorCityResponse {
  AllowedVendorCityResponse({
    required this.status,
    required this.cities,
  });
  late final bool status;
  late final List<Cities> cities;

  AllowedVendorCityResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    cities = List.from(json['Cities']).map((e) => Cities.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['Cities'] = cities.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Cities {
  Cities({
    required this.CityID,
    required this.CountryID,
    required this.StateID,
    required this.City,
    required this.Native,
    required this.VATTaxRate,
    required this.FlatDeliveryRate,
    required this.FlatDeliveryRateKilo,
    required this.DeliveryPersonAvailable,
    required this.Active,
    this.LastUpdate,
    required this.AdminNote,
  });
  late final int CityID;
  late final int CountryID;
  late final int StateID;
  late final String City;
  late final String Native;
  late final String VATTaxRate;
  late final String FlatDeliveryRate;
  late final String FlatDeliveryRateKilo;
  late final String DeliveryPersonAvailable;
  late final String Active;
  late final Null LastUpdate;
  late final String AdminNote;

  Cities.fromJson(Map<String, dynamic> json) {
    CityID = json['CityID'];
    CountryID = json['CountryID'];
    StateID = json['StateID'];
    City = json['City'];
    Native = json['Native'];
    VATTaxRate = json['VATTaxRate'];
    FlatDeliveryRate = json['FlatDeliveryRate'];
    FlatDeliveryRateKilo = json['FlatDeliveryRateKilo'];
    DeliveryPersonAvailable = json['DeliveryPersonAvailable'];
    Active = json['Active'];
    LastUpdate = null;
    AdminNote = json['AdminNote'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CityID'] = CityID;
    _data['CountryID'] = CountryID;
    _data['StateID'] = StateID;
    _data['City'] = City;
    _data['Native'] = Native;
    _data['VATTaxRate'] = VATTaxRate;
    _data['FlatDeliveryRate'] = FlatDeliveryRate;
    _data['FlatDeliveryRateKilo'] = FlatDeliveryRateKilo;
    _data['DeliveryPersonAvailable'] = DeliveryPersonAvailable;
    _data['Active'] = Active;
    _data['LastUpdate'] = LastUpdate;
    _data['AdminNote'] = AdminNote;
    return _data;
  }
}

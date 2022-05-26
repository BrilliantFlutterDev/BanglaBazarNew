class AllowedCountriesResponse {
  AllowedCountriesResponse({
    required this.status,
    required this.countries,
  });
  late final bool status;
  late final List<Countries> countries;

  AllowedCountriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    countries =
        List.from(json['Countries']).map((e) => Countries.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['Countries'] = countries.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Countries {
  Countries({
    required this.CountryID,
    this.GatewayID,
    required this.Country,
    required this.IOSCountryCode,
    this.CurrencyCode,
    this.CountryPhoneCode,
    this.GMTtime,
    required this.AllowUser,
    required this.AllowDelivery,
    required this.AllowVendor,
    this.VATTaxRate,
    this.FlatDeliveryRate,
    this.FlatDeliveryRateKilo,
    this.Active,
    this.LastUpdate,
    this.AdminNote,
    required this.ISO2,
  });
  late final int CountryID;
  late final Null GatewayID;
  late final String Country;
  late final String IOSCountryCode;
  late final Null CurrencyCode;
  late final Null CountryPhoneCode;
  late final Null GMTtime;
  late final String AllowUser;
  late final String AllowDelivery;
  late final String AllowVendor;
  late final Null VATTaxRate;
  late final Null FlatDeliveryRate;
  late final Null FlatDeliveryRateKilo;
  late final Null Active;
  late final Null LastUpdate;
  late final Null AdminNote;
  late final String ISO2;

  Countries.fromJson(Map<String, dynamic> json) {
    CountryID = json['CountryID'];
    GatewayID = null;
    Country = json['Country'];
    IOSCountryCode = json['IOSCountryCode'];
    CurrencyCode = null;
    CountryPhoneCode = null;
    GMTtime = null;
    AllowUser = json['AllowUser'];
    AllowDelivery = json['AllowDelivery'];
    AllowVendor = json['AllowVendor'];
    VATTaxRate = null;
    FlatDeliveryRate = null;
    FlatDeliveryRateKilo = null;
    Active = null;
    LastUpdate = null;
    AdminNote = null;
    ISO2 = json['ISO2'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CountryID'] = CountryID;
    _data['GatewayID'] = GatewayID;
    _data['Country'] = Country;
    _data['IOSCountryCode'] = IOSCountryCode;
    _data['CurrencyCode'] = CurrencyCode;
    _data['CountryPhoneCode'] = CountryPhoneCode;
    _data['GMTtime'] = GMTtime;
    _data['AllowUser'] = AllowUser;
    _data['AllowDelivery'] = AllowDelivery;
    _data['AllowVendor'] = AllowVendor;
    _data['VATTaxRate'] = VATTaxRate;
    _data['FlatDeliveryRate'] = FlatDeliveryRate;
    _data['FlatDeliveryRateKilo'] = FlatDeliveryRateKilo;
    _data['Active'] = Active;
    _data['LastUpdate'] = LastUpdate;
    _data['AdminNote'] = AdminNote;
    _data['ISO2'] = ISO2;
    return _data;
  }
}

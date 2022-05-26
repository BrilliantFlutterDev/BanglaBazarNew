class DeliveryDetailsResponse {
  DeliveryDetailsResponse({
    required this.status,
    required this.driverDetails,
  });
  late final bool status;
  late final DriverDetails driverDetails;

  DeliveryDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    driverDetails = DriverDetails.fromJson(json['driverDetails']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['driverDetails'] = driverDetails.toJson();
    return _data;
  }
}

class DriverDetails {
  DriverDetails({
    required this.DeliveryDriverID,
    required this.GovernmentID,
    required this.GovernmentIDPic,
    required this.Address1,
    required this.Address2,
    required this.CityID,
    required this.City,
    required this.State,
    required this.ZipCode,
    required this.CountryID,
    required this.PaymentAccount,
    required this.PaymentRouting,
    required this.BusinessEmail,
    required this.BusinessPhone,
    required this.BusinessURL,
    required this.ReviewedByAdmin,
    required this.GatewayID,
    required this.CreatedDate,
    required this.LastUpdate,
    this.AdminNote,
  });
  late final int DeliveryDriverID;
  late final String GovernmentID;
  late final String GovernmentIDPic;
  late final String Address1;
  late final String Address2;
  late final int CityID;
  late final String City;
  late final String State;
  late final String ZipCode;
  late final int CountryID;
  late final String PaymentAccount;
  late final String PaymentRouting;
  late final String BusinessEmail;
  late final String BusinessPhone;
  late final String BusinessURL;
  late final String ReviewedByAdmin;
  late final int GatewayID;
  late final String CreatedDate;
  late final String LastUpdate;
  late final Null AdminNote;

  DriverDetails.fromJson(Map<String, dynamic> json) {
    DeliveryDriverID = json['DeliveryDriverID'];
    GovernmentID = json['GovernmentID'];
    GovernmentIDPic = json['GovernmentIDPic'];
    Address1 = json['Address1'];
    Address2 = json['Address2'];
    CityID = json['CityID'];
    City = json['City'];
    State = json['State'];
    ZipCode = json['ZipCode'];
    CountryID = json['CountryID'];
    PaymentAccount = json['PaymentAccount'];
    PaymentRouting = json['PaymentRouting'];
    BusinessEmail = json['BusinessEmail'];
    BusinessPhone = json['BusinessPhone'];
    BusinessURL = json['BusinessURL'];
    ReviewedByAdmin = json['ReviewedByAdmin'];
    GatewayID = json['GatewayID'];
    CreatedDate = json['CreatedDate'];
    LastUpdate = json['LastUpdate'];
    AdminNote = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['DeliveryDriverID'] = DeliveryDriverID;
    _data['GovernmentID'] = GovernmentID;
    _data['GovernmentIDPic'] = GovernmentIDPic;
    _data['Address1'] = Address1;
    _data['Address2'] = Address2;
    _data['CityID'] = CityID;
    _data['City'] = City;
    _data['State'] = State;
    _data['ZipCode'] = ZipCode;
    _data['CountryID'] = CountryID;
    _data['PaymentAccount'] = PaymentAccount;
    _data['PaymentRouting'] = PaymentRouting;
    _data['BusinessEmail'] = BusinessEmail;
    _data['BusinessPhone'] = BusinessPhone;
    _data['BusinessURL'] = BusinessURL;
    _data['ReviewedByAdmin'] = ReviewedByAdmin;
    _data['GatewayID'] = GatewayID;
    _data['CreatedDate'] = CreatedDate;
    _data['LastUpdate'] = LastUpdate;
    _data['AdminNote'] = AdminNote;
    return _data;
  }
}

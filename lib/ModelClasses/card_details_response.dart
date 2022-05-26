class CardDetailsResponse {
  CardDetailsResponse({
    required this.status,
    required this.getUserCardDetails,
  });
  late final bool status;
  late final List<GetUserCardDetails> getUserCardDetails;

  CardDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    getUserCardDetails = List.from(json['getUserCardDetails'])
        .map((e) => GetUserCardDetails.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['getUserCardDetails'] =
        getUserCardDetails.map((e) => e.toJson()).toList();
    return _data;
  }
}

class GetUserCardDetails {
  GetUserCardDetails({
    required this.UserPaymentID,
    required this.UserID,
    required this.Name,
    required this.CardNumber,
    required this.ExpirationDate,
    required this.Address1,
    required this.Address2,
    required this.City,
    required this.State,
    required this.ZipCode,
    required this.CountryID,
    required this.PaymentAccount,
    required this.PaymentRouting,
    required this.GatewayID,
    required this.LastUpdate,
    required this.DefaultPayment,
    required this.Country,
  });
  late final int UserPaymentID;
  late final int UserID;
  late final String Name;
  late final String CardNumber;
  late final String ExpirationDate;
  late final String Address1;
  late final String Address2;
  late final String City;
  late final String State;
  late final String ZipCode;
  late final int CountryID;
  late final String PaymentAccount;
  late final String PaymentRouting;
  late final int GatewayID;
  late final String LastUpdate;
  late final String DefaultPayment;
  late final String Country;

  GetUserCardDetails.fromJson(Map<String, dynamic> json) {
    UserPaymentID = json['UserPaymentID'];
    UserID = json['UserID'];
    Name = json['Name'];
    CardNumber = json['CardNumber'];
    ExpirationDate = json['ExpirationDate'];
    Address1 = json['Address1'];
    Address2 = json['Address2'];
    City = json['City'];
    State = json['State'];
    ZipCode = json['ZipCode'];
    CountryID = json['CountryID'];
    PaymentAccount = json['PaymentAccount'];
    PaymentRouting = json['PaymentRouting'];
    GatewayID = json['GatewayID'];
    LastUpdate = json['LastUpdate'];
    DefaultPayment = json['DefaultPayment'];
    Country = json['Country'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['UserPaymentID'] = UserPaymentID;
    _data['UserID'] = UserID;
    _data['Name'] = Name;
    _data['CardNumber'] = CardNumber;
    _data['ExpirationDate'] = ExpirationDate;
    _data['Address1'] = Address1;
    _data['Address2'] = Address2;
    _data['City'] = City;
    _data['State'] = State;
    _data['ZipCode'] = ZipCode;
    _data['CountryID'] = CountryID;
    _data['PaymentAccount'] = PaymentAccount;
    _data['PaymentRouting'] = PaymentRouting;
    _data['GatewayID'] = GatewayID;
    _data['LastUpdate'] = LastUpdate;
    _data['DefaultPayment'] = DefaultPayment;
    _data['Country'] = Country;
    return _data;
  }
}

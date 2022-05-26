class AddUserPaymentModel {
  AddUserPaymentModel({
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
    required this.DefaultPayment,
    required this.PhoneNumber,
    required this.DefaultAddress,
    required this.UserNote,
  });
  late final String Name;
  late final String CardNumber;
  late final String ExpirationDate;
  late final String Address1;
  late final String Address2;
  late final String City;
  late final String State;
  late final String ZipCode;
  late final String CountryID;
  late final String PaymentAccount;
  late final String PaymentRouting;
  late final String GatewayID;
  late final String DefaultPayment;
  late final String PhoneNumber;
  late final String DefaultAddress;
  late final String UserNote;

  AddUserPaymentModel.fromJson(Map<String, dynamic> json) {
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
    DefaultPayment = json['DefaultPayment'];
    PhoneNumber = json['PhoneNumber'];
    DefaultAddress = json['DefaultAddress'];
    UserNote = json['UserNote'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
    _data['DefaultPayment'] = DefaultPayment;
    _data['PhoneNumber'] = PhoneNumber;
    _data['DefaultAddress'] = DefaultAddress;
    _data['UserNote'] = UserNote;
    return _data;
  }
}

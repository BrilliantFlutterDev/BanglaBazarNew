class UsersHistoryAddresses {
  UsersHistoryAddresses({
    required this.status,
    required this.userPaymentHistory,
    required this.userAddressHistory,
  });
  late final bool status;
  late final List<UserPaymentHistory> userPaymentHistory;
  late final List<UserAddressHistory> userAddressHistory;

  UsersHistoryAddresses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userPaymentHistory = List.from(json['userPaymentHistory'])
        .map((e) => UserPaymentHistory.fromJson(e))
        .toList();
    userAddressHistory = List.from(json['userAddressHistory'])
        .map((e) => UserAddressHistory.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['userPaymentHistory'] =
        userPaymentHistory.map((e) => e.toJson()).toList();
    _data['userAddressHistory'] =
        userAddressHistory.map((e) => e.toJson()).toList();
    return _data;
  }
}

class UserPaymentHistory {
  UserPaymentHistory({
    required this.PaymentType,
    required this.Country,
    required this.UserPaymentID,
    required this.UserID,
    required this.Name,
    required this.CardNumber,
    this.ExpirationDate,
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
  });
  late final String PaymentType;
  late final String Country;
  late final int UserPaymentID;
  late final int UserID;
  late final String Name;
  late final String CardNumber;
  late final Null ExpirationDate;
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
  bool isSelected = false;

  UserPaymentHistory.fromJson(Map<String, dynamic> json) {
    PaymentType = json['PaymentType'];
    Country = json['Country'];
    UserPaymentID = json['UserPaymentID'];
    UserID = json['UserID'];
    Name = json['Name'];
    CardNumber = json['CardNumber'];
    ExpirationDate = null;
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
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['PaymentType'] = PaymentType;
    _data['Country'] = Country;
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
    return _data;
  }
}

class UserAddressHistory {
  UserAddressHistory({
    required this.UserAddressID,
    required this.UserID,
    required this.Name,
    required this.PhoneNumber,
    required this.Address1,
    required this.Address2,
    required this.City,
    required this.State,
    required this.ZipCode,
    required this.CountryID,
    required this.LastUpdate,
    this.DefaultAddress,
    required this.UserNote,
    required this.AddressLabel,
    required this.CityID,
    required this.ZoneID,
    required this.AreaID,
    required this.DeliveryZone,
    required this.PathaoCityID,
    required this.DeliveryArea,
  });
  late final int UserAddressID;
  late final int UserID;
  late final String Name;
  late final String PhoneNumber;
  late final String Address1;
  late final String Address2;
  late final String City;
  late final String State;
  late final String ZipCode;
  late final int CountryID;
  late final String LastUpdate;
  late final Null DefaultAddress;
  late final String UserNote;
  late final String AddressLabel;
  late final int CityID;
  late final int ZoneID;
  late final int AreaID;
  late final String DeliveryZone;
  late final String DeliveryArea;
  late final int PathaoCityID;
  bool isSelected = false;

  UserAddressHistory.fromJson(Map<String, dynamic> json) {
    UserAddressID = json['UserAddressID'];
    UserID = json['UserID'];
    Name = json['Name'];
    PhoneNumber = json['PhoneNumber'];
    Address1 = json['Address1'];
    Address2 = json['Address2'];
    City = json['City'];
    State = json['State'];
    ZipCode = json['ZipCode'];
    CountryID = json['CountryID'];
    LastUpdate = json['LastUpdate'];
    DefaultAddress = null;
    UserNote = json['UserNote'];
    AddressLabel = json['AddressLabel'];
    CityID = json['CityID'];
    ZoneID = json['ZoneID'];
    AreaID = json['AreaID'];
    PathaoCityID = json['PathaoCityID'];
    DeliveryZone = json['DeliveryZone'];
    DeliveryArea = json['DeliveryArea'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['UserAddressID'] = UserAddressID;
    _data['UserID'] = UserID;
    _data['Name'] = Name;
    _data['PhoneNumber'] = PhoneNumber;
    _data['Address1'] = Address1;
    _data['Address2'] = Address2;
    _data['City'] = City;
    _data['State'] = State;
    _data['ZipCode'] = ZipCode;
    _data['CountryID'] = CountryID;
    _data['LastUpdate'] = LastUpdate;
    _data['DefaultAddress'] = DefaultAddress;
    _data['UserNote'] = UserNote;
    _data['AddressLabel'] = AddressLabel;
    _data['CityID'] = CityID;
    _data['ZoneID'] = ZoneID;
    _data['AreaID'] = AreaID;
    _data['PathaoCityID'] = PathaoCityID;
    _data['DeliveryZone'] = DeliveryZone;
    _data['DeliveryArea'] = DeliveryArea;
    return _data;
  }
}

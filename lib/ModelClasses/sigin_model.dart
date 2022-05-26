class SigninResponse {
  SigninResponse(
      {required this.status,
      required this.message,
      required this.user,
      this.userCardDetails,
      required this.token,
      this.deliveryDriverDetails});
  late final bool status;
  late final String message;
  late final User user;
  UserCardDetails? userCardDetails;
  DeliveryDriverDetails? deliveryDriverDetails;
  late final String token;

  SigninResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = User.fromJson(json['user']);
    userCardDetails = json['userCardDetails'] != null
        ? UserCardDetails.fromJson(json['userCardDetails'])
        : null;
    deliveryDriverDetails = json['deliveryDriverDetails'] != null
        ? DeliveryDriverDetails.fromJson(json['deliveryDriverDetails'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['user'] = user.toJson();
    _data['userCardDetails'] = userCardDetails!.toJson();
    _data['deliveryDriverDetails'] = deliveryDriverDetails!.toJson();
    _data['token'] = token;
    return _data;
  }
}

class User {
  User({
    required this.UserID,
    required this.UserName,
    required this.BirthDay,
    required this.Gender,
    required this.ProfilePic,
    required this.SecretQuestion,
    required this.Answer,
    required this.EmailAddress,
    required this.PhoneNumber,
    required this.Password,
    required this.AccessCodeEmail,
    required this.AccessCodePhone,
    required this.EmailVerified,
    required this.PhoneVerified,
    required this.Customer,
    required this.DeliveryPerson,
    required this.Vendor,
    required this.Admin,
    required this.SuperAdmin,
    required this.CreatedDate,
    required this.IPAddress,
    required this.Active,
    required this.LastUpdate,
    required this.AdminNote,
  });
  late final int UserID;
  late final String UserName;
  String? BirthDay;
  late final String Gender;
  late final String ProfilePic;
  String? SecretQuestion;
  String? Answer;
  late final String EmailAddress;
  late final String PhoneNumber;
  late final String Password;
  late final String AccessCodeEmail;
  late final String? AccessCodePhone;
  late final String EmailVerified;
  late final String? PhoneVerified;
  late final String Customer;
  late final String? DeliveryPerson;
  late final String Vendor;
  late final String? Admin;
  String? SuperAdmin;
  late final String? CreatedDate;
  late final String IPAddress;
  late final String Active;
  late final String? LastUpdate;
  String? AdminNote;

  User.fromJson(Map<String, dynamic> json) {
    UserID = json['UserID'];
    UserName = json['UserName'] ?? '';
    BirthDay = json['BirthDay'] != null ? json['BirthDay'] : '';
    Gender = json['Gender'] ?? '';
    ProfilePic = json['ProfilePic'] ?? '';
    SecretQuestion =
        json['SecretQuestion'] != null ? json['SecretQuestion'] : '';
    Answer = json['Answer'] != null ? json['Answer'] : '';
    EmailAddress = json['EmailAddress'] ?? '';
    PhoneNumber = json['PhoneNumber'] ?? '';
    Password = json['Password'] ?? '';
    AccessCodeEmail = json['AccessCodeEmail'] ?? '';
    AccessCodePhone =
        json['AccessCodePhone'] != null ? json['AccessCodePhone'] : '';
    EmailVerified = json['EmailVerified'] ?? '';
    PhoneVerified = json['PhoneVerified'] != null ? json['PhoneVerified'] : '';
    Customer = json['Customer'] ?? '';
    DeliveryPerson = json['DeliveryPerson'] ?? '';
    Vendor = json['Vendor'] ?? '';
    Admin = json['Admin'] ?? '';
    SuperAdmin = json['SuperAdmin'] != null ? json['SuperAdmin'] : '';
    CreatedDate = json['CreatedDate'] ?? '';
    IPAddress = json['IPAddress'] ?? '';
    Active = json['Active'] ?? '';
    LastUpdate = json['LastUpdate'] ?? '';
    AdminNote = json['AdminNote'] != null ? json['AdminNote'] : '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['UserID'] = UserID;
    _data['UserName'] = UserName;
    _data['BirthDay'] = BirthDay;
    _data['Gender'] = Gender;
    // _data['ProfilePic'] = ProfilePic;
    // _data['SecretQuestion'] = SecretQuestion;
    // _data['Answer'] = Answer;
    _data['EmailAddress'] = EmailAddress;
    //_data['PhoneNumber'] = PhoneNumber;
    _data['Password'] = Password;
    _data['AccessCodeEmail'] = AccessCodeEmail;
    //_data['AccessCodePhone'] = AccessCodePhone;
    _data['EmailVerified'] = EmailVerified;
    _data['PhoneVerified'] = PhoneVerified;
    _data['Customer'] = Customer;
    // _data['DeliveryPerson'] = DeliveryPerson;
    // _data['Vendor'] = Vendor;
    // _data['Admin'] = Admin;
    // _data['SuperAdmin'] = SuperAdmin;
    _data['CreatedDate'] = CreatedDate;
    _data['IPAddress'] = IPAddress;
    _data['Active'] = Active;
    // _data['LastUpdate'] = LastUpdate;
    // _data['AdminNote'] = AdminNote;
    return _data;
  }
}

class UserCardDetails {
  UserCardDetails({
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
    //required this.GatewayID,
    required this.LastUpdate,
    required this.DefaultPayment,
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
  //int? GatewayID;
  late final String LastUpdate;
  late final String DefaultPayment;

  UserCardDetails.fromJson(Map<String, dynamic> json) {
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
    // GatewayID = json['GatewayID'] != null ? json['GatewayID'] : '';
    LastUpdate = json['LastUpdate'];
    DefaultPayment = json['DefaultPayment'];
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
    //_data['GatewayID'] = GatewayID;
    _data['LastUpdate'] = LastUpdate;
    _data['DefaultPayment'] = DefaultPayment;
    return _data;
  }
}

class DeliveryDriverDetails {
  DeliveryDriverDetails({
    required this.DeliveryDriverID,
    required this.GovernmentID,
    this.GovernmentIDPic,
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
    this.LastUpdate,
    this.AdminNote,
  });
  late final int DeliveryDriverID;
  late final String GovernmentID;
  String? GovernmentIDPic;
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
  int? GatewayID;
  late final String CreatedDate;
  String? LastUpdate;
  String? AdminNote;

  DeliveryDriverDetails.fromJson(Map<String, dynamic> json) {
    DeliveryDriverID = json['DeliveryDriverID'];
    GovernmentID = json['GovernmentID'];
    GovernmentIDPic =
        json['GovernmentIDPic'] != null ? json['GovernmentIDPic'] : null;
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
    GatewayID = json['GatewayID'] != null ? json['GatewayID'] : null;
    CreatedDate = json['CreatedDate'];
    LastUpdate = json['LastUpdate'] != null ? json['LastUpdate'] : null;
    AdminNote = json['AdminNote'] != null ? json['AdminNote'] : null;
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

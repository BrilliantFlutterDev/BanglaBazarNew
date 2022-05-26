class AlreadyHaveBusinessResponse {
  AlreadyHaveBusinessResponse({
    required this.status,
    required this.message,
    this.business,
  });
  late final bool status;
  late final String message;
  Business? business;

  AlreadyHaveBusinessResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    business =
        json['business'] != null ? Business.fromJson(json['business']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['business'] = business!.toJson();
    return _data;
  }
}

class Business {
  Business({
    required this.VendorID,
    required this.CompanyName,
    required this.TaxID,
    required this.TaxIDPic,
    required this.GovernmentID,
    required this.GovernmentIDPic,
    required this.CompanyLogo,
    required this.BannerImage,
    required this.Address1,
    required this.Address2,
    required this.CityID,
    required this.City,
    required this.State,
    required this.ZipCode,
    required this.GoogleMapID,
    required this.CountryID,
    required this.PaymentAccount,
    required this.PaymentRouting,
    required this.BusinessEmail,
    required this.BusinessPhone,
    required this.EmailVerified,
    required this.PhoneVerified,
    required this.BusinessURL,
    required this.PageURL,
    required this.ReviewedByAdmin,
    required this.ReviewedBySuperAdmin,
    required this.GatewayID,
    required this.AllowDelivery,
    required this.AllowStorePickup,
    required this.ProductApproval,
    required this.CreatedDate,
    required this.LastUpdate,
    required this.About,
    required this.Policies,
    required this.AdminNote,
  });
  late final int VendorID;
  late final String CompanyName;
  late final String TaxID;
  late final String TaxIDPic;
  late final String GovernmentID;
  late final String GovernmentIDPic;
  late final String CompanyLogo;
  late final String BannerImage;
  late final String Address1;
  late final String Address2;
  late final int CityID;
  late final String City;
  late final String State;
  late final String ZipCode;
  late final String GoogleMapID;
  late final int CountryID;
  late final String PaymentAccount;
  late final String PaymentRouting;
  late final String BusinessEmail;
  late final String BusinessPhone;
  late final String EmailVerified;
  late final String PhoneVerified;
  late final String BusinessURL;
  late final String PageURL;
  late final String ReviewedByAdmin;
  late final String ReviewedBySuperAdmin;
  late final int GatewayID;
  late final String AllowDelivery;
  late final String AllowStorePickup;
  late final String ProductApproval;
  late final String CreatedDate;
  late final String LastUpdate;
  late final String About;
  late final String Policies;
  late final String AdminNote;

  Business.fromJson(Map<String, dynamic> json) {
    VendorID = json['VendorID'];
    CompanyName = json['CompanyName'];
    TaxID = json['TaxID'];
    TaxIDPic = json['TaxIDPic'];
    GovernmentID = json['GovernmentID'];
    GovernmentIDPic = json['GovernmentIDPic'];
    CompanyLogo = json['CompanyLogo'];
    BannerImage = json['BannerImage'];
    Address1 = json['Address1'] ?? '';
    Address2 = json['Address2'] ?? '';
    CityID = json['CityID'];
    City = json['City'];
    State = json['State'];
    ZipCode = json['ZipCode'];
    GoogleMapID = json['GoogleMapID'];
    CountryID = json['CountryID'];
    PaymentAccount = json['PaymentAccount'] ?? '';
    PaymentRouting = json['PaymentRouting'] ?? '';
    BusinessEmail = json['BusinessEmail'] ?? '';
    BusinessPhone = json['BusinessPhone'] ?? '';
    EmailVerified = json['EmailVerified'] ?? '';
    PhoneVerified = json['PhoneVerified'] ?? '';
    BusinessURL = json['BusinessURL'] ?? '';
    PageURL = json['PageURL'] ?? '';
    ReviewedByAdmin = json['ReviewedByAdmin'] ?? '';
    ReviewedBySuperAdmin = json['ReviewedBySuperAdmin'] ?? '';
    GatewayID = json['GatewayID'];
    AllowDelivery = json['AllowDelivery'] ?? '';
    AllowStorePickup = json['AllowStorePickup'] ?? '';
    ProductApproval = json['ProductApproval'] ?? '';
    CreatedDate = json['CreatedDate'] ?? '';
    LastUpdate = json['LastUpdate'] ?? '';
    About = json['About'] ?? '';
    Policies = json['Policies'] ?? '';
    AdminNote = json['AdminNote'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['VendorID'] = VendorID;
    _data['CompanyName'] = CompanyName;
    _data['TaxID'] = TaxID;
    _data['TaxIDPic'] = TaxIDPic;
    _data['GovernmentID'] = GovernmentID;
    _data['GovernmentIDPic'] = GovernmentIDPic;
    _data['CompanyLogo'] = CompanyLogo;
    _data['BannerImage'] = BannerImage;
    _data['Address1'] = Address1;
    _data['Address2'] = Address2;
    _data['CityID'] = CityID;
    _data['City'] = City;
    _data['State'] = State;
    _data['ZipCode'] = ZipCode;
    _data['GoogleMapID'] = GoogleMapID;
    _data['CountryID'] = CountryID;
    _data['PaymentAccount'] = PaymentAccount;
    _data['PaymentRouting'] = PaymentRouting;
    _data['BusinessEmail'] = BusinessEmail;
    _data['BusinessPhone'] = BusinessPhone;
    _data['EmailVerified'] = EmailVerified;
    _data['PhoneVerified'] = PhoneVerified;
    _data['BusinessURL'] = BusinessURL;
    _data['PageURL'] = PageURL;
    _data['ReviewedByAdmin'] = ReviewedByAdmin;
    _data['ReviewedBySuperAdmin'] = ReviewedBySuperAdmin;
    _data['GatewayID'] = GatewayID;
    _data['AllowDelivery'] = AllowDelivery;
    _data['AllowStorePickup'] = AllowStorePickup;
    _data['ProductApproval'] = ProductApproval;
    _data['CreatedDate'] = CreatedDate;
    _data['LastUpdate'] = LastUpdate;
    _data['About'] = About;
    _data['Policies'] = Policies;
    _data['AdminNote'] = AdminNote;
    return _data;
  }
}

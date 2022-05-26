class GetOrderDetailsResponse {
  GetOrderDetailsResponse({
    required this.status,
    required this.orderDetails,
    this.orderShippingDetail,
    this.deliveryDriverDetails,
    this.getStorePickupDetails,
  });
  late final bool status;
  late final OrderDetails orderDetails;
  OrderShippingDetail? orderShippingDetail;
  DeliveryDriverDetails? deliveryDriverDetails;
  GetStorePickupDetails? getStorePickupDetails;

  GetOrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    orderDetails = OrderDetails.fromJson(json['orderDetails']);
    orderShippingDetail = json['orderShippingDetail'] != null
        ? OrderShippingDetail.fromJson(json['orderShippingDetail'])
        : null;
    deliveryDriverDetails = json['deliveryDriverDetails'] != null
        ? DeliveryDriverDetails.fromJson(json['deliveryDriverDetails'])
        : null;
    getStorePickupDetails = json['getStorePickupDetails'] != null
        ? GetStorePickupDetails.fromJson(json['getStorePickupDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['orderDetails'] = orderDetails.toJson();
    // _data['orderShippingDetail'] = orderShippingDetail!.toJson();
    // _data['deliveryDriverDetails'] = deliveryDriverDetails!.toJson();
    // _data['getStorePickupDetails'] = getStorePickupDetails!.toJson();
    return _data;
  }
}

class OrderDetails {
  OrderDetails({
    required this.OrderNumber,
    required this.OrderDate,
    required this.PaymentStatus,
    required this.TransactionID,
    required this.AllowStorePickup,
    required this.ReadyPickupForUser,
    required this.ReadyPickupForAdmin,
    required this.AllowAdminPickup,
    required this.StatusHistory,
    required this.ProcessStatus,
    required this.productDetail,
  });
  late final String OrderNumber;
  String? OrderDate;
  late final String PaymentStatus;
  late final String TransactionID;
  late final String AllowStorePickup;
  late final String ReadyPickupForUser;
  late final String ReadyPickupForAdmin;
  late final String AllowAdminPickup;
  late final String StatusHistory;
  late final String ProcessStatus;
  late final String OrderTotal;
  late final String ShippingHandling;

  double totalOrderPrice = 0.0;
  late final List<ProductDetail> productDetail;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    OrderNumber = json['OrderNumber'];
    OrderDate = json['OrderDate'];
    PaymentStatus = json['PaymentStatus'];
    TransactionID = json['TransactionID'] ?? '';
    AllowStorePickup = json['AllowStorePickup'];
    ReadyPickupForUser = json['ReadyPickupForUser'];
    ReadyPickupForAdmin = json['ReadyPickupForAdmin'];
    AllowAdminPickup = json['AllowAdminPickup'];
    StatusHistory = json['StatusHistory'] != null ? json['StatusHistory'] : '';
    ProcessStatus = json['ProcessStatus'];
    OrderTotal = json['OrderTotal'];
    ShippingHandling = json['ShippingHandling'];

    productDetail = List.from(json['ProductDetail'])
        .map((e) => ProductDetail.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['OrderNumber'] = OrderNumber;
    _data['OrderDate'] = OrderDate;
    _data['PaymentStatus'] = PaymentStatus;
    _data['TransactionID'] = TransactionID;
    _data['AllowStorePickup'] = AllowStorePickup;
    _data['ReadyPickupForUser'] = ReadyPickupForUser;
    _data['ReadyPickupForAdmin'] = ReadyPickupForAdmin;
    _data['AllowAdminPickup'] = AllowAdminPickup;
    _data['StatusHistory'] = StatusHistory;
    _data['ProcessStatus'] = ProcessStatus;
    _data['OrderTotal'] = OrderTotal;

    _data['ShippingHandling'] = ShippingHandling;
    _data['ProductDetail'] = productDetail.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductDetail {
  ProductDetail({
    required this.ProductID,
    required this.Title,
    this.TransactionID,
    required this.OrderNumber,
    required this.AllowStorePickup,
    required this.AllowAdminPickup,
    required this.ReadyPickupForUser,
    required this.ReadyPickupForAdmin,
    required this.OrderDate,
    required this.PaymentStatus,
    required this.BasePrice,
    required this.Quantity,
    required this.Currency,
    required this.UserID,
    required this.Small,
    required this.Medium,
    required this.Large,
    required this.MainImage,
    required this.StatusHistory,
    required this.ProcessStatus,
    this.DeliveryDriverID,
    this.ConsignmentId,
    required this.REVIEWCOUNT,
    this.AVGRating,
    required this.StoreName,
    required this.StoreAddress,
    required this.StorePhone,
    required this.productCombinations,
  });
  late final int ProductID;
  late final String Title;
  late final String? TransactionID;
  late final String OrderNumber;
  late final String AllowStorePickup;
  late final String AllowAdminPickup;
  late final String ReadyPickupForUser;
  late final String ReadyPickupForAdmin;
  late final String OrderDate;
  late final String PaymentStatus;
  late final String BasePrice;
  late final int Quantity;
  late final String Currency;
  late final int UserID;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final String MainImage;
  late final String StatusHistory;
  late final String ProcessStatus;
  late final int? DeliveryDriverID;
  late final String? ConsignmentId;
  late final int REVIEWCOUNT;
  late final String? AVGRating;
  late final String StoreName;
  late final String StoreAddress;
  late final String StorePhone;
  bool selectedForReturn = false;
  double totalProductPrice = 0.0;
  late final List<ProductCombinations> productCombinations;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'] ?? -1;
    Title = json['Title'] ?? '';
    TransactionID = json['TransactionID'] ?? '';
    OrderNumber = json['OrderNumber'] ?? '';
    AllowStorePickup = json['AllowStorePickup'] ?? '';
    AllowAdminPickup = json['AllowAdminPickup'] ?? '';
    ReadyPickupForUser = json['ReadyPickupForUser'] ?? '';
    ReadyPickupForAdmin = json['ReadyPickupForAdmin'] ?? '';
    OrderDate = json['OrderDate'] ?? '';
    PaymentStatus = json['PaymentStatus'] ?? '';
    BasePrice = json['BasePrice'] ?? '';
    Quantity = json['Quantity'] ?? 0;
    Currency = json['Currency'] ?? '';
    UserID = json['UserID'] ?? -1;
    Small = json['Small'] ?? '';
    Medium = json['Medium'] ?? '';
    Large = json['Large'] ?? '';
    MainImage = json['MainImage'] ?? '';
    StatusHistory = json['StatusHistory'] ?? '';
    ProcessStatus = json['ProcessStatus'] ?? '';
    REVIEWCOUNT = json['REVIEW_COUNT'] ?? 0;
    DeliveryDriverID = json['DeliveryDriverID'] ?? -1;
    ConsignmentId = json['ConsignmentId'] ?? '';
    AVGRating = json['AVG_Rating'] ?? '';
    StoreName = json['StoreName'];
    StoreAddress = json['StoreAddress'];
    StorePhone = json['StorePhone'];

    productCombinations = List.from(json['ProductCombinations'])
        .map((e) => ProductCombinations.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['Title'] = Title;
    _data['TransactionID'] = TransactionID;
    _data['OrderNumber'] = OrderNumber;
    _data['AllowStorePickup'] = AllowStorePickup;
    _data['AllowAdminPickup'] = AllowAdminPickup;
    _data['ReadyPickupForUser'] = ReadyPickupForUser;
    _data['ReadyPickupForAdmin'] = ReadyPickupForAdmin;
    _data['OrderDate'] = OrderDate;
    _data['PaymentStatus'] = PaymentStatus;
    _data['BasePrice'] = BasePrice;
    _data['Quantity'] = Quantity;
    _data['Currency'] = Currency;
    _data['UserID'] = UserID;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['MainImage'] = MainImage;
    _data['StatusHistory'] = StatusHistory;
    _data['ProcessStatus'] = ProcessStatus;
    _data['DeliveryDriverID'] = DeliveryDriverID;
    _data['ConsignmentId'] = ConsignmentId;
    _data['REVIEW_COUNT'] = REVIEWCOUNT;
    _data['AVG_Rating'] = AVGRating;
    _data['StoreName'] = StoreName;
    _data['StoreAddress'] = StoreAddress;
    _data['StorePhone'] = StorePhone;
    _data['ProductCombinations'] =
        productCombinations.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductCombinations {
  ProductCombinations({
    required this.ProductID,
    required this.ProductVariantCombinationID,
    required this.VendorStoreID,
    required this.ProductCombinationPrice,
    required this.AvailableInventory,
    required this.OptionID,
    required this.OptionName,
    required this.OptionValue,
    required this.OptionValueID,
  });
  late final int ProductID;
  late final int ProductVariantCombinationID;
  late final int VendorStoreID;
  late final String ProductCombinationPrice;
  late final int AvailableInventory;
  late final int OptionID;
  late final String OptionName;
  late final String OptionValue;
  late final int OptionValueID;

  ProductCombinations.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'] ?? -1;
    ProductVariantCombinationID = json['ProductVariantCombinationID'] ?? -1;
    VendorStoreID = json['VendorStoreID'] ?? -1;
    ProductCombinationPrice = json['ProductCombinationPrice'] ?? '0';
    AvailableInventory = json['AvailableInventory'] ?? 0;
    OptionID = json['OptionID'] ?? -1;
    OptionName = json['OptionName'] ?? '';
    OptionValue = json['OptionValue'] ?? '';
    OptionValueID = json['OptionValueID'] ?? -1;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['ProductVariantCombinationID'] = ProductVariantCombinationID;
    _data['VendorStoreID'] = VendorStoreID;
    _data['ProductCombinationPrice'] = ProductCombinationPrice;
    _data['AvailableInventory'] = AvailableInventory;
    _data['OptionID'] = OptionID;
    _data['OptionName'] = OptionName;
    _data['OptionValue'] = OptionValue;
    _data['OptionValueID'] = OptionValueID;
    return _data;
  }
}

class OrderShippingDetail {
  OrderShippingDetail({
    required this.DeliveryAddressID,
    required this.OrderNumber,
    required this.DeliveryName,
    required this.DeliveryPhoneNumber,
    required this.DeliveryAddress1,
    required this.DeliveryAddress2,
    required this.DeliveryCity,
    required this.DeliveryState,
    required this.DeliveryCountryID,
    required this.DeliveryCountry,
    required this.DeliveryZipCode,
    required this.DesireDate,
    required this.DeliveryUserNote,
  });
  late final int DeliveryAddressID;
  late final String OrderNumber;
  late final String DeliveryName;
  late final String DeliveryPhoneNumber;
  late final String DeliveryAddress1;
  late final String DeliveryAddress2;
  late final String DeliveryCity;
  late final String DeliveryState;
  late final int DeliveryCountryID;
  late final String DeliveryCountry;
  late final String DeliveryZipCode;
  late final String DesireDate;
  late final String DeliveryUserNote;

  OrderShippingDetail.fromJson(Map<String, dynamic> json) {
    ///
    DeliveryAddressID = json['DeliveryAddressID'] ?? 0;
    OrderNumber = json['OrderNumber'] ?? '';
    DeliveryName = json['DeliveryName'] ?? '';
    DeliveryPhoneNumber = json['DeliveryPhoneNumber'] ?? '';
    DeliveryAddress1 = json['DeliveryAddress1'] ?? '';
    DeliveryAddress2 = json['DeliveryAddress2'] ?? '';
    DeliveryCity = json['DeliveryCity'] ?? '';
    DeliveryState = json['DeliveryState'] ?? '';
    DeliveryCountryID = json['DeliveryCountryID'] ?? 0;
    DeliveryCountry = json['DeliveryCountry'] ?? '';
    DeliveryZipCode = json['DeliveryZipCode'] ?? '';
    DesireDate = json['DesireDate'] ?? '';
    DeliveryUserNote = json['DeliveryUserNote'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['DeliveryAddressID'] = DeliveryAddressID;
    _data['OrderNumber'] = OrderNumber;
    _data['DeliveryName'] = DeliveryName;
    _data['DeliveryPhoneNumber'] = DeliveryPhoneNumber;
    _data['DeliveryAddress1'] = DeliveryAddress1;
    _data['DeliveryAddress2'] = DeliveryAddress2;
    _data['DeliveryCity'] = DeliveryCity;
    _data['DeliveryState'] = DeliveryState;
    _data['DeliveryCountryID'] = DeliveryCountryID;
    _data['DeliveryCountry'] = DeliveryCountry;
    _data['DeliveryZipCode'] = DeliveryZipCode;
    _data['DesireDate'] = DesireDate;
    _data['DeliveryUserNote'] = DeliveryUserNote;
    return _data;
  }
}

class DeliveryDriverDetails {
  DeliveryDriverDetails({
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
    required this.AdminNote,
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
    required this.IPAddress,
    required this.Active,
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
  late final String AdminNote;
  late final int UserID;
  late final String UserName;
  late final String BirthDay;
  late final String Gender;
  late final String ProfilePic;
  late final String SecretQuestion;
  late final String Answer;
  late final String EmailAddress;
  late final String PhoneNumber;
  late final String Password;
  late final String AccessCodeEmail;
  late final String AccessCodePhone;
  late final String EmailVerified;
  late final String PhoneVerified;
  late final String Customer;
  late final String DeliveryPerson;
  late final String Vendor;
  late final String Admin;
  late final String SuperAdmin;
  late final String IPAddress;
  late final String Active;

  DeliveryDriverDetails.fromJson(Map<String, dynamic> json) {
    DeliveryDriverID =
        json['DeliveryDriverID'] != null ? json['DeliveryDriverID'] : 0;
    GovernmentID = json['GovernmentID'] != null ? json['GovernmentID'] : '';
    GovernmentIDPic =
        json['GovernmentIDPic'] != null ? json['GovernmentIDPic'] : '';
    Address1 = json['Address1'] != null ? json['Address1'] : '';
    Address2 = json['Address2'] != null ? json['Address2'] : '';
    CityID = json['CityID'] != null ? json['CityID'] : 0;
    City = json['City'] != null ? json['City'] : '';
    State = json['State'] != null ? json['State'] : '';
    ZipCode = json['ZipCode'] != null ? json['ZipCode'] : '';
    CountryID = json['CountryID'] != null ? json['CountryID'] : 0;
    PaymentAccount =
        json['PaymentAccount'] != null ? json['PaymentAccount'] : '';
    PaymentRouting =
        json['PaymentRouting'] != null ? json['PaymentRouting'] : '';
    BusinessEmail = json['BusinessEmail'] != null ? json['BusinessEmail'] : '';
    BusinessPhone = json['BusinessPhone'] != null ? json['BusinessPhone'] : '';
    BusinessURL = json['BusinessURL'] != null ? json['BusinessURL'] : '';
    ReviewedByAdmin =
        json['ReviewedByAdmin'] != null ? json['ReviewedByAdmin'] : '';
    GatewayID = json['GatewayID'] != null ? json['GatewayID'] : 0;
    CreatedDate = json['CreatedDate'] != null ? json['CreatedDate'] : '';
    LastUpdate = json['LastUpdate'] != null ? json['LastUpdate'] : '';
    AdminNote = json['AdminNote'] != null ? json['AdminNote'] : '';
    UserID = json['UserID'] != null ? json['UserID'] : -1;
    UserName = json['UserName'] != null ? json['UserName'] : '';
    BirthDay = json['BirthDay'] != null ? json['BirthDay'] : '';
    Gender = json['Gender'] != null ? json['Gender'] : '';
    ProfilePic = json['ProfilePic'] != null ? json['ProfilePic'] : '';
    SecretQuestion =
        json['SecretQuestion'] != null ? json['SecretQuestion'] : '';
    Answer = json['Answer'] != null ? json['Answer'] : '';
    EmailAddress = json['EmailAddress'] != null ? json['EmailAddress'] : '';
    PhoneNumber = json['PhoneNumber'] != null ? json['PhoneNumber'] : '';
    Password = json['Password'] != null ? json['Password'] : '';
    AccessCodeEmail =
        json['AccessCodeEmail'] != null ? json['AccessCodeEmail'] : '';
    AccessCodePhone =
        json['AccessCodePhone'] != null ? json['AccessCodePhone'] : '';
    EmailVerified = json['EmailVerified'] != null ? json['EmailVerified'] : '';
    PhoneVerified = json['PhoneVerified'] != null ? json['PhoneVerified'] : '';
    Customer = json['Customer'] != null ? json['Customer'] : '';
    DeliveryPerson =
        json['DeliveryPerson'] != null ? json['DeliveryPerson'] : '';
    Vendor = json['Vendor'] != null ? json['Vendor'] : '';
    Admin = json['Admin'] != null ? json['Admin'] : '';
    SuperAdmin = json['SuperAdmin'] != null ? json['SuperAdmin'] : '';
    IPAddress = json['IPAddress'] != null ? json['IPAddress'] : '';
    Active = json['Active'] != null ? json['Active'] : '';
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
    _data['UserID'] = UserID;
    _data['UserName'] = UserName;
    _data['BirthDay'] = BirthDay;
    _data['Gender'] = Gender;
    _data['ProfilePic'] = ProfilePic;
    _data['SecretQuestion'] = SecretQuestion;
    _data['Answer'] = Answer;
    _data['EmailAddress'] = EmailAddress;
    _data['PhoneNumber'] = PhoneNumber;
    _data['Password'] = Password;
    _data['AccessCodeEmail'] = AccessCodeEmail;
    _data['AccessCodePhone'] = AccessCodePhone;
    _data['EmailVerified'] = EmailVerified;
    _data['PhoneVerified'] = PhoneVerified;
    _data['Customer'] = Customer;
    _data['DeliveryPerson'] = DeliveryPerson;
    _data['Vendor'] = Vendor;
    _data['Admin'] = Admin;
    _data['SuperAdmin'] = SuperAdmin;
    _data['IPAddress'] = IPAddress;
    _data['Active'] = Active;
    return _data;
  }
}

class GetStorePickupDetails {
  GetStorePickupDetails({
    required this.CompanyName,
    required this.VendorStoreID,
    required this.VendorID,
    required this.StoreName,
    required this.Address1,
    required this.Address2,
    required this.CityID,
    required this.City,
    required this.State,
    required this.ZipCode,
    required this.CountryID,
    required this.StoreEmail,
    required this.StorePhone,
    required this.EmailVerified,
    required this.PhoneVerified,
    required this.StoreFAX,
    required this.StoreURL,
    required this.GoogleMapID,
    required this.ExceptDropOff,
    required this.Active,
    required this.LastUpdate,
    required this.AdminNote,
  });
  late final String CompanyName;
  late final int VendorStoreID;
  late final int VendorID;
  late final String StoreName;
  late final String Address1;
  late final String Address2;
  late final int CityID;
  late final String City;
  late final String State;
  late final String ZipCode;
  late final int CountryID;
  late final String StoreEmail;
  late final String StorePhone;
  late final String EmailVerified;
  late final String PhoneVerified;
  late final String StoreFAX;
  late final String StoreURL;
  late final String GoogleMapID;
  late final String ExceptDropOff;
  late final String Active;
  late final String LastUpdate;
  late final String AdminNote;

  GetStorePickupDetails.fromJson(Map<String, dynamic> json) {
    CompanyName = json['CompanyName'] ?? '';
    VendorStoreID = json['VendorStoreID'] ?? -1;
    VendorID = json['VendorID'] ?? -1;
    StoreName = json['StoreName'] ?? '';
    Address1 = json['Address1'] ?? '';
    Address2 = json['Address2'] ?? '';
    CityID = json['CityID'] ?? 0;
    City = json['City'] ?? '';
    State = json['State'] ?? '';
    ZipCode = json['ZipCode'] ?? '';
    CountryID = json['CountryID'] ?? 0;
    StoreEmail = json['StoreEmail'] ?? '';
    StorePhone = json['StorePhone'] ?? '';
    EmailVerified = json['EmailVerified'] ?? '';
    PhoneVerified = json['PhoneVerified'] ?? '';
    StoreFAX = json['StoreFAX'] ?? '';
    StoreURL = json['StoreURL'] ?? '';
    GoogleMapID = json['GoogleMapID'] ?? '';
    ExceptDropOff = json['ExceptDropOff'] ?? '';
    Active = json['Active'] ?? '';
    LastUpdate = json['LastUpdate'] ?? '';
    AdminNote = json['AdminNote'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CompanyName'] = CompanyName;
    _data['VendorStoreID'] = VendorStoreID;
    _data['VendorID'] = VendorID;
    _data['StoreName'] = StoreName;
    _data['Address1'] = Address1;
    _data['Address2'] = Address2;
    _data['CityID'] = CityID;
    _data['City'] = City;
    _data['State'] = State;
    _data['ZipCode'] = ZipCode;
    _data['CountryID'] = CountryID;
    _data['StoreEmail'] = StoreEmail;
    _data['StorePhone'] = StorePhone;
    _data['EmailVerified'] = EmailVerified;
    _data['PhoneVerified'] = PhoneVerified;
    _data['StoreFAX'] = StoreFAX;
    _data['StoreURL'] = StoreURL;
    _data['GoogleMapID'] = GoogleMapID;
    _data['ExceptDropOff'] = ExceptDropOff;
    _data['Active'] = Active;
    _data['LastUpdate'] = LastUpdate;
    _data['AdminNote'] = AdminNote;
    return _data;
  }
}

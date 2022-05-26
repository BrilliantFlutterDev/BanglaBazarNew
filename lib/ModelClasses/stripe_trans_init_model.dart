class StripeTransInitModel {
  StripeTransInitModel({
    required this.SessionID,
    required this.GatewayID,
    required this.GetawayConfirmation,
    required this.Name,
    required this.CardNumber,
    required this.ExpirationDate,
    required this.Address1,
    required this.Address2,
    required this.City,
    required this.State,
    required this.ZipCode,
    required this.CountryID,
    required this.Country,
    required this.PaymentAccount,
    required this.PaymentRouting,
    required this.DefaultPayment,
    required this.currency,
    required this.shippingMethod,
    required this.productName,
    required this.productCategory,
    required this.productProfile,
    required this.cusEmail,
    required this.cusPhone,
    required this.ItemsPrice,
    required this.ShippingHandling,
    required this.TotalBeforeTax,
    required this.EstimatedTax,
    required this.OrderTotal,
    required this.DeliveryName,
    required this.DeliveryPhoneNumber,
    required this.DeliveryAddress1,
    required this.DeliveryAddress2,
    required this.DeliveryState,
    required this.DeliveryCity,
    required this.DeliveryCityID,
    required this.DeliveryZoneID,
    required this.cusCountry,
    required this.DeliveryAreaID,
    required this.DeliveryZipCode,
    required this.DesireDeliveryDate,
    required this.DeliveryUserNote,
    required this.DeliveryZone,
    required this.DeliveryArea,
    required this.AddressLabel,
    required this.DefaultAddress,
    required this.saveAddress,
    required this.homeAddress,
    required this.PaymentStatus,
    required this.TrackingNumber,
    required this.ShippingLabel,
    required this.DeliveryConfirmationPic,
    required this.AllowStorePickup,
    required this.ProcessStatus,
    required this.VendorPaymentStatus,
    required this.Note,
    required this.AllowAdminPickup,
    required this.DeliveryStatus,
    required this.PaymentType,
    required this.productDetail,
  });
  late final String SessionID;
  late final String GatewayID;
  late final String GetawayConfirmation;
  late final String Name;
  late final String CardNumber;
  late final String? ExpirationDate;
  late final String Address1;
  late final String Address2;
  late final String City;
  late final String State;
  late final String ZipCode;
  late final String CountryID;
  late final String Country;
  late final String PaymentAccount;
  late final String PaymentRouting;
  late final String DefaultPayment;
  late final String currency;
  late final String shippingMethod;
  late final String productName;
  late final String productCategory;
  late final String productProfile;
  late final String cusEmail;
  late final String cusPhone;
  late final String ItemsPrice;
  late final String ShippingHandling;
  late final String TotalBeforeTax;
  late final String EstimatedTax;
  late final String OrderTotal;
  late final String DeliveryName;
  late final String DeliveryPhoneNumber;
  late final String DeliveryAddress1;
  late final String DeliveryAddress2;
  late final String DeliveryState;
  late final String DeliveryCity;
  late final String DeliveryCityID;
  late final String DeliveryZoneID;
  late final String cusCountry;
  late final String DeliveryAreaID;
  late final String DeliveryZipCode;
  late final String DesireDeliveryDate;
  late final String DeliveryUserNote;
  late final String DeliveryZone;
  late final String DeliveryArea;
  late final String AddressLabel;
  late final String DefaultAddress;
  late final bool saveAddress;
  late final bool homeAddress;
  late final String PaymentStatus;
  late final String? TrackingNumber;
  late final String? ShippingLabel;
  late final String? DeliveryConfirmationPic;
  late final String AllowStorePickup;
  late final String ProcessStatus;
  late final String VendorPaymentStatus;
  late final String Note;
  late final String AllowAdminPickup;
  late final String DeliveryStatus;
  late final String PaymentType;
  late final List<ProductDetail> productDetail;

  StripeTransInitModel.fromJson(Map<String, dynamic> json) {
    SessionID = json['SessionID'];
    GatewayID = json['GatewayID'];
    GetawayConfirmation = json['GetawayConfirmation'];
    Name = json['Name'];
    CardNumber = json['CardNumber'];
    ExpirationDate = json['ExpirationDate'];
    Address1 = json['Address1'];
    Address2 = json['Address2'];
    City = json['City'];
    State = json['State'];
    ZipCode = json['ZipCode'];
    CountryID = json['CountryID'];
    Country = json['Country'];
    PaymentAccount = json['PaymentAccount'];
    PaymentRouting = json['PaymentRouting'];
    DefaultPayment = json['DefaultPayment'];
    currency = json['currency'];
    shippingMethod = json['shipping_method'];
    productName = json['product_name'];
    productCategory = json['product_category'];
    productProfile = json['product_profile'];
    cusEmail = json['cus_email'];
    cusPhone = json['cus_phone'];
    ItemsPrice = json['ItemsPrice'];
    ShippingHandling = json['ShippingHandling'];
    TotalBeforeTax = json['TotalBeforeTax'];
    EstimatedTax = json['EstimatedTax'];
    OrderTotal = json['OrderTotal'];
    DeliveryName = json['DeliveryName'];
    DeliveryPhoneNumber = json['DeliveryPhoneNumber'];
    DeliveryAddress1 = json['DeliveryAddress1'];
    DeliveryAddress2 = json['DeliveryAddress2'];
    DeliveryState = json['DeliveryState'];
    DeliveryCity = json['DeliveryCity'];
    DeliveryCityID = json['DeliveryCityID'];
    DeliveryZoneID = json['DeliveryZoneID'];
    cusCountry = json['cus_country'];
    DeliveryAreaID = json['DeliveryAreaID'];
    DeliveryZipCode = json['DeliveryZipCode'];
    DesireDeliveryDate = json['DesireDeliveryDate'];
    DeliveryUserNote = json['DeliveryUserNote'];
    DeliveryZone = json['DeliveryZone'];
    DeliveryArea = json['DeliveryArea'];
    AddressLabel = json['AddressLabel'];
    DefaultAddress = json['DefaultAddress'];
    saveAddress = json['saveAddress'];
    homeAddress = json['homeAddress'];
    PaymentStatus = json['PaymentStatus'];
    TrackingNumber = json['TrackingNumber'];
    ShippingLabel = json['ShippingLabel'];
    DeliveryConfirmationPic = json['DeliveryConfirmationPic'];
    AllowStorePickup = json['AllowStorePickup'];
    ProcessStatus = json['ProcessStatus'];
    VendorPaymentStatus = json['VendorPaymentStatus'];
    Note = json['Note'];
    AllowAdminPickup = json['AllowAdminPickup'];
    DeliveryStatus = json['DeliveryStatus'];
    PaymentType = json['PaymentType'];
    productDetail = List.from(json['ProductDetail'])
        .map((e) => ProductDetail.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['SessionID'] = SessionID;
    _data['GatewayID'] = GatewayID;
    _data['GetawayConfirmation'] = GetawayConfirmation;
    _data['Name'] = Name;
    _data['CardNumber'] = CardNumber;
    _data['ExpirationDate'] = ExpirationDate;
    _data['Address1'] = Address1;
    _data['Address2'] = Address2;
    _data['City'] = City;
    _data['State'] = State;
    _data['ZipCode'] = ZipCode;
    _data['CountryID'] = CountryID;
    _data['Country'] = Country;
    _data['PaymentAccount'] = PaymentAccount;
    _data['PaymentRouting'] = PaymentRouting;
    _data['DefaultPayment'] = DefaultPayment;
    _data['currency'] = currency;
    _data['shipping_method'] = shippingMethod;
    _data['product_name'] = productName;
    _data['product_category'] = productCategory;
    _data['product_profile'] = productProfile;
    _data['cus_email'] = cusEmail;
    _data['cus_phone'] = cusPhone;
    _data['ItemsPrice'] = ItemsPrice;
    _data['ShippingHandling'] = ShippingHandling;
    _data['TotalBeforeTax'] = TotalBeforeTax;
    _data['EstimatedTax'] = EstimatedTax;
    _data['OrderTotal'] = OrderTotal;
    _data['DeliveryName'] = DeliveryName;
    _data['DeliveryPhoneNumber'] = DeliveryPhoneNumber;
    _data['DeliveryAddress1'] = DeliveryAddress1;
    _data['DeliveryAddress2'] = DeliveryAddress2;
    _data['DeliveryState'] = DeliveryState;
    _data['DeliveryCity'] = DeliveryCity;
    _data['DeliveryCityID'] = DeliveryCityID;
    _data['DeliveryZoneID'] = DeliveryZoneID;
    _data['cus_country'] = cusCountry;
    _data['DeliveryAreaID'] = DeliveryAreaID;
    _data['DeliveryZipCode'] = DeliveryZipCode;
    _data['DesireDeliveryDate'] = DesireDeliveryDate;
    _data['DeliveryUserNote'] = DeliveryUserNote;
    _data['DeliveryZone'] = DeliveryZone;
    _data['DeliveryArea'] = DeliveryArea;
    _data['AddressLabel'] = AddressLabel;
    _data['DefaultAddress'] = DefaultAddress;
    _data['saveAddress'] = saveAddress;
    _data['homeAddress'] = homeAddress;
    _data['PaymentStatus'] = PaymentStatus;
    _data['TrackingNumber'] = TrackingNumber;
    _data['ShippingLabel'] = ShippingLabel;
    _data['DeliveryConfirmationPic'] = DeliveryConfirmationPic;
    _data['AllowStorePickup'] = AllowStorePickup;
    _data['ProcessStatus'] = ProcessStatus;
    _data['VendorPaymentStatus'] = VendorPaymentStatus;
    _data['Note'] = Note;
    _data['AllowAdminPickup'] = AllowAdminPickup;
    _data['DeliveryStatus'] = DeliveryStatus;
    _data['PaymentType'] = PaymentType;
    _data['ProductDetail'] = productDetail.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductDetail {
  ProductDetail({
    required this.ProductID,
    required this.VendorStoreID,
    required this.itemsPrice,
    required this.Quantity,
    required this.itemsShippingHandling,
    required this.itemsBeforeTax,
    required this.itemsEstimatedTax,
    required this.itemsTotal,
    required this.productVariantCombinationDetail,
  });
  late final String ProductID;
  late final String VendorStoreID;
  late final String itemsPrice;
  late final String Quantity;
  late final String itemsShippingHandling;
  late final String itemsBeforeTax;
  late final String itemsEstimatedTax;
  late final String itemsTotal;
  late final List<ProductVariantCombinationDetail>
      productVariantCombinationDetail;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    VendorStoreID = json['VendorStoreID'];
    itemsPrice = json['itemsPrice'];
    Quantity = json['Quantity'];
    itemsShippingHandling = json['itemsShippingHandling'];
    itemsBeforeTax = json['itemsBeforeTax'];
    itemsEstimatedTax = json['itemsEstimatedTax'];
    itemsTotal = json['itemsTotal'];
    productVariantCombinationDetail =
        List.from(json['ProductVariantCombinationDetail'])
            .map((e) => ProductVariantCombinationDetail.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['VendorStoreID'] = VendorStoreID;
    _data['itemsPrice'] = itemsPrice;
    _data['Quantity'] = Quantity;
    _data['itemsShippingHandling'] = itemsShippingHandling;
    _data['itemsBeforeTax'] = itemsBeforeTax;
    _data['itemsEstimatedTax'] = itemsEstimatedTax;
    _data['itemsTotal'] = itemsTotal;
    _data['ProductVariantCombinationDetail'] =
        productVariantCombinationDetail.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductVariantCombinationDetail {
  ProductVariantCombinationDetail({
    required this.ProductVariantCombinationID,
  });
  late final String ProductVariantCombinationID;

  ProductVariantCombinationDetail.fromJson(Map<String, dynamic> json) {
    ProductVariantCombinationID = json['ProductVariantCombinationID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductVariantCombinationID'] = ProductVariantCombinationID;
    return _data;
  }
}

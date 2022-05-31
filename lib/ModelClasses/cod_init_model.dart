class CODInitModel {
  CODInitModel({
    required this.SessionID,
    required this.GatewayID,
    required this.GetawayConfirmation,
    required this.DefaultPayment,
    required this.totalAmount,
    required this.currency,
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
    required this.cusCountry,
    required this.DeliveryZoneID,
    required this.DeliveryCountry,
    required this.DeliveryAreaID,
    required this.DeliveryCityID,
    required this.DeliveryZipCode,
    required this.DesireDeliveryDate,
    required this.DeliveryUserNote,
    required this.AddressLabel,
    required this.DeliveryZone,
    required this.DeliveryArea,
    required this.DefaultAddress,
    required this.homeAddress,
    required this.AllowStorePickup,
    required this.ProcessStatus,
    required this.VendorPaymentStatus,
    required this.AllowAdminPickup,
    required this.DeliveryStatus,
    required this.PaymentType,
    required this.productDetail,
  });
  late final String SessionID;
  late final String GatewayID;
  late final String GetawayConfirmation;
  late final String DefaultPayment;
  late final String totalAmount;
  late final String currency;
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
  late final String cusCountry;
  late final String DeliveryZoneID;
  late final String DeliveryCountry;
  late final String DeliveryAreaID;
  late final String DeliveryCityID;
  late final String DeliveryZipCode;
  late final String DesireDeliveryDate;
  late final String DeliveryUserNote;
  late final String AddressLabel;
  late final String DeliveryZone;
  late final String DeliveryArea;
  late final String DefaultAddress;
  late final bool homeAddress;

  ///
  late final String AllowStorePickup;
  late final String ProcessStatus;
  late final String VendorPaymentStatus;
  late final String AllowAdminPickup;
  late final String DeliveryStatus;
  late final String PaymentType;
  late final List<ProductDetail> productDetail;

  ///

  CODInitModel.fromJson(Map<String, dynamic> json) {
    SessionID = json['SessionID'];
    GatewayID = json['GatewayID'];
    GetawayConfirmation = json['GetawayConfirmation'];
    DefaultPayment = json['DefaultPayment'];
    totalAmount = json['total_amount'];
    currency = json['currency'];
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
    cusCountry = json['cus_country'];
    DeliveryZoneID = json['DeliveryZoneID'];
    DeliveryCountry = json['DeliveryCountry'];
    DeliveryAreaID = json['DeliveryAreaID'];
    DeliveryCityID = json['DeliveryCityID'];
    DeliveryZipCode = json['DeliveryZipCode'];
    DesireDeliveryDate = json['DesireDeliveryDate'];
    DeliveryUserNote = json['DeliveryUserNote'];
    AddressLabel = json['AddressLabel'];
    DeliveryZone = json['DeliveryZone'];
    DeliveryArea = json['DeliveryArea'];
    DefaultAddress = json['DefaultAddress'];
    homeAddress = json['homeAddress'];
    AllowStorePickup = json['AllowStorePickup'];
    ProcessStatus = json['ProcessStatus'];
    VendorPaymentStatus = json['VendorPaymentStatus'];
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
    _data['DefaultPayment'] = DefaultPayment;
    _data['total_amount'] = totalAmount;
    _data['currency'] = currency;
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
    _data['cus_country'] = cusCountry;
    _data['DeliveryZoneID'] = DeliveryZoneID;
    _data['DeliveryCountry'] = DeliveryCountry;
    _data['DeliveryAreaID'] = DeliveryAreaID;
    _data['DeliveryCityID'] = DeliveryCityID;
    _data['DeliveryZipCode'] = DeliveryZipCode;
    _data['DesireDeliveryDate'] = DesireDeliveryDate;
    _data['DeliveryUserNote'] = DeliveryUserNote;
    _data['AddressLabel'] = AddressLabel;
    _data['DeliveryZone'] = DeliveryZone;
    _data['DeliveryArea'] = DeliveryArea;
    _data['DefaultAddress'] = DefaultAddress;
    _data['homeAddress'] = homeAddress;
    _data['AllowStorePickup'] = AllowStorePickup;
    _data['ProcessStatus'] = ProcessStatus;
    _data['VendorPaymentStatus'] = VendorPaymentStatus;
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
    required this.ShippingByVendor,
    required this.ShippingByAdmin,
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

  ///
  late final String ShippingByVendor;
  late final String ShippingByAdmin;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    VendorStoreID = json['VendorStoreID'];
    ShippingByVendor = json['ShippingByVendor'];
    ShippingByAdmin = json['ShippingByAdmin'];
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
    _data['ShippingByVendor'] = ShippingByVendor;
    _data['ShippingByAdmin'] = ShippingByAdmin;
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

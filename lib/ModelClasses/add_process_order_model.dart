class AddProcessOrderModel {
  AddProcessOrderModel({
    required this.PaymentStatus,
    required this.ProcessPaymentID,
    required this.OrderNumber,
    required this.TrackingNumber,
    required this.ShippingLabel,
    required this.ShippingDate,
    required this.DeliveryDate,
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
  late final String? PaymentStatus;
  late final String? ProcessPaymentID;
  late final String? OrderNumber;
  late final String? TrackingNumber;
  late final String? ShippingLabel;
  late final String? ShippingDate;
  late final String? DeliveryDate;
  late final String? DeliveryConfirmationPic;
  late final String? AllowStorePickup;
  late final String? ProcessStatus;
  late final String? VendorPaymentStatus;
  late final String? Note;
  late final String? AllowAdminPickup;
  late final String? DeliveryStatus;
  late final String? PaymentType;
  late final List<ProductDetail> productDetail;

  AddProcessOrderModel.fromJson(Map<String, dynamic> json) {
    PaymentStatus = json['PaymentStatus'];
    ProcessPaymentID = json['ProcessPaymentID'];
    OrderNumber = json['OrderNumber'];
    TrackingNumber = json['TrackingNumber'];
    ShippingLabel = json['ShippingLabel'];
    ShippingDate = json['ShippingDate'];
    DeliveryDate = json['DeliveryDate'];
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
    _data['PaymentStatus'] = PaymentStatus;
    _data['ProcessPaymentID'] = ProcessPaymentID;
    _data['OrderNumber'] = OrderNumber;
    _data['TrackingNumber'] = TrackingNumber;
    _data['ShippingLabel'] = ShippingLabel;
    _data['ShippingDate'] = ShippingDate;
    _data['DeliveryDate'] = DeliveryDate;
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
    required this.ItemsPrice,
    required this.Quantity,
    required this.ItemsShippingHandling,
    required this.ItemsBeforeTax,
    required this.ItemsEstimatedTax,
    required this.ItemsTotal,
    required this.productVariantCombinationDetail,
  });
  late final String ProductID;
  late final String VendorStoreID;
  late final String ItemsPrice;
  late final String Quantity;
  late final String ItemsShippingHandling;
  late final String ItemsBeforeTax;
  late final String ItemsEstimatedTax;
  late final String ItemsTotal;
  late final List<ProductVariantCombinationDetail>
      productVariantCombinationDetail;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    VendorStoreID = json['VendorStoreID'];
    ItemsPrice = json['ItemsPrice'];
    Quantity = json['Quantity'];
    ItemsShippingHandling = json['ItemsShippingHandling'];
    ItemsBeforeTax = json['ItemsBeforeTax'];
    ItemsEstimatedTax = json['ItemsEstimatedTax'];
    ItemsTotal = json['ItemsTotal'];
    productVariantCombinationDetail =
        List.from(json['ProductVariantCombinationDetail'])
            .map((e) => ProductVariantCombinationDetail.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['VendorStoreID'] = VendorStoreID;
    _data['ItemsPrice'] = ItemsPrice;
    _data['Quantity'] = Quantity;
    _data['ItemsShippingHandling'] = ItemsShippingHandling;
    _data['ItemsBeforeTax'] = ItemsBeforeTax;
    _data['ItemsEstimatedTax'] = ItemsEstimatedTax;
    _data['ItemsTotal'] = ItemsTotal;
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

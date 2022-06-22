class GetDriverOrdersByStatusResponse {
  GetDriverOrdersByStatusResponse({
    required this.status,
    required this.totalRecords,
    required this.orderDetails,
  });
  late final bool status;
  late final int totalRecords;
  late final List<OrderDetails> orderDetails;

  GetDriverOrdersByStatusResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecords = json['total_records'];
    orderDetails = List.from(json['orderDetails'])
        .map((e) => OrderDetails.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['total_records'] = totalRecords;
    _data['orderDetails'] = orderDetails.map((e) => e.toJson()).toList();
    return _data;
  }
}

class OrderDetails {
  OrderDetails({
    required this.OrderNumber,
    required this.OrderDate,
    required this.PaymentStatus,
    this.TransactionID,
    required this.AllowStorePickup,
    required this.ReadyPickupForUser,
    required this.ReadyPickupForAdmin,
    required this.AllowAdminPickup,
    required this.DeliveryDriverID,
    this.ConsignmentId,
    required this.ProcessStatus,
    required this.productDetail,
  });
  late final String OrderNumber;
  String? OrderDate;
  late final String PaymentStatus;
  String? TransactionID;
  late final String AllowStorePickup;
  late final String ReadyPickupForUser;
  late final String ReadyPickupForAdmin;
  late final String AllowAdminPickup;
  late final int DeliveryDriverID;
  String? ConsignmentId;
  late final String ProcessStatus;
  late final List<ProductDetail> productDetail;

  double totalOrderPrice = 0.0;
  double totalOrderTax = 0.0;
  double totalOrderShippingPrice = 0.0;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    OrderNumber = json['OrderNumber'];
    OrderDate = json['OrderDate'];
    PaymentStatus = json['PaymentStatus'];
    TransactionID = json['TransactionID'] != null ? json['TransactionID'] : '';
    AllowStorePickup = json['AllowStorePickup'];
    ReadyPickupForUser = json['ReadyPickupForUser'];
    ReadyPickupForAdmin = json['ReadyPickupForAdmin'];
    AllowAdminPickup = json['AllowAdminPickup'];
    DeliveryDriverID = json['DeliveryDriverID'];
    ConsignmentId = json['ConsignmentId'] != null ? json['ConsignmentId'] : '';
    ProcessStatus = json['ProcessStatus'];
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
    _data['DeliveryDriverID'] = DeliveryDriverID;
    _data['ConsignmentId'] = ConsignmentId;
    _data['ProcessStatus'] = ProcessStatus;
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
    required this.Currency,
    required this.UserID,
    required this.Small,
    required this.Medium,
    required this.Large,
    required this.MainImage,
    this.ConsignmentId,
    required this.DeliveryDriverID,
    required this.ProcessStatus,
    required this.REVIEWCOUNT,
    this.AVGRating,
    required this.productCombinations,
    required this.ItemsPrice,
    required this.ItemsEstimatedTax,
    required this.ItemsShippingHandling,
  });
  late final int ProductID;
  late final String Title;
  String? TransactionID;
  late final String OrderNumber;
  late final String AllowStorePickup;
  late final String AllowAdminPickup;
  late final String ReadyPickupForUser;
  late final String ReadyPickupForAdmin;
  late final String OrderDate;
  late final String PaymentStatus;
  late final String BasePrice;
  late final String Currency;
  late final int UserID;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final String MainImage;
  String? ConsignmentId;
  late final int DeliveryDriverID;
  late final String ProcessStatus;
  late final int REVIEWCOUNT;
  String? AVGRating;
  double totalProductPrice = 0.0;
  late final String ItemsPrice;
  late final String ItemsEstimatedTax;
  late final String ItemsShippingHandling;
  late final String PaymentType;

  late final List<ProductCombinations> productCombinations;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Title = json['Title'];
    TransactionID = json['TransactionID'] != null ? json['TransactionID'] : '';
    OrderNumber = json['OrderNumber'];
    AllowStorePickup = json['AllowStorePickup'];
    AllowAdminPickup = json['AllowAdminPickup'];
    ReadyPickupForUser = json['ReadyPickupForUser'];
    ReadyPickupForAdmin = json['ReadyPickupForAdmin'];
    OrderDate = json['OrderDate'];
    PaymentStatus = json['PaymentStatus'];
    PaymentType = json['PaymentType'];
    BasePrice = json['BasePrice'];
    Currency = json['Currency'];
    UserID = json['UserID'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    MainImage = json['MainImage'];
    ConsignmentId = json['ConsignmentId'] != null ? json['ConsignmentId'] : '';
    DeliveryDriverID = json['DeliveryDriverID'];
    ProcessStatus = json['ProcessStatus'];
    REVIEWCOUNT = json['REVIEW_COUNT'];
    ItemsPrice = json['ItemsPrice'];
    ItemsEstimatedTax = json['ItemsEstimatedTax'];
    ItemsShippingHandling = json['ItemsShippingHandling'];
    AVGRating = json['AVG_Rating'] != null ? json['AVG_Rating'] : '';
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
    _data['PaymentType'] = PaymentType;
    _data['PaymentStatus'] = PaymentStatus;
    _data['BasePrice'] = BasePrice;
    _data['Currency'] = Currency;
    _data['UserID'] = UserID;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['MainImage'] = MainImage;
    _data['ConsignmentId'] = ConsignmentId;
    _data['DeliveryDriverID'] = DeliveryDriverID;
    _data['ProcessStatus'] = ProcessStatus;
    _data['REVIEW_COUNT'] = REVIEWCOUNT;
    _data['AVG_Rating'] = AVGRating;
    _data['ItemsPrice'] = ItemsPrice;
    _data['ItemsEstimatedTax'] = ItemsEstimatedTax;
    _data['ItemsShippingHandling'] = ItemsShippingHandling;
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
    ProductID = json['ProductID'];
    ProductVariantCombinationID = json['ProductVariantCombinationID'];
    VendorStoreID = json['VendorStoreID'];
    ProductCombinationPrice = json['ProductCombinationPrice'];
    AvailableInventory = json['AvailableInventory'];
    OptionID = json['OptionID'];
    OptionName = json['OptionName'];
    OptionValue = json['OptionValue'];
    OptionValueID = json['OptionValueID'];
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

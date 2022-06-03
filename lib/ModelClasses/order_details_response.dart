class OrderDetailsResponse {
  OrderDetailsResponse({
    required this.status,
    required this.totalRecords,
    required this.orderDetails,
  });
  late final bool status;
  late final int totalRecords;
  late final List<OrderDetails> orderDetails;

  OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
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
    required this.TransactionID,
    required this.ProcessStatus,
    required this.OrderTotal,
    required this.productDetail,
  });
  late final String OrderNumber;
  late String OrderDate;
  late final String PaymentStatus;
  late final List<ProductDetail> productDetail;
  late final String TransactionID;
  late final String ProcessStatus;
  late final String OrderTotal;

  bool openOrderDetailsDropDown = false;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    OrderNumber = json['OrderNumber'];
    OrderDate = json['OrderDate'];
    PaymentStatus = json['PaymentStatus'];
    ProcessStatus = json['ProcessStatus'];
    OrderTotal = json['OrderTotal'];
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
    _data['ProcessStatus'] = ProcessStatus;
    _data['OrderTotal'] = OrderTotal;
    _data['ProductDetail'] = productDetail.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductDetail {
  ProductDetail({
    required this.ProductID,
    required this.Title,
    required this.OrderNumber,
    required this.OrderDate,
    required this.PaymentStatus,
    required this.BasePrice,
    required this.Currency,
    required this.UserID,
    required this.Small,
    required this.Medium,
    required this.Large,
    required this.MainImage,
    required this.REVIEWCOUNT,
    this.AVGRating,
    required this.productCombinations,
    required this.TransactionID,
    required this.ProcessStatus,
    required this.OrderTotal,
  });
  late final int ProductID;
  late final String Title;
  late final String OrderNumber;
  late final String OrderDate;
  late final String PaymentStatus;
  late final String BasePrice;
  late final String Currency;
  late final int UserID;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final String MainImage;
  late final int REVIEWCOUNT;
  String? AVGRating;
  double totalProductPrice = 0.0;
  late final List<ProductCombinations> productCombinations;

  ///
  late final String TransactionID;
  late final String ProcessStatus;
  late final String OrderTotal;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Title = json['Title'];
    OrderNumber = json['OrderNumber'];
    OrderDate = json['OrderDate'];
    PaymentStatus = json['PaymentStatus'];
    BasePrice = json['BasePrice'];
    Currency = json['Currency'];
    UserID = json['UserID'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    MainImage = json['MainImage'];
    REVIEWCOUNT = json['REVIEW_COUNT'];
    AVGRating = json['AVG_Rating'] != null ? json['AVG_Rating'] : '0.0';
    productCombinations = List.from(json['ProductCombinations'])
        .map((e) => ProductCombinations.fromJson(e))
        .toList();

    TransactionID = json['TransactionID'];
    ProcessStatus = json['ProcessStatus'];
    OrderTotal = json['OrderTotal'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['Title'] = Title;
    _data['OrderNumber'] = OrderNumber;
    _data['OrderDate'] = OrderDate;
    _data['PaymentStatus'] = PaymentStatus;
    _data['BasePrice'] = BasePrice;
    _data['Currency'] = Currency;
    _data['UserID'] = UserID;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['MainImage'] = MainImage;
    _data['REVIEW_COUNT'] = REVIEWCOUNT;
    _data['AVG_Rating'] = AVGRating;
    _data['ProductCombinations'] =
        productCombinations.map((e) => e.toJson()).toList();

    _data['TransactionID'] = TransactionID;
    _data['ProcessStatus'] = ProcessStatus;
    _data['OrderTotal'] = OrderTotal;
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
    required this.Currency,
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

  ///
  late final String Currency;

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
    Currency = json['Currency'];
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
    _data['Currency'] = Currency;
    return _data;
  }
}

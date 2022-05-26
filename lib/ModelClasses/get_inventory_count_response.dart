class GetInventoryCountResponse {
  GetInventoryCountResponse({
    required this.status,
    required this.outOfStockProducts,
  });
  late final bool status;
  late final List<OutOfStockProducts> outOfStockProducts;

  GetInventoryCountResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    outOfStockProducts = List.from(json['outOfStockProducts'])
        .map((e) => OutOfStockProducts.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['outOfStockProducts'] =
        outOfStockProducts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class OutOfStockProducts {
  OutOfStockProducts({
    required this.productDetail,
  });
  late final List<ProductDetail> productDetail;

  OutOfStockProducts.fromJson(Map<String, dynamic> json) {
    productDetail = List.from(json['ProductDetail'])
        .map((e) => ProductDetail.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductDetail'] = productDetail.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductDetail {
  ProductDetail({
    required this.ProductID,
    required this.Title,
    required this.OptionValue,
    required this.OptionValueID,
    required this.ProductInventoryID,
    required this.VendorStoreID,
    required this.ProductVariantCombinationID,
    required this.Inventory,
    required this.UnitPrice,
    required this.TotalPrice,
    required this.Status,
  });
  late final int ProductID;
  late final String Title;
  late final String OptionValue;
  late final int OptionValueID;
  late final int ProductInventoryID;
  late final int VendorStoreID;
  late final int ProductVariantCombinationID;
  late final int Inventory;
  late final String UnitPrice;
  late final String TotalPrice;
  late final String Status;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Title = json['Title'];
    OptionValue = json['OptionValue'];
    OptionValueID = json['OptionValueID'];
    ProductInventoryID = json['ProductInventoryID'];
    VendorStoreID = json['VendorStoreID'];
    ProductVariantCombinationID = json['ProductVariantCombinationID'];
    Inventory = json['Inventory'];
    UnitPrice = json['UnitPrice'];
    TotalPrice = json['TotalPrice'];
    Status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['Title'] = Title;
    _data['OptionValue'] = OptionValue;
    _data['OptionValueID'] = OptionValueID;
    _data['ProductInventoryID'] = ProductInventoryID;
    _data['VendorStoreID'] = VendorStoreID;
    _data['ProductVariantCombinationID'] = ProductVariantCombinationID;
    _data['Inventory'] = Inventory;
    _data['UnitPrice'] = UnitPrice;
    _data['TotalPrice'] = TotalPrice;
    _data['Status'] = Status;
    return _data;
  }
}

class UserRefundFormModel {
  UserRefundFormModel({
    required this.OrderNumber,
    required this.RefundResaon,
    required this.product,
  });
  late final String OrderNumber;
  String? RefundResaon;
  late final List<Product> product;

  UserRefundFormModel.fromJson(Map<String, dynamic> json) {
    OrderNumber = json['OrderNumber'];
    RefundResaon = json['RefundResaon'];
    product =
        List.from(json['Product']).map((e) => Product.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['OrderNumber'] = OrderNumber;
    _data['RefundResaon'] = RefundResaon;
    _data['Product'] = product.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Product {
  Product({
    required this.ProductID,
    required this.productCombinations,
  });
  late final String ProductID;
  late final List<ProductCombinationsReturn> productCombinations;

  Product.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    productCombinations = List.from(json['ProductCombinations'])
        .map((e) => ProductCombinationsReturn.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['ProductCombinations'] =
        productCombinations.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductCombinationsReturn {
  ProductCombinationsReturn({
    required this.ProductVariantCombinationID,
  });
  late final String ProductVariantCombinationID;

  ProductCombinationsReturn.fromJson(Map<String, dynamic> json) {
    ProductVariantCombinationID = json['ProductVariantCombinationID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductVariantCombinationID'] = ProductVariantCombinationID;
    return _data;
  }
}

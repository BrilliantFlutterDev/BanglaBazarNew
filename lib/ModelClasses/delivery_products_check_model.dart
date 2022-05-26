class DeliveryProductsCheckModel {
  DeliveryProductsCheckModel({
    required this.productDetail,
  });
  late final List<ProductDetail> productDetail;

  DeliveryProductsCheckModel.fromJson(Map<String, dynamic> json) {
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
  });
  late final String ProductID;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    return _data;
  }
}

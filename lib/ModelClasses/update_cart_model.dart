class UpdateCartModel {
  UpdateCartModel({
    required this.productDetail,
  });
  late final List<ProductDetail> productDetail;

  UpdateCartModel.fromJson(Map<String, dynamic> json) {
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
    required this.Quantity,
    required this.productVariantCombinationDetail,
  });
  String? ProductID;
  String? Quantity;
  List<ProductVariantCombinationDetail>? productVariantCombinationDetail;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Quantity = json['Quantity'];
    productVariantCombinationDetail =
        List.from(json['ProductVariantCombinationDetail'])
            .map((e) => ProductVariantCombinationDetail.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['Quantity'] = Quantity;
    _data['ProductVariantCombinationDetail'] =
        productVariantCombinationDetail!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductVariantCombinationDetail {
  ProductVariantCombinationDetail({
    required this.ProductVariantCombinationID,
  });
  String? ProductVariantCombinationID;

  ProductVariantCombinationDetail.fromJson(Map<String, dynamic> json) {
    ProductVariantCombinationID = json['ProductVariantCombinationID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductVariantCombinationID'] = ProductVariantCombinationID;
    return _data;
  }
}

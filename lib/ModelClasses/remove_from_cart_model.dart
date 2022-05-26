class RemoveFromCartModel {
  RemoveFromCartModel({
    this.productVariantCombinationDetail,
  });
  List<ProductVariantCombinationDetail>? productVariantCombinationDetail;

  RemoveFromCartModel.fromJson(Map<String, dynamic> json) {
    productVariantCombinationDetail =
        List.from(json['ProductVariantCombinationDetail'])
            .map((e) => ProductVariantCombinationDetail.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductVariantCombinationDetail'] =
        productVariantCombinationDetail!.map((e) => e.toJson()).toList();
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

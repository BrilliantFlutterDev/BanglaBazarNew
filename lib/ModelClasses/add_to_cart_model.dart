class AddToCartModel {
  String? sessionID;
  List<ProductDetail>? productDetail;

  AddToCartModel({this.sessionID, this.productDetail});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    sessionID = json['SessionID'];
    if (json['ProductDetail'] != null) {
      productDetail = <ProductDetail>[];
      json['ProductDetail'].forEach((v) {
        productDetail!.add(ProductDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SessionID'] = this.sessionID;
    if (productDetail != null) {
      data['ProductDetail'] = productDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetail {
  int? productID;
  int? quantity;
  List<ProductVariantCombinationDetail>? productVariantCombinationDetail;

  ProductDetail(
      {this.productID, this.quantity, this.productVariantCombinationDetail});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    productID = json['ProductID'];
    quantity = json['Quantity'];
    if (json['ProductVariantCombinationDetail'] != null) {
      productVariantCombinationDetail = <ProductVariantCombinationDetail>[];
      json['ProductVariantCombinationDetail'].forEach((v) {
        productVariantCombinationDetail!
            .add(ProductVariantCombinationDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductID'] = productID;
    data['Quantity'] = quantity;
    if (productVariantCombinationDetail != null) {
      data['ProductVariantCombinationDetail'] =
          productVariantCombinationDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductVariantCombinationDetail {
  late int productVariantCombinationID;

  ProductVariantCombinationDetail({required this.productVariantCombinationID});

  ProductVariantCombinationDetail.fromJson(Map<String, dynamic> json) {
    productVariantCombinationID = json['ProductVariantCombinationID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductVariantCombinationID'] = productVariantCombinationID;
    return data;
  }
}

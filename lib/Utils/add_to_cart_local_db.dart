class RequestUserCartProducts {
  List<ProductCartList>? cartProducts;

  RequestUserCartProducts({required this.cartProducts});

  RequestUserCartProducts.fromJson(List<Map<String, dynamic>> json) {
    cartProducts = <ProductCartList>[];
    for (var v in json) {
      cartProducts!.add(ProductCartList.fromJson(v));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartProducts != null) {
      data['CartProducts'] = cartProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCartList {
  ProductCartList(
      {required this.ProductID,
      required this.Title,
      required this.CompanyName,
      required this.VendorID,
      required this.City,
      required this.Native,
      required this.BasePrice,
      required this.Currency,
      required this.UserID,
      required this.TotalQuantity,
      required this.Small,
      required this.Medium,
      required this.Large,
      required this.MainImage,
      required this.REVIEWCOUNT,
      required this.AllowStorePickup,
      //this.AVGRating,
      required this.ProductCityID,
      required this.ProductCountry,
      required this.uniqueNumber});
  late final int ProductID;
  late final String Title;
  late final int ProductCityID;
  late final int ProductCountry;
  late final String City;
  late final String Native;
  late final String CompanyName;
  late final int VendorID;
  late final String BasePrice;
  late final String Currency;
  late final int UserID;
  String? TotalQuantity;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final String MainImage;
  late final int REVIEWCOUNT;
  late final String AllowStorePickup;
  //late final String? AVGRating;
  String? uniqueNumber;

  ProductCartList.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Title = json['Title'];
    City = json['City'];
    Native = json['Native'];
    ProductCityID = json['ProductCityID'];
    ProductCountry = json['ProductCountry'];
    CompanyName = json['CompanyName'];
    VendorID = json['VendorID'];
    BasePrice = json['BasePrice'];
    Currency = json['Currency'];
    UserID = json['UserID'];
    TotalQuantity = json['Total_Quantity'].toString();
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    MainImage = json['MainImage'];
    AllowStorePickup = json['AllowStorePickup'];
    REVIEWCOUNT = json['REVIEW_COUNT'];
    //AVGRating = json['AVG_Rating'] != null ? json['AVG_Rating'] : '';
    uniqueNumber = json['UniqueNumber'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['Title'] = Title;
    _data['City'] = City;
    _data['Native'] = Native;
    _data['ProductCityID'] = ProductCityID;
    _data['ProductCountry'] = ProductCountry;
    _data['CompanyName'] = CompanyName;
    _data['VendorID'] = VendorID;
    _data['BasePrice'] = BasePrice;
    _data['Currency'] = Currency;
    _data['UserID'] = UserID;
    _data['Total_Quantity'] = TotalQuantity;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['MainImage'] = MainImage;
    _data['REVIEW_COUNT'] = REVIEWCOUNT;
    //_data['AVG_Rating'] = AVGRating;
    _data['AllowStorePickup'] = AllowStorePickup;
    _data['UniqueNumber'] = uniqueNumber;

    return _data;
  }
}

class RequestUserCartProductsCombinations {
  List<ProductCombinations>? cartProductsCombinations;

  RequestUserCartProductsCombinations({required this.cartProductsCombinations});

  RequestUserCartProductsCombinations.fromJson(
      List<Map<String, dynamic>> json) {
    cartProductsCombinations = <ProductCombinations>[];
    for (var v in json) {
      cartProductsCombinations!.add(ProductCombinations.fromJson(v));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartProductsCombinations != null) {
      data['CartProducts'] =
          cartProductsCombinations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCombinations {
  ProductCombinations(
      {required this.ProductID,
      required this.ProductVariantCombinationID,
      required this.uniqueNumber});
  late final int ProductID;
  late final int ProductVariantCombinationID;

  String? uniqueNumber;

  ProductCombinations.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    ProductVariantCombinationID = json['ProductVariantCombinationID'];

    uniqueNumber = json['UniqueNumber'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['ProductVariantCombinationID'] = ProductVariantCombinationID;
    _data['UniqueNumber'] = uniqueNumber;
    return _data;
  }
}

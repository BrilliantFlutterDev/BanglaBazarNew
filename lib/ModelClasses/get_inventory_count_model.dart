class CartDetailsResponse {
  CartDetailsResponse({
    required this.status,
    required this.productCartList,
  });
  late final bool status;
  double cartTotalPrice = 0.0;
  late final List<ProductCartList> productCartList;

  CartDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    productCartList = List.from(json['productCartList'])
        .map((e) => ProductCartList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['productCartList'] = productCartList.map((e) => e.toJson()).toList();
    return _data;
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
      this.AVGRating,
      required this.productCombinations,
      required this.ProductCityID,
      this.calculateTotalProductPrice,
      required this.ProductCountry,
      this.VendorStoreZip,
      required this.Weight,
      required this.Height,
      required this.Length,
      required this.Width,
      this.uniqueNumber});
  late final int ProductID;
  late final String Title;
  late final int ProductCityID;
  late int ProductCountry;
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
  late final String? AVGRating;
  late final String Weight;
  late final String Height;
  late final String Length;
  late final String Width;
  late final String? VendorStoreZip;

  late final List<ProductCombinations> productCombinations;

  /// My custom variables
  double? calculateTotalProductPrice = 0.0;
  bool selectedForCheckout = false;
  String? uniqueNumber;

  ProductCartList.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Title = json['Title'];
    City = json['City'] ?? '';
    Native = json['Native'] ?? '';
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
    AVGRating = json['AVG_Rating'] != null ? json['AVG_Rating'] : '';
    Weight = json['Weight'] ?? '1';
    Height = json['Height'] ?? '1';
    Length = json['Length'] ?? '1';
    Width = json['Width'] ?? '1';
    VendorStoreZip = json['VendorStoreZip'] ?? '';
    productCombinations = List.from(json['ProductCombinations'])
        .map((e) => ProductCombinations.fromJson(e))
        .toList();
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
    _data['AVG_Rating'] = AVGRating;
    _data['AllowStorePickup'] = AllowStorePickup;
    _data['Weight'] = Weight;
    _data['Height'] = Height;
    _data['Length'] = Length;
    _data['Width'] = Width;
    _data['VendorStoreZip'] = VendorStoreZip;
    _data['ProductCombinations'] =
        productCombinations.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductCombinations {
  ProductCombinations(
      {required this.ProductID,
      required this.ProductVariantCombinationID,
      required this.ProductCombinationPrice,
      required this.AvailableInventory,
      required this.OptionID,
      required this.VendorStoreID,
      required this.OptionName,
      required this.OptionValue,
      required this.OptionValueID,
      this.uniqueNumber});
  late final int ProductID;
  late final int ProductVariantCombinationID;
  late final String ProductCombinationPrice;
  late final int AvailableInventory;
  late final int VendorStoreID;
  late final int OptionID;
  late final String OptionName;
  late final String OptionValue;
  late final int OptionValueID;

  ///
  String? uniqueNumber;

  ProductCombinations.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    ProductVariantCombinationID = json['ProductVariantCombinationID'];
    ProductCombinationPrice = json['ProductCombinationPrice'];
    AvailableInventory = json['AvailableInventory'];
    VendorStoreID = json['VendorStoreID'];
    OptionID = json['OptionID'];
    OptionName = json['OptionName'];
    OptionValue = json['OptionValue'];
    OptionValueID = json['OptionValueID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['ProductVariantCombinationID'] = ProductVariantCombinationID;
    _data['ProductCombinationPrice'] = ProductCombinationPrice;
    _data['AvailableInventory'] = AvailableInventory;
    _data['VendorStoreID'] = VendorStoreID;
    _data['OptionID'] = OptionID;
    _data['OptionName'] = OptionName;
    _data['OptionValue'] = OptionValue;
    _data['OptionValueID'] = OptionValueID;
    return _data;
  }
}

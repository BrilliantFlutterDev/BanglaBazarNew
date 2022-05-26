class CartDetailsResponse {
  CartDetailsResponse({
    required this.status,
    required this.productCartList,
  });
  late final bool status;
  late final List<ProductCartList> productCartList;

  ///My custom variables
  double cartTotalPrice = 0.0;
  double totalTax = 0.0;

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
      {this.ProductID,
      this.VendorID,
      this.SubCategoryID,
      this.Title,
      this.StoreName,
      this.Description,
      this.SpecialInstruction,
      this.ReturnPolicy,
      this.Currency,
      this.CostPrice,
      this.Price,
      this.Quantity1,
      this.PriceQuantity1,
      this.Quantity2,
      this.PriceQuantity2,
      this.Quantity3,
      this.PriceQuantity3,
      this.PromotionPrice,
      this.PromotionRate,
      this.PromotionStartDate,
      this.PromotionEndDate,
      this.Weight,
      this.Height,
      this.Length,
      this.Width,
      this.AllowStorePickup,
      this.ShippingAvailable,
      this.ShippingGlobal,
      this.ShippingByAdmin,
      this.ShippingByVendor,
      this.ShippingCostAdmin,
      this.ShippingCostVendor,
      this.ReviewedByAdmin,
      this.TaxVATApply,
      this.LockEdit,
      this.Active,
      this.LastUpdate,
      this.AdminNote,
      this.City,
      this.Native,
      this.ProductCityID,
      this.ProductCountry,
      this.CompanyName,
      this.UserID,
      this.Small,
      this.Medium,
      this.Large,
      this.MainImage,
      this.TotalQuantity,
      this.VendorStoreZip,
      this.StoreCity,
      this.StoreCountry,
      this.StoreState,
      this.REVIEWCOUNT,
      this.AVGRating,
      this.TaxRate,
      required this.productCombinations,
      this.uniqueNumber,
      this.calculateTotalProductPrice});
  late final int? ProductID;
  late final int? VendorID;
  late final int? SubCategoryID;
  late final String? Title;
  late final String? StoreName;
  late final String? Description;
  late final String? SpecialInstruction;
  late final String? ReturnPolicy;
  late final String? Currency;
  late final String? CostPrice;
  late final String? Price;
  late final int? Quantity1;
  late final String? PriceQuantity1;
  late final int? Quantity2;
  late final String? PriceQuantity2;
  late final int? Quantity3;
  late final String? PriceQuantity3;
  late final String? PromotionPrice;
  late final String? PromotionRate;
  late final String? PromotionStartDate;
  late final String? PromotionEndDate;
  late final String? Weight;
  late final String? Height;
  late final String? Length;
  late final String? Width;
  late final String? AllowStorePickup;
  late final String? ShippingAvailable;
  late final String? ShippingGlobal;
  late final String? ShippingByAdmin;
  late final String? ShippingByVendor;
  late final String? ShippingCostAdmin;
  late final String? ShippingCostVendor;
  late final String? ReviewedByAdmin;
  late final String? TaxVATApply;
  late final String? LockEdit;
  late final String? Active;
  late final String? LastUpdate;
  late final String? AdminNote;
  late final String? City;
  late final String? Native;
  late final int? ProductCityID;
  late final int? ProductCountry;
  late final String? CompanyName;
  late final int? UserID;
  late final String? Small;
  late final String? Medium;
  late final String? Large;
  late final String? MainImage;
  int? TotalQuantity = 0;
  late final String? VendorStoreZip;
  late final String? StoreCity;
  late final int? StoreCountry;
  late final String? StoreState;
  late final int? REVIEWCOUNT;
  late final String? AVGRating;
  late final String? TaxRate;
  late final List<ProductCombinations> productCombinations;

  /// My custom variables
  double? calculateTotalProductPrice = 0.0;
  bool selectedForCheckout = false;
  String? uniqueNumber;
  double? perProductTax = 0.0;

  ProductCartList.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    VendorID = json['VendorID'];
    SubCategoryID = json['SubCategoryID'];
    Title = json['Title'];
    StoreName = json['StoreName'];
    Description = json['Description'];
    SpecialInstruction = json['SpecialInstruction'];
    ReturnPolicy = json['ReturnPolicy'];
    Currency = json['Currency'];
    CostPrice = json['CostPrice'];
    Price = json['Price'];
    Quantity1 = json['Quantity1'];
    PriceQuantity1 = json['PriceQuantity1'];
    Quantity2 = json['Quantity2'];
    PriceQuantity2 = json['PriceQuantity2'];
    Quantity3 = json['Quantity3'];
    PriceQuantity3 = json['PriceQuantity3'];
    PromotionPrice = json['PromotionPrice'];
    PromotionRate = json['PromotionRate'];
    PromotionStartDate = json['PromotionStartDate'];
    PromotionEndDate = json['PromotionEndDate'];

    ///

    Weight = json['Weight'] ?? '1';
    Height = json['Height'] ?? '1';
    Length = json['Length'] ?? '1';
    Width = json['Width'] ?? '1';

    ///
    AllowStorePickup = json['AllowStorePickup'];
    ShippingAvailable = json['ShippingAvailable'];
    ShippingGlobal = json['ShippingGlobal'];
    ShippingByAdmin = json['ShippingByAdmin'];
    ShippingByVendor = json['ShippingByVendor'];
    ShippingCostAdmin = json['ShippingCostAdmin'];
    ShippingCostVendor = json['ShippingCostVendor'];
    ReviewedByAdmin = json['ReviewedByAdmin'];
    TaxVATApply = json['TaxVATApply'];
    LockEdit = json['LockEdit'];
    Active = json['Active'];
    LastUpdate = json['LastUpdate'] ?? '';
    AdminNote = json['AdminNote'] ?? '';
    City = json['City'] ?? '';
    Native = json['Native'] ?? '';
    ProductCityID = json['ProductCityID'];
    ProductCountry = json['ProductCountry'];
    CompanyName = json['CompanyName'];
    UserID = json['UserID'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    MainImage = json['MainImage'];
    TotalQuantity = json['Total_Quantity'];
    VendorStoreZip = json['VendorStoreZip'] ?? '';
    StoreCity = json['StoreCity'];
    StoreCountry = json['StoreCountry'];
    StoreState = json['StoreState'];
    REVIEWCOUNT = json['REVIEW_COUNT'];
    AVGRating = json['AVG_Rating'] ?? '';
    TaxRate = json['TaxRate'] ?? '0.0';
    productCombinations = List.from(json['ProductCombinations'])
        .map((e) => ProductCombinations.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['VendorID'] = VendorID;
    _data['SubCategoryID'] = SubCategoryID;
    _data['Title'] = Title;
    _data['StoreName'] = StoreName;
    _data['Description'] = Description;
    _data['SpecialInstruction'] = SpecialInstruction;
    _data['ReturnPolicy'] = ReturnPolicy;
    _data['Currency'] = Currency;
    _data['CostPrice'] = CostPrice;
    _data['Price'] = Price;
    _data['Quantity1'] = Quantity1;
    _data['PriceQuantity1'] = PriceQuantity1;
    _data['Quantity2'] = Quantity2;
    _data['PriceQuantity2'] = PriceQuantity2;
    _data['Quantity3'] = Quantity3;
    _data['PriceQuantity3'] = PriceQuantity3;
    _data['PromotionPrice'] = PromotionPrice;
    _data['PromotionRate'] = PromotionRate;
    _data['PromotionStartDate'] = PromotionStartDate;
    _data['PromotionEndDate'] = PromotionEndDate;
    _data['Weight'] = Weight;
    _data['Height'] = Height;
    _data['Length'] = Length;
    _data['Width'] = Width;
    _data['AllowStorePickup'] = AllowStorePickup;
    _data['ShippingAvailable'] = ShippingAvailable;
    _data['ShippingGlobal'] = ShippingGlobal;
    _data['ShippingByAdmin'] = ShippingByAdmin;
    _data['ShippingByVendor'] = ShippingByVendor;
    _data['ShippingCostAdmin'] = ShippingCostAdmin;
    _data['ShippingCostVendor'] = ShippingCostVendor;
    _data['ReviewedByAdmin'] = ReviewedByAdmin;
    _data['TaxVATApply'] = TaxVATApply;
    _data['LockEdit'] = LockEdit;
    _data['Active'] = Active;
    _data['LastUpdate'] = LastUpdate;
    _data['AdminNote'] = AdminNote;
    _data['City'] = City;
    _data['Native'] = Native;
    _data['ProductCityID'] = ProductCityID;
    _data['ProductCountry'] = ProductCountry;
    _data['CompanyName'] = CompanyName;
    _data['UserID'] = UserID;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['MainImage'] = MainImage;
    _data['Total_Quantity'] = TotalQuantity;
    _data['VendorStoreZip'] = VendorStoreZip;
    _data['StoreCity'] = StoreCity;
    _data['StoreCountry'] = StoreCountry;
    _data['StoreState'] = StoreState;
    _data['REVIEW_COUNT'] = REVIEWCOUNT;
    _data['AVG_Rating'] = AVGRating;
    _data['TaxRate'] = TaxRate;
    _data['ProductCombinations'] =
        productCombinations.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductCombinations {
  ProductCombinations(
      {required this.ProductID,
      required this.ProductVariantCombinationID,
      required this.VendorStoreID,
      required this.ProductCombinationPrice,
      required this.AvailableInventory,
      required this.OptionID,
      required this.OptionName,
      required this.OptionValue,
      required this.OptionValueID,
      this.uniqueNumber});
  late final int ProductID;
  late final int ProductVariantCombinationID;
  late final int VendorStoreID;
  late final String ProductCombinationPrice;
  late final int AvailableInventory;
  late final int OptionID;
  late final String OptionName;
  late final String OptionValue;
  late final int OptionValueID;

  String? uniqueNumber;

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

class CartDetailsResponse2 {
  CartDetailsResponse2({
    required this.status,
    required this.productCartList,
  });
  late final bool status;
  double cartTotalPrice = 0.0;
  late final List<ProductCartList2> productCartList;

  CartDetailsResponse2.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    productCartList = List.from(json['productCartList'])
        .map((e) => ProductCartList2.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['productCartList'] = productCartList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductCartList2 {
  ProductCartList2({
    required this.ProductID,
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
    this.uniqueNumber,
    this.SubCategoryID,
    this.StoreName,
    this.Description,
    this.SpecialInstruction,
    this.ReturnPolicy,
    this.CostPrice,
    this.Price,
    this.Quantity1,
    this.PriceQuantity1,
    this.Quantity2,
    this.PriceQuantity2,
    this.Quantity3,
    this.PriceQuantity3,
    this.PromotionPrice,
    this.PromotionRate,
    this.PromotionStartDate,
    this.PromotionEndDate,
    this.ShippingAvailable,
    this.ShippingGlobal,
    this.ShippingByAdmin,
    this.ShippingByVendor,
    this.ShippingCostAdmin,
    this.ShippingCostVendor,
    this.ReviewedByAdmin,
    this.TaxVATApply,
    this.LockEdit,
    this.Active,
    this.LastUpdate,
    this.AdminNote,
    this.StoreCity,
    this.StoreCountry,
    this.StoreState,
    this.TaxRate,
  });
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

  ///

  late final int? SubCategoryID;
  late final String? StoreName;
  late final String? Description;
  late final String? SpecialInstruction;
  late final String? ReturnPolicy;
  late final String? CostPrice;
  late final String? Price;
  late final int? Quantity1;
  late final String? PriceQuantity1;
  late final int? Quantity2;
  late final String? PriceQuantity2;
  late final int? Quantity3;
  late final String? PriceQuantity3;
  late final String? PromotionPrice;
  late final String? PromotionRate;
  late final String? PromotionStartDate;
  late final String? PromotionEndDate;
  late final String? ShippingAvailable;
  late final String? ShippingGlobal;
  late final String? ShippingByAdmin;
  late final String? ShippingByVendor;
  late final String? ShippingCostAdmin;
  late final String? ShippingCostVendor;
  late final String? ReviewedByAdmin;
  late final String? TaxVATApply;
  late final String? LockEdit;
  late final String? Active;
  late final String? LastUpdate;
  late final String? AdminNote;

  late final String? StoreCity;
  late final int? StoreCountry;
  late final String? StoreState;
  late final String? TaxRate;

  ///

  late final List<ProductCombinations2> productCombinations;

  /// My custom variables
  double? calculateTotalProductPrice = 0.0;
  bool selectedForCheckout = false;
  String? uniqueNumber;

  ProductCartList2.fromJson(Map<String, dynamic> json) {
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

    ///

    SubCategoryID = json['SubCategoryID'];

    StoreName = json['StoreName'];
    Description = json['Description'];
    SpecialInstruction = json['SpecialInstruction'];
    ReturnPolicy = json['ReturnPolicy'];

    CostPrice = json['CostPrice'];
    Price = json['Price'];
    Quantity1 = json['Quantity1'];
    PriceQuantity1 = json['PriceQuantity1'];
    Quantity2 = json['Quantity2'];
    PriceQuantity2 = json['PriceQuantity2'];
    Quantity3 = json['Quantity3'];
    PriceQuantity3 = json['PriceQuantity3'];
    PromotionPrice = json['PromotionPrice'];
    PromotionRate = json['PromotionRate'];
    PromotionStartDate = json['PromotionStartDate'];
    PromotionEndDate = json['PromotionEndDate'];

    ShippingAvailable = json['ShippingAvailable'];
    ShippingGlobal = json['ShippingGlobal'];
    ShippingByAdmin = json['ShippingByAdmin'];
    ShippingByVendor = json['ShippingByVendor'];
    ShippingCostAdmin = json['ShippingCostAdmin'];
    ShippingCostVendor = json['ShippingCostVendor'];
    ReviewedByAdmin = json['ReviewedByAdmin'];
    TaxVATApply = json['TaxVATApply'];
    LockEdit = json['LockEdit'];
    Active = json['Active'];
    LastUpdate = json['LastUpdate'] ?? '';
    AdminNote = json['AdminNote'] ?? '';

    StoreCity = json['StoreCity'];
    StoreCountry = json['StoreCountry'];
    StoreState = json['StoreState'];

    TaxRate = json['TaxRate'] ?? '0';

    ///
    productCombinations = List.from(json['ProductCombinations'])
        .map((e) => ProductCombinations2.fromJson(e))
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

    ///
    _data['SubCategoryID'] = SubCategoryID;

    _data['StoreName'] = StoreName;
    _data['Description'] = Description;
    _data['SpecialInstruction'] = SpecialInstruction;
    _data['ReturnPolicy'] = ReturnPolicy;

    _data['CostPrice'] = CostPrice;
    _data['Price'] = Price;
    _data['Quantity1'] = Quantity1;
    _data['PriceQuantity1'] = PriceQuantity1;
    _data['Quantity2'] = Quantity2;
    _data['PriceQuantity2'] = PriceQuantity2;
    _data['Quantity3'] = Quantity3;
    _data['PriceQuantity3'] = PriceQuantity3;
    _data['PromotionPrice'] = PromotionPrice;
    _data['PromotionRate'] = PromotionRate;
    _data['PromotionStartDate'] = PromotionStartDate;
    _data['PromotionEndDate'] = PromotionEndDate;

    _data['ShippingAvailable'] = ShippingAvailable;
    _data['ShippingGlobal'] = ShippingGlobal;
    _data['ShippingByAdmin'] = ShippingByAdmin;
    _data['ShippingByVendor'] = ShippingByVendor;
    _data['ShippingCostAdmin'] = ShippingCostAdmin;
    _data['ShippingCostVendor'] = ShippingCostVendor;
    _data['ReviewedByAdmin'] = ReviewedByAdmin;
    _data['TaxVATApply'] = TaxVATApply;
    _data['LockEdit'] = LockEdit;
    _data['Active'] = Active;
    _data['LastUpdate'] = LastUpdate;
    _data['AdminNote'] = AdminNote;

    _data['StoreCity'] = StoreCity;
    _data['StoreCountry'] = StoreCountry;
    _data['StoreState'] = StoreState;

    _data['TaxRate'] = TaxRate;

    ///
    _data['ProductCombinations'] =
        productCombinations.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductCombinations2 {
  ProductCombinations2(
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

  ProductCombinations2.fromJson(Map<String, dynamic> json) {
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

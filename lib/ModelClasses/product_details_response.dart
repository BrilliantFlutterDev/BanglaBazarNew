class ProductDetailsResponse {
  ProductDetailsResponse({
    required this.status,
    required this.buisnessDetail,
    required this.productDetail,
    required this.MainImage,
    required this.variantDetails,
    required this.productAverageRatingAndReviews,
    required this.productRatingCount,
    required this.usersProductReviewAndRating,
    required this.product,
    required this.inWishList,
  });
  late final bool status;
  late final BuisnessDetail buisnessDetail;
  late final ProductDetail productDetail;
  late String MainImage;
  late final List<VariantDetails> variantDetails;
  late final ProductAverageRatingAndReviews productAverageRatingAndReviews;
  late final ProductRatingCount productRatingCount;
  late final List<UsersProductReviewAndRating> usersProductReviewAndRating;
  late final List<Product> product;
  late bool inWishList;

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    buisnessDetail = BuisnessDetail.fromJson(json['BuisnessDetail']);
    productDetail = ProductDetail.fromJson(json['ProductDetail']);
    MainImage = json['MainImage'];
    variantDetails = List.from(json['VariantDetails'])
        .map((e) => VariantDetails.fromJson(e))
        .toList();
    productAverageRatingAndReviews = ProductAverageRatingAndReviews.fromJson(
        json['ProductAverageRatingAndReviews']);
    productRatingCount =
        ProductRatingCount.fromJson(json['ProductRatingCount']);
    usersProductReviewAndRating = List.from(json['UsersProductReviewAndRating'])
        .map((e) => UsersProductReviewAndRating.fromJson(e))
        .toList();
    product =
        List.from(json['Product']).map((e) => Product.fromJson(e)).toList();
    inWishList = json['inWishList'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['BuisnessDetail'] = buisnessDetail.toJson();
    _data['ProductDetail'] = productDetail.toJson();
    _data['MainImage'] = MainImage;
    _data['VariantDetails'] = variantDetails.map((e) => e.toJson()).toList();
    _data['ProductAverageRatingAndReviews'] =
        productAverageRatingAndReviews.toJson();
    _data['ProductRatingCount'] = productRatingCount.toJson();
    _data['UsersProductReviewAndRating'] =
        usersProductReviewAndRating.map((e) => e.toJson()).toList();
    _data['Product'] = product.map((e) => e.toJson()).toList();
    _data['inWishList'] = inWishList;
    return _data;
  }
}

class BuisnessDetail {
  BuisnessDetail({
    required this.VendorID,
    required this.CompanyName,
    required this.TaxID,
    required this.TaxIDPic,
    required this.GovernmentID,
    required this.GovernmentIDPic,
    required this.CompanyLogo,
    required this.BannerImage,
    required this.Address1,
    required this.Address2,
    required this.CityID,
    required this.City,
    required this.State,
    required this.ZipCode,
    required this.GoogleMapID,
    required this.CountryID,
    required this.PaymentAccount,
    required this.PaymentRouting,
    required this.BusinessEmail,
    required this.BusinessPhone,
    required this.EmailVerified,
    required this.PhoneVerified,
    required this.BusinessURL,
    required this.PageURL,
    required this.ReviewedByAdmin,
    required this.ReviewedBySuperAdmin,
    required this.GatewayID,
    required this.AllowDelivery,
    required this.AllowStorePickup,
    required this.ProductApproval,
    required this.CreatedDate,
    required this.LastUpdate,
    required this.About,
    required this.Policies,
    required this.AdminNote,
    required this.VendorRating,
    required this.TotalVendorReview,
  });
  late final int VendorID;
  late final String CompanyName;
  late final String TaxID;
  late final String TaxIDPic;
  late final String GovernmentID;
  late final String GovernmentIDPic;
  late final String CompanyLogo;
  late final String BannerImage;
  late final String Address1;
  late final String Address2;
  late final int CityID;
  late final String City;
  late final String State;
  late final String ZipCode;
  late final String GoogleMapID;
  late final int CountryID;
  late final String PaymentAccount;
  late final String PaymentRouting;
  late final String BusinessEmail;
  late final String BusinessPhone;
  late final String EmailVerified;
  late final String PhoneVerified;
  late final String BusinessURL;
  late final String PageURL;
  late final String ReviewedByAdmin;
  late final String ReviewedBySuperAdmin;
  late final int GatewayID;
  late final String AllowDelivery;
  late final String AllowStorePickup;
  late final String ProductApproval;
  late final String CreatedDate;
  late final String LastUpdate;
  late final String About;
  late final String Policies;
  late final String AdminNote;
  late final String VendorRating;
  late final int TotalVendorReview;

  BuisnessDetail.fromJson(Map<String, dynamic> json) {
    VendorID = json['VendorID'];
    CompanyName = json['CompanyName'];
    TaxID = json['TaxID'];
    TaxIDPic = json['TaxIDPic'];
    GovernmentID = json['GovernmentID'];
    GovernmentIDPic = json['GovernmentIDPic'];
    CompanyLogo = json['CompanyLogo'];
    BannerImage = json['BannerImage'];
    Address1 = json['Address1'];
    Address2 = json['Address2'];
    CityID = json['CityID'];
    City = json['City'];
    State = json['State'];
    ZipCode = json['ZipCode'];
    GoogleMapID = json['GoogleMapID'];
    CountryID = json['CountryID'];
    PaymentAccount = json['PaymentAccount'];
    PaymentRouting = json['PaymentRouting'];
    BusinessEmail = json['BusinessEmail'];
    BusinessPhone = json['BusinessPhone'];
    EmailVerified = json['EmailVerified'];
    PhoneVerified = json['PhoneVerified'];
    BusinessURL = json['BusinessURL'];
    PageURL = json['PageURL'];
    ReviewedByAdmin = json['ReviewedByAdmin'];
    ReviewedBySuperAdmin = json['ReviewedBySuperAdmin'];
    GatewayID = json['GatewayID'];
    AllowDelivery = json['AllowDelivery'];
    AllowStorePickup = json['AllowStorePickup'];
    ProductApproval = json['ProductApproval'];
    CreatedDate = json['CreatedDate'];
    LastUpdate = json['LastUpdate'] != null ? json['LastUpdate'] : '';
    About = json['About'] ?? '';
    Policies = json['Policies'] ?? '';
    AdminNote = json['AdminNote'] != null ? json['AdminNote'] : '';
    VendorRating = json['VendorRating'];
    TotalVendorReview = json['TotalVendorReview'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['VendorID'] = VendorID;
    _data['CompanyName'] = CompanyName;
    _data['TaxID'] = TaxID;
    _data['TaxIDPic'] = TaxIDPic;
    _data['GovernmentID'] = GovernmentID;
    _data['GovernmentIDPic'] = GovernmentIDPic;
    _data['CompanyLogo'] = CompanyLogo;
    _data['BannerImage'] = BannerImage;
    _data['Address1'] = Address1;
    _data['Address2'] = Address2;
    _data['CityID'] = CityID;
    _data['City'] = City;
    _data['State'] = State;
    _data['ZipCode'] = ZipCode;
    _data['GoogleMapID'] = GoogleMapID;
    _data['CountryID'] = CountryID;
    _data['PaymentAccount'] = PaymentAccount;
    _data['PaymentRouting'] = PaymentRouting;
    _data['BusinessEmail'] = BusinessEmail;
    _data['BusinessPhone'] = BusinessPhone;
    _data['EmailVerified'] = EmailVerified;
    _data['PhoneVerified'] = PhoneVerified;
    _data['BusinessURL'] = BusinessURL;
    _data['PageURL'] = PageURL;
    _data['ReviewedByAdmin'] = ReviewedByAdmin;
    _data['ReviewedBySuperAdmin'] = ReviewedBySuperAdmin;
    _data['GatewayID'] = GatewayID;
    _data['AllowDelivery'] = AllowDelivery;
    _data['AllowStorePickup'] = AllowStorePickup;
    _data['ProductApproval'] = ProductApproval;
    _data['CreatedDate'] = CreatedDate;
    _data['LastUpdate'] = LastUpdate;
    _data['About'] = About;
    _data['Policies'] = Policies;
    _data['AdminNote'] = AdminNote;
    _data['VendorRating'] = VendorRating;
    _data['TotalVendorReview'] = TotalVendorReview;
    return _data;
  }
}

class ProductDetail {
  ProductDetail({
    required this.ProductID,
    required this.VendorID,
    required this.SubCategoryID,
    required this.SubCategory,
    required this.CategoryID,
    required this.Category,
    required this.Title,
    required this.StoreName,
    required this.Description,
    required this.SpecialInstruction,
    required this.ReturnPolicy,
    required this.Currency,
    required this.CostPrice,
    required this.Price,
    required this.Quantity1,
    required this.PriceQuantity1,
    required this.Quantity2,
    required this.PriceQuantity2,
    required this.Quantity3,
    required this.PriceQuantity3,
    required this.PromotionPrice,
    required this.PromotionRate,
    required this.PromotionStartDate,
    required this.PromotionEndDate,
    required this.Weight,
    required this.Height,
    required this.Length,
    required this.Width,
    required this.AllowStorePickup,
    required this.ShippingAvailable,
    required this.ShippingGlobal,
    required this.ShippingByAdmin,
    required this.ShippingByVendor,
    required this.ShippingCostAdmin,
    required this.ShippingCostVendor,
    required this.ReviewedByAdmin,
    required this.TaxVATApply,
    required this.LockEdit,
    required this.Active,
    required this.LastUpdate,
    required this.AdminNote,
    required this.ProductCity,
    required this.CityNative,
    required this.ProductCountry,
  });
  late final int ProductID;
  late final int VendorID;
  late final int SubCategoryID;
  late final String SubCategory;
  late final int CategoryID;
  late final String Category;
  late final String Title;
  late final String StoreName;
  late final String Description;
  late final String SpecialInstruction;
  late final String ReturnPolicy;
  late final String Currency;
  late final String CostPrice;
  late final String Price;
  late final int Quantity1;
  late final String PriceQuantity1;
  late final int Quantity2;
  late final String PriceQuantity2;
  late final int Quantity3;
  late final String PriceQuantity3;
  late final String PromotionPrice;
  late final String PromotionRate;
  late final String PromotionStartDate;
  late final String PromotionEndDate;
  late final String Weight;
  late final String Height;
  late final String Length;
  late final String Width;
  late final String AllowStorePickup;
  late final String ShippingAvailable;
  late final String ShippingGlobal;
  late final String ShippingByAdmin;
  late final String ShippingByVendor;
  late final String ShippingCostAdmin;
  late final String ShippingCostVendor;
  late final String ReviewedByAdmin;
  late final String TaxVATApply;
  late final String LockEdit;
  late final String Active;
  late final String LastUpdate;
  late final String AdminNote;
  late final String ProductCity;
  late final String CityNative;
  late final String ProductCountry;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    VendorID = json['VendorID'];
    SubCategoryID = json['SubCategoryID'];
    SubCategory = json['SubCategory'];
    CategoryID = json['CategoryID'];
    Category = json['Category'];
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
    Weight = json['Weight'];
    Height = json['Height'];
    Length = json['Length'];
    Width = json['Width'];
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
    LastUpdate = json['LastUpdate'] != null ? json['LastUpdate'] : '';
    AdminNote = json['AdminNote'] != null ? json['AdminNote'] : '';
    ProductCity = json['ProductCity'] != null ? json['ProductCity'] : '';
    CityNative = json['CityNative'] != null ? json['CityNative'] : '';
    ProductCountry =
        json['ProductCountry'] != null ? json['ProductCountry'] : '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['VendorID'] = VendorID;
    _data['SubCategoryID'] = SubCategoryID;
    _data['SubCategory'] = SubCategory;
    _data['CategoryID'] = CategoryID;
    _data['Category'] = Category;
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
    _data['ProductCity'] = ProductCity;
    _data['CityNative'] = CityNative;
    _data['ProductCountry'] = ProductCountry;
    return _data;
  }
}

class VariantDetails {
  VariantDetails({
    required this.Name,
    required this.values,
  });
  late final String Name;
  late final List<Values> values;
  int selectedVariant = -1;
  int lastSelectedVariantID = -1;
  double lastPriceAdded = 0;

  VariantDetails.fromJson(Map<String, dynamic> json) {
    Name = json['Name'];
    values = List.from(json['Values']).map((e) => Values.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Name'] = Name;
    _data['Values'] = values.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Values {
  Values({
    required this.OptionID,
    required this.OptionValueID,
    required this.VariantValue,
    required this.Small,
    required this.Medium,
    required this.Large,
    required this.SKU,
    required this.VariantPrice,
    required this.AvailableInventory,
    required this.Inventory,
    required this.UnitPrice,
    required this.TotalPrice,
    required this.Status,
    required this.MainImage,
    required this.ProductVariantCombinationID,
  });
  late final int OptionID;
  late final int OptionValueID;
  late final String VariantValue;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final String SKU;
  late final String VariantPrice;
  late final int AvailableInventory;
  late final int Inventory;
  late final String UnitPrice;
  late final String TotalPrice;
  late final String Status;
  late final String MainImage;
  late final int ProductVariantCombinationID;

  Values.fromJson(Map<String, dynamic> json) {
    OptionID = json['OptionID'];
    OptionValueID = json['OptionValueID'];
    VariantValue = json['VariantValue'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    SKU = json['SKU'];
    VariantPrice = json['VariantPrice'];
    AvailableInventory = json['AvailableInventory'];
    Inventory = json['Inventory'];
    UnitPrice = json['UnitPrice'];
    TotalPrice = json['TotalPrice'];
    Status = json['Status'];
    MainImage = json['MainImage'];
    ProductVariantCombinationID = json['ProductVariantCombinationID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['OptionID'] = OptionID;
    _data['OptionValueID'] = OptionValueID;
    _data['VariantValue'] = VariantValue;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['SKU'] = SKU;
    _data['VariantPrice'] = VariantPrice;
    _data['AvailableInventory'] = AvailableInventory;
    _data['Inventory'] = Inventory;
    _data['UnitPrice'] = UnitPrice;
    _data['TotalPrice'] = TotalPrice;
    _data['Status'] = Status;
    _data['MainImage'] = MainImage;
    _data['ProductVariantCombinationID'] = ProductVariantCombinationID;
    return _data;
  }
}

class ProductAverageRatingAndReviews {
  ProductAverageRatingAndReviews({
    required this.TotalReviews,
    required this.ProductAverageRating,
    required this.TotalRating,
    required this.VendorRating,
    required this.TotalVendorReview,
  });
  late final int TotalReviews;
  late final String? ProductAverageRating;
  late final String? TotalRating;
  late final String VendorRating;
  late final int TotalVendorReview;

  ProductAverageRatingAndReviews.fromJson(Map<String, dynamic> json) {
    TotalReviews = json['Total_Reviews'];
    ProductAverageRating = json['ProductAverageRating'] != null
        ? json['ProductAverageRating']
        : '';
    TotalRating = json['TotalRating'] != null ? json['TotalRating'] : '';
    VendorRating = json['VendorRating'];
    TotalVendorReview = json['TotalVendorReview'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Total_Reviews'] = TotalReviews;
    _data['ProductAverageRating'] = ProductAverageRating;
    _data['TotalRating'] = TotalRating;
    _data['VendorRating'] = VendorRating;
    _data['TotalVendorReview'] = TotalVendorReview;
    return _data;
  }
}

class ProductRatingCount {
  ProductRatingCount({
    required this.rating_1,
    required this.rating_2,
    required this.rating_3,
    required this.rating_4,
    required this.rating_5,
  });
  late final int rating_1;
  late final int rating_2;
  late final int rating_3;
  late final int rating_4;
  late final int rating_5;

  ProductRatingCount.fromJson(Map<String, dynamic> json) {
    rating_1 = json['rating_1'];
    rating_2 = json['rating_2'];
    rating_3 = json['rating_3'];
    rating_4 = json['rating_4'];
    rating_5 = json['rating_5'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rating_1'] = rating_1;
    _data['rating_2'] = rating_2;
    _data['rating_3'] = rating_3;
    _data['rating_4'] = rating_4;
    _data['rating_5'] = rating_5;
    return _data;
  }
}

class UsersProductReviewAndRating {
  UsersProductReviewAndRating({
    required this.ID,
    required this.UserID,
    required this.ProductID,
    required this.Review,
    required this.Rating,
    required this.PurchaseVerified,
    required this.LastUpdate,
    required this.UserName,
    this.ProfilePic,
  });
  late final int ID;
  late final int UserID;
  late final int ProductID;
  late final String Review;
  late final int Rating;
  late final String PurchaseVerified;
  late final String LastUpdate;
  late final String UserName;
  late final String? ProfilePic;

  UsersProductReviewAndRating.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    UserID = json['UserID'];
    ProductID = json['ProductID'];
    Review = json['Review'];
    Rating = json['Rating'];
    PurchaseVerified = json['PurchaseVerified'];
    LastUpdate = json['LastUpdate'];
    UserName = json['UserName'];
    ProfilePic = json['ProfilePic'] != null ? json['ProfilePic'] : '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ID'] = ID;
    _data['UserID'] = UserID;
    _data['ProductID'] = ProductID;
    _data['Review'] = Review;
    _data['Rating'] = Rating;
    _data['PurchaseVerified'] = PurchaseVerified;
    _data['LastUpdate'] = LastUpdate;
    _data['UserName'] = UserName;
    _data['ProfilePic'] = ProfilePic;
    return _data;
  }
}

class Product {
  Product({
    required this.VendorID,
    required this.CompanyName,
    required this.TaxID,
    required this.TaxIDPic,
    required this.GovernmentID,
    required this.GovernmentIDPic,
    required this.CompanyLogo,
    required this.BannerImage,
    required this.Address1,
    required this.Address2,
    required this.CityID,
    required this.City,
    required this.State,
    required this.ZipCode,
    required this.GoogleMapID,
    required this.CountryID,
    required this.PaymentAccount,
    required this.PaymentRouting,
    required this.BusinessEmail,
    required this.BusinessPhone,
    required this.EmailVerified,
    required this.PhoneVerified,
    required this.BusinessURL,
    required this.PageURL,
    required this.ReviewedByAdmin,
    required this.ReviewedBySuperAdmin,
    required this.GatewayID,
    required this.AllowDelivery,
    required this.AllowStorePickup,
    required this.ProductApproval,
    required this.CreatedDate,
    required this.LastUpdate,
    required this.About,
    required this.Policies,
    required this.AdminNote,
    required this.ProductID,
    required this.SubCategoryID,
    required this.Title,
    required this.StoreName,
    required this.Description,
    required this.SpecialInstruction,
    required this.ReturnPolicy,
    required this.Currency,
    required this.CostPrice,
    required this.Price,
    required this.Quantity1,
    required this.PriceQuantity1,
    required this.Quantity2,
    required this.PriceQuantity2,
    required this.Quantity3,
    required this.PriceQuantity3,
    required this.PromotionPrice,
    required this.PromotionRate,
    required this.PromotionStartDate,
    required this.PromotionEndDate,
    required this.Weight,
    required this.Height,
    required this.Length,
    required this.Width,
    required this.ShippingAvailable,
    required this.ShippingGlobal,
    required this.ShippingByAdmin,
    required this.ShippingByVendor,
    required this.ShippingCostAdmin,
    required this.ShippingCostVendor,
    required this.TaxVATApply,
    required this.LockEdit,
    required this.Active,
    required this.SubCategory,
    required this.Category,
    required this.CategoryID,
    required this.ProductCity,
    required this.CityNative,
    required this.ProductCountry,
    required this.VariantName,
    required this.OptionID,
    required this.OptionValueID,
    required this.VariantValue,
    required this.Small,
    required this.Medium,
    required this.Large,
    required this.SKU,
    required this.AvailableInventory,
    required this.Inventory,
    required this.UnitPrice,
    required this.TotalPrice,
    required this.Status,
    required this.MainImage,
  });
  late final int VendorID;
  late final String CompanyName;
  late final String TaxID;
  late final String TaxIDPic;
  late final String GovernmentID;
  late final String GovernmentIDPic;
  late final String CompanyLogo;
  late final String BannerImage;
  late final String Address1;
  late final String Address2;
  late final int CityID;
  late final String City;
  late final String State;
  late final String ZipCode;
  late final String GoogleMapID;
  late final int CountryID;
  late final String PaymentAccount;
  late final String PaymentRouting;
  late final String BusinessEmail;
  late final String BusinessPhone;
  late final String EmailVerified;
  late final String PhoneVerified;
  late final String BusinessURL;
  late final String PageURL;
  late final String ReviewedByAdmin;
  late final String ReviewedBySuperAdmin;
  late final int GatewayID;
  late final String AllowDelivery;
  late final String AllowStorePickup;
  late final String ProductApproval;
  late final String CreatedDate;
  late final String LastUpdate;
  late final String About;
  late final String Policies;
  late final String AdminNote;
  late final int ProductID;
  late final int SubCategoryID;
  late final String Title;
  late final String StoreName;
  late final String Description;
  late final String SpecialInstruction;
  late final String ReturnPolicy;
  late final String Currency;
  late final String CostPrice;
  late final String Price;
  late final int Quantity1;
  late final String PriceQuantity1;
  late final int Quantity2;
  late final String PriceQuantity2;
  late final int Quantity3;
  late final String PriceQuantity3;
  late final String PromotionPrice;
  late final String PromotionRate;
  late final String PromotionStartDate;
  late final String PromotionEndDate;
  late final String Weight;
  late final String Height;
  late final String Length;
  late final String Width;
  late final String ShippingAvailable;
  late final String ShippingGlobal;
  late final String ShippingByAdmin;
  late final String ShippingByVendor;
  late final String ShippingCostAdmin;
  late final String ShippingCostVendor;
  late final String TaxVATApply;
  late final String LockEdit;
  late final String Active;
  late final String SubCategory;
  late final String Category;
  late final int CategoryID;
  late final String ProductCity;
  late final String CityNative;
  late final String ProductCountry;
  late final String VariantName;
  late final int OptionID;
  late final int OptionValueID;
  late final String VariantValue;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final String SKU;
  late final int AvailableInventory;
  late final int Inventory;
  late final String UnitPrice;
  late final String TotalPrice;
  late final String Status;
  late final String MainImage;

  Product.fromJson(Map<String, dynamic> json) {
    VendorID = json['VendorID'];
    CompanyName = json['CompanyName'];
    TaxID = json['TaxID'];
    TaxIDPic = json['TaxIDPic'];
    GovernmentID = json['GovernmentID'];
    GovernmentIDPic = json['GovernmentIDPic'];
    CompanyLogo = json['CompanyLogo'];
    BannerImage = json['BannerImage'];
    Address1 = json['Address1'];
    Address2 = json['Address2'];
    CityID = json['CityID'];
    City = json['City'];
    State = json['State'];
    ZipCode = json['ZipCode'];
    GoogleMapID = json['GoogleMapID'];
    CountryID = json['CountryID'];
    PaymentAccount = json['PaymentAccount'];
    PaymentRouting = json['PaymentRouting'];
    BusinessEmail = json['BusinessEmail'];
    BusinessPhone = json['BusinessPhone'];
    EmailVerified = json['EmailVerified'];
    PhoneVerified = json['PhoneVerified'];
    BusinessURL = json['BusinessURL'];
    PageURL = json['PageURL'];
    ReviewedByAdmin = json['ReviewedByAdmin'];
    ReviewedBySuperAdmin = json['ReviewedBySuperAdmin'];
    GatewayID = json['GatewayID'];
    AllowDelivery = json['AllowDelivery'];
    AllowStorePickup = json['AllowStorePickup'];
    ProductApproval = json['ProductApproval'];
    CreatedDate = json['CreatedDate'];
    LastUpdate = json['LastUpdate'] != null ? json['LastUpdate'] : '';
    About = json['About'] ?? '';
    Policies = json['Policies'] ?? "";
    AdminNote = json['AdminNote'] != null ? json['AdminNote'] : '';
    ProductID = json['ProductID'];
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
    Weight = json['Weight'];
    Height = json['Height'];
    Length = json['Length'];
    Width = json['Width'];
    ShippingAvailable = json['ShippingAvailable'];
    ShippingGlobal = json['ShippingGlobal'];
    ShippingByAdmin = json['ShippingByAdmin'];
    ShippingByVendor = json['ShippingByVendor'];
    ShippingCostAdmin = json['ShippingCostAdmin'];
    ShippingCostVendor = json['ShippingCostVendor'];
    TaxVATApply = json['TaxVATApply'];
    LockEdit = json['LockEdit'];
    Active = json['Active'];
    SubCategory = json['SubCategory'];
    Category = json['Category'];
    CategoryID = json['CategoryID'];
    ProductCity = json['ProductCity'] != null ? json['ProductCity'] : '';
    CityNative = json['CityNative'] != null ? json['CityNative'] : '';
    ProductCountry =
        json['ProductCountry'] != null ? json['ProductCountry'] : '';
    VariantName = json['VariantName'];
    OptionID = json['OptionID'];
    OptionValueID = json['OptionValueID'];
    VariantValue = json['VariantValue'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    SKU = json['SKU'];
    AvailableInventory = json['AvailableInventory'];
    Inventory = json['Inventory'];
    UnitPrice = json['UnitPrice'];
    TotalPrice = json['TotalPrice'];
    Status = json['Status'];
    MainImage = json['MainImage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['VendorID'] = VendorID;
    _data['CompanyName'] = CompanyName;
    _data['TaxID'] = TaxID;
    _data['TaxIDPic'] = TaxIDPic;
    _data['GovernmentID'] = GovernmentID;
    _data['GovernmentIDPic'] = GovernmentIDPic;
    _data['CompanyLogo'] = CompanyLogo;
    _data['BannerImage'] = BannerImage;
    _data['Address1'] = Address1;
    _data['Address2'] = Address2;
    _data['CityID'] = CityID;
    _data['City'] = City;
    _data['State'] = State;
    _data['ZipCode'] = ZipCode;
    _data['GoogleMapID'] = GoogleMapID;
    _data['CountryID'] = CountryID;
    _data['PaymentAccount'] = PaymentAccount;
    _data['PaymentRouting'] = PaymentRouting;
    _data['BusinessEmail'] = BusinessEmail;
    _data['BusinessPhone'] = BusinessPhone;
    _data['EmailVerified'] = EmailVerified;
    _data['PhoneVerified'] = PhoneVerified;
    _data['BusinessURL'] = BusinessURL;
    _data['PageURL'] = PageURL;
    _data['ReviewedByAdmin'] = ReviewedByAdmin;
    _data['ReviewedBySuperAdmin'] = ReviewedBySuperAdmin;
    _data['GatewayID'] = GatewayID;
    _data['AllowDelivery'] = AllowDelivery;
    _data['AllowStorePickup'] = AllowStorePickup;
    _data['ProductApproval'] = ProductApproval;
    _data['CreatedDate'] = CreatedDate;
    _data['LastUpdate'] = LastUpdate;
    _data['About'] = About;
    _data['Policies'] = Policies;
    _data['AdminNote'] = AdminNote;
    _data['ProductID'] = ProductID;
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
    _data['ShippingAvailable'] = ShippingAvailable;
    _data['ShippingGlobal'] = ShippingGlobal;
    _data['ShippingByAdmin'] = ShippingByAdmin;
    _data['ShippingByVendor'] = ShippingByVendor;
    _data['ShippingCostAdmin'] = ShippingCostAdmin;
    _data['ShippingCostVendor'] = ShippingCostVendor;
    _data['TaxVATApply'] = TaxVATApply;
    _data['LockEdit'] = LockEdit;
    _data['Active'] = Active;
    _data['SubCategory'] = SubCategory;
    _data['Category'] = Category;
    _data['CategoryID'] = CategoryID;
    _data['ProductCity'] = ProductCity;
    _data['CityNative'] = CityNative;
    _data['ProductCountry'] = ProductCountry;
    _data['VariantName'] = VariantName;
    _data['OptionID'] = OptionID;
    _data['OptionValueID'] = OptionValueID;
    _data['VariantValue'] = VariantValue;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['SKU'] = SKU;
    _data['AvailableInventory'] = AvailableInventory;
    _data['Inventory'] = Inventory;
    _data['UnitPrice'] = UnitPrice;
    _data['TotalPrice'] = TotalPrice;
    _data['Status'] = Status;
    _data['MainImage'] = MainImage;
    return _data;
  }
}

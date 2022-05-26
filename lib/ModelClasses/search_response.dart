class SearchResponse {
  SearchResponse({
    required this.status,
    required this.totalRecords,
    required this.product,
  });
  late final bool status;
  late final int totalRecords;
  late final List<Product> product;

  SearchResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecords = json['total_records'];
    product =
        List.from(json['Product']).map((e) => Product.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['total_records'] = totalRecords;
    _data['Product'] = product.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Product {
  Product({
    required this.CompanyName,
    required this.CategoryID,
    required this.Category,
    required this.SubCategory,
    required this.ProductID,
    required this.VendorID,
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
    // required this.LastUpdate,
    // required this.AdminNote,
    required this.Small,
    required this.Medium,
    required this.Large,
  });
  late final String CompanyName;
  late final int CategoryID;
  late final String Category;
  late final String SubCategory;
  late final int ProductID;
  late final int VendorID;
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
  // late final String LastUpdate;
  // late final String AdminNote;
  late final String Small;
  late final String Medium;
  late final String Large;

  Product.fromJson(Map<String, dynamic> json) {
    CompanyName = json['CompanyName'];
    CategoryID = json['CategoryID'];
    Category = json['Category'];
    SubCategory = json['SubCategory'];
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
    // LastUpdate = json['LastUpdate'];
    // AdminNote = json['AdminNote'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CompanyName'] = CompanyName;
    _data['CategoryID'] = CategoryID;
    _data['Category'] = Category;
    _data['SubCategory'] = SubCategory;
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
    // _data['LastUpdate'] = LastUpdate;
    // _data['AdminNote'] = AdminNote;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    return _data;
  }
}

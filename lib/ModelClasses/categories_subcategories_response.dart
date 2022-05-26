class CategoriesAndSubcategoriesResponse {
  CategoriesAndSubcategoriesResponse({
    required this.status,
    required this.categoriesAndSubCategories,
  });
  late final bool status;
  late final List<CategoriesAndSubCategories> categoriesAndSubCategories;

  CategoriesAndSubcategoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoriesAndSubCategories = List.from(json['categoriesAndSubCategories'])
        .map((e) => CategoriesAndSubCategories.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['categoriesAndSubCategories'] =
        categoriesAndSubCategories.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CategoriesAndSubCategories {
  CategoriesAndSubCategories({
    required this.categoryDetails,
    required this.subCategoryDetails,
  });
  late final CategoryDetails categoryDetails;
  late final List<SubCategoryDetails> subCategoryDetails;

  CategoriesAndSubCategories.fromJson(Map<String, dynamic> json) {
    categoryDetails = CategoryDetails.fromJson(json['CategoryDetails']);
    subCategoryDetails = List.from(json['SubCategoryDetails'])
        .map((e) => SubCategoryDetails.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CategoryDetails'] = categoryDetails.toJson();
    _data['SubCategoryDetails'] =
        subCategoryDetails.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CategoryDetails {
  CategoryDetails({
    required this.CategoryID,
    required this.DepartmentID,
    required this.Category,
    required this.Description,
    required this.CategoryPic,
    required this.ShippingGlobal,
    required this.Active,
    this.LastUpdate,
  });
  late final int CategoryID;
  late final int DepartmentID;
  late final String Category;
  late final String Description;
  late final String CategoryPic;
  late final String ShippingGlobal;
  late final String Active;
  late final Null LastUpdate;

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    CategoryID = json['CategoryID'];
    DepartmentID = json['DepartmentID'];
    Category = json['Category'];
    Description = json['Description'];
    CategoryPic = json['CategoryPic'];
    ShippingGlobal = json['ShippingGlobal'];
    Active = json['Active'];
    LastUpdate = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CategoryID'] = CategoryID;
    _data['DepartmentID'] = DepartmentID;
    _data['Category'] = Category;
    _data['Description'] = Description;
    _data['CategoryPic'] = CategoryPic;
    _data['ShippingGlobal'] = ShippingGlobal;
    _data['Active'] = Active;
    _data['LastUpdate'] = LastUpdate;
    return _data;
  }
}

class SubCategoryDetails {
  SubCategoryDetails({
    required this.SubCategoryID,
    required this.SubCategory,
    required this.SubCategoryDescription,
    required this.SubCategoryPic,
    required this.SubCategoryShippingGlobal,
    required this.SubCategoryActive,
    this.SubCategoryLastUpdate,
  });
  late final int SubCategoryID;
  late final String SubCategory;
  late final String SubCategoryDescription;
  late final String SubCategoryPic;
  late final String SubCategoryShippingGlobal;
  late final String SubCategoryActive;
  late final Null SubCategoryLastUpdate;
  bool isOpen = false;

  SubCategoryDetails.fromJson(Map<String, dynamic> json) {
    SubCategoryID = json['SubCategoryID'];
    SubCategory = json['SubCategory'];
    SubCategoryDescription = json['SubCategory_Description'];
    SubCategoryPic = json['SubCategoryPic'];
    SubCategoryShippingGlobal = json['SubCategory_ShippingGlobal'];
    SubCategoryActive = json['SubCategory_Active'];
    SubCategoryLastUpdate = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['SubCategoryID'] = SubCategoryID;
    _data['SubCategory'] = SubCategory;
    _data['SubCategory_Description'] = SubCategoryDescription;
    _data['SubCategoryPic'] = SubCategoryPic;
    _data['SubCategory_ShippingGlobal'] = SubCategoryShippingGlobal;
    _data['SubCategory_Active'] = SubCategoryActive;
    _data['SubCategory_LastUpdate'] = SubCategoryLastUpdate;
    return _data;
  }
}

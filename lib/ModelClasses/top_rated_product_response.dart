class TopRatedProductsResponse {
  TopRatedProductsResponse({
    required this.status,
    required this.totalRecords,
    required this.viewTopRatedProducts,
  });
  late final bool status;
  late final int totalRecords;
  late final List<ViewTopRatedProducts> viewTopRatedProducts;

  TopRatedProductsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecords = json['total_records'];
    viewTopRatedProducts = List.from(json['viewTopRatedProducts'])
        .map((e) => ViewTopRatedProducts.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['total_records'] = totalRecords;
    _data['viewTopRatedProducts'] =
        viewTopRatedProducts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ViewTopRatedProducts {
  ViewTopRatedProducts({
    required this.ProductID,
    required this.Currency,
    required this.Title,
    required this.Price,
    this.TotalRating,
    required this.ReviewCount,
    required this.Small,
    required this.Medium,
    required this.Large,
    this.AVGRATING,
  });
  late final int ProductID;
  late final String Currency;
  late final String Title;
  late final String Price;
  late final String? TotalRating;
  late final int ReviewCount;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final String? AVGRATING;

  ViewTopRatedProducts.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Currency = json['Currency'];
    Title = json['Title'];
    Price = json['Price'];
    TotalRating = json['Total_Rating'] != null ? json['Total_Rating'] : '0';
    ReviewCount = json['ReviewCount'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    AVGRATING = json['AVG_RATING'] != null ? json['AVG_RATING'] : '0';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['Currency'] = Currency;
    _data['Title'] = Title;
    _data['Price'] = Price;
    _data['Total_Rating'] = TotalRating;
    _data['ReviewCount'] = ReviewCount;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['AVG_RATING'] = AVGRATING;
    return _data;
  }
}

class RecentlyViewedItemsResponse {
  RecentlyViewedItemsResponse({
    required this.status,
    required this.totalRecords,
    required this.recentlyViewedProducts,
  });
  late final bool status;
  late final int totalRecords;
  late final List<RecentlyViewedProducts> recentlyViewedProducts;

  RecentlyViewedItemsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecords = json['total_records'];
    recentlyViewedProducts = List.from(json['recentlyViewedProducts'])
        .map((e) => RecentlyViewedProducts.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['total_records'] = totalRecords;
    _data['recentlyViewedProducts'] =
        recentlyViewedProducts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class RecentlyViewedProducts {
  RecentlyViewedProducts({
    required this.ProductID,
    required this.Title,
    required this.Price,
    required this.UserID,
    required this.Small,
    required this.Medium,
    required this.Large,
    required this.REVIEWCOUNT,
    required this.AVGRATING,
    required this.Currency,
  });
  late final int ProductID;
  late final String Title;
  late final String Price;
  late final int UserID;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final int REVIEWCOUNT;
  late final String AVGRATING;
  late final String Currency;

  RecentlyViewedProducts.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Title = json['Title'];
    Price = json['Price'];
    UserID = json['UserID'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    REVIEWCOUNT = json['REVIEW_COUNT'];
    AVGRATING = json['AVG_RATING'] != null ? json['AVG_RATING'] : '0';
    Currency = json['Currency'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['Title'] = Title;
    _data['Price'] = Price;
    _data['UserID'] = UserID;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['REVIEW_COUNT'] = REVIEWCOUNT;
    _data['AVG_RATING'] = AVGRATING;
    _data['Currency'] = Currency;
    return _data;
  }
}

class TrendingForYouResponse {
  TrendingForYouResponse({
    required this.status,
    required this.totalRecords,
    required this.trendingForYouProducts,
  });
  late final bool status;
  late final int totalRecords;
  late final List<TrendingForYouProducts> trendingForYouProducts;

  TrendingForYouResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRecords = json['total_records'];
    trendingForYouProducts = List.from(json['trendingForYouProducts'])
        .map((e) => TrendingForYouProducts.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['total_records'] = totalRecords;
    _data['trendingForYouProducts'] =
        trendingForYouProducts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class TrendingForYouProducts {
  TrendingForYouProducts({
    required this.ProductID,
    required this.Title,
    required this.Price,
    required this.Currency,
    required this.Country,
    required this.Small,
    required this.Medium,
    required this.Large,
    required this.TotalClicks,
    required this.REVIEWCOUNT,
    required this.AVGRating,
  });
  late final int ProductID;
  late final String Title;
  late final String Price;
  late final String Currency;
  late final String Country;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final String TotalClicks;
  late final int REVIEWCOUNT;
  late final String AVGRating;

  TrendingForYouProducts.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Title = json['Title'];
    Price = json['Price'];
    Currency = json['Currency'];
    Country = json['Country'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    TotalClicks = json['Total_Clicks'];
    REVIEWCOUNT = json['REVIEW_COUNT'];
    AVGRating = json['AVG_Rating'] != null ? json['AVG_Rating'] : '0';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['Title'] = Title;
    _data['Price'] = Price;
    _data['Currency'] = Currency;
    _data['Country'] = Country;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['Total_Clicks'] = TotalClicks;
    _data['REVIEW_COUNT'] = REVIEWCOUNT;
    _data['AVG_Rating'] = AVGRating;
    return _data;
  }
}

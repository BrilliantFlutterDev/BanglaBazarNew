class HomePageApiResponse {
  HomePageApiResponse({
    required this.status,
    required this.recentlyViewedProducts,
    required this.mostPopularProducts,
    required this.topRatedProducts,
    required this.newArrivalProducts,
    required this.bestSellerVendor,
    required this.trendingForYouProducts,
  });
  late final bool status;
  late final List<RecentlyViewedProducts> recentlyViewedProducts;
  late final List<MostPopularProducts> mostPopularProducts;
  late final List<TopRatedProducts> topRatedProducts;
  late final List<NewArrivalProducts> newArrivalProducts;
  late final List<BestSellerVendor> bestSellerVendor;
  late final List<TrendingForYouProducts> trendingForYouProducts;

  HomePageApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    recentlyViewedProducts = List.from(json['recentlyViewedProducts'])
        .map((e) => RecentlyViewedProducts.fromJson(e))
        .toList();
    mostPopularProducts = List.from(json['mostPopularProducts'])
        .map((e) => MostPopularProducts.fromJson(e))
        .toList();
    topRatedProducts = List.from(json['topRatedProducts'])
        .map((e) => TopRatedProducts.fromJson(e))
        .toList();
    newArrivalProducts = List.from(json['newArrivalProducts'])
        .map((e) => NewArrivalProducts.fromJson(e))
        .toList();
    bestSellerVendor = List.from(json['bestSellerVendor'])
        .map((e) => BestSellerVendor.fromJson(e))
        .toList();
    trendingForYouProducts = List.from(json['trendingForYouProducts'])
        .map((e) => TrendingForYouProducts.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['recentlyViewedProducts'] =
        recentlyViewedProducts.map((e) => e.toJson()).toList();
    _data['mostPopularProducts'] =
        mostPopularProducts.map((e) => e.toJson()).toList();
    _data['topRatedProducts'] =
        topRatedProducts.map((e) => e.toJson()).toList();
    _data['newArrivalProducts'] =
        newArrivalProducts.map((e) => e.toJson()).toList();
    _data['bestSellerVendor'] =
        bestSellerVendor.map((e) => e.toJson()).toList();
    _data['trendingForYouProducts'] =
        trendingForYouProducts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class RecentlyViewedProducts {
  RecentlyViewedProducts({
    required this.ProductID,
    required this.Title,
    required this.Price,
    required this.Currency,
    required this.UserID,
    required this.Small,
    required this.Medium,
    required this.Large,
    required this.REVIEWCOUNT,
    this.AVGRATING,
  });
  late final int ProductID;
  late final String Title;
  late final String Price;
  late final String Currency;
  late final int UserID;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final int REVIEWCOUNT;
  late final String? AVGRATING;

  RecentlyViewedProducts.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Title = json['Title'];
    Price = json['Price'];
    Currency = json['Currency'];
    UserID = json['UserID'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    REVIEWCOUNT = json['REVIEW_COUNT'] != null ? json['REVIEW_COUNT'] : 0;
    AVGRATING = json['AVG_RATING'] != null ? json['AVG_RATING'] : '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['Title'] = Title;
    _data['Price'] = Price;
    _data['Currency'] = Currency;
    _data['UserID'] = UserID;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['REVIEW_COUNT'] = REVIEWCOUNT;
    _data['AVG_RATING'] = AVGRATING;
    return _data;
  }
}

class MostPopularProducts {
  MostPopularProducts({
    required this.ProductID,
    required this.Title,
    required this.Price,
    required this.Currency,
    required this.Small,
    required this.Medium,
    required this.Large,
    this.TotalClicks,
    required this.REVIEWCOUNT,
    this.AVGRating,
  });
  late final int ProductID;
  late final String Title;
  late final String Price;
  late final String Currency;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final String? TotalClicks;
  late final int REVIEWCOUNT;
  late final String? AVGRating;

  MostPopularProducts.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Title = json['Title'];
    Price = json['Price'];
    Currency = json['Currency'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    TotalClicks = json['Total_Clicks'] != null ? json['Total_Clicks'] : '';
    REVIEWCOUNT = json['REVIEW_COUNT'] != null ? json['REVIEW_COUNT'] : 0;
    AVGRating = json['AVG_Rating'] != null ? json['AVG_Rating'] : '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['Title'] = Title;
    _data['Price'] = Price;
    _data['Currency'] = Currency;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['Total_Clicks'] = TotalClicks;
    _data['REVIEW_COUNT'] = REVIEWCOUNT;
    _data['AVG_Rating'] = AVGRating;
    return _data;
  }
}

class TopRatedProducts {
  TopRatedProducts({
    required this.ProductID,
    required this.Title,
    required this.Price,
    required this.Currency,
    this.TotalRating,
    required this.ReviewCount,
    required this.Small,
    required this.Medium,
    required this.Large,
    this.AVGRATING,
  });
  late final int ProductID;
  late final String Title;
  late final String Price;
  late final String Currency;
  late final String? TotalRating;
  late final int ReviewCount;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final String? AVGRATING;

  TopRatedProducts.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Title = json['Title'];
    Price = json['Price'];
    Currency = json['Currency'];
    TotalRating = json['Total_Rating'] != null ? json['Total_Rating'] : '';
    ReviewCount = json['ReviewCount'] != null ? json['ReviewCount'] : 0;
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    AVGRATING = json['AVG_RATING'] != null ? json['AVG_RATING'] : '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['Title'] = Title;
    _data['Price'] = Price;
    _data['Currency'] = Currency;
    _data['Total_Rating'] = TotalRating;
    _data['ReviewCount'] = ReviewCount;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['AVG_RATING'] = AVGRATING;
    return _data;
  }
}

class NewArrivalProducts {
  NewArrivalProducts({
    required this.ProductID,
    required this.Title,
    required this.Price,
    required this.Currency,
    required this.Small,
    required this.Medium,
    required this.Large,
    required this.REVIEWCOUNT,
    this.AVGRATING,
  });
  late final int ProductID;
  late final String Title;
  late final String Price;
  late final String Currency;
  late final String Small;
  late final String Medium;
  late final String Large;
  late final int REVIEWCOUNT;
  late final String? AVGRATING;

  NewArrivalProducts.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Title = json['Title'];
    Price = json['Price'];
    Currency = json['Currency'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    REVIEWCOUNT = json['REVIEW_COUNT'] != null ? json['REVIEW_COUNT'] : 0;
    AVGRATING = json['AVG_RATING'] != null ? json['AVG_RATING'] : '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProductID'] = ProductID;
    _data['Title'] = Title;
    _data['Price'] = Price;
    _data['Currency'] = Currency;
    _data['Small'] = Small;
    _data['Medium'] = Medium;
    _data['Large'] = Large;
    _data['REVIEW_COUNT'] = REVIEWCOUNT;
    _data['AVG_RATING'] = AVGRATING;
    return _data;
  }
}

class BestSellerVendor {
  BestSellerVendor({
    required this.CompanyName,
    required this.CompanyLogo,
    required this.AVGRating,
  });
  late final String CompanyName;
  late final String CompanyLogo;
  late final String AVGRating;

  BestSellerVendor.fromJson(Map<String, dynamic> json) {
    CompanyName = json['CompanyName'];
    CompanyLogo = json['CompanyLogo'];
    AVGRating = json['AVG_Rating'] != null ? json['AVG_Rating'] : '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CompanyName'] = CompanyName;
    _data['CompanyLogo'] = CompanyLogo;
    _data['AVG_Rating'] = AVGRating;
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
    TotalClicks = json['Total_Clicks'] != null ? json['Total_Clicks'] : '';
    REVIEWCOUNT = json['REVIEW_COUNT'] != null ? json['REVIEW_COUNT'] : '';
    AVGRating = json['AVG_Rating'] != null ? json['AVG_Rating'] : '';
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

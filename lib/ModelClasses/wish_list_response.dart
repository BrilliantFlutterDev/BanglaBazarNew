class WishListResponse {
  WishListResponse({
    required this.status,
    required this.userWishList,
  });
  late final bool status;
  late final List<UserWishList> userWishList;

  WishListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userWishList = List.from(json['userWishList'])
        .map((e) => UserWishList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['userWishList'] = userWishList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class UserWishList {
  UserWishList({
    required this.ProductID,
    required this.Title,
    required this.Price,
    required this.Currency,
    required this.UserID,
    required this.Small,
    required this.Medium,
    required this.Large,
    required this.REVIEWCOUNT,
    required this.AVGRATING,
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

  UserWishList.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    Title = json['Title'];
    Price = json['Price'];
    Currency = json['Currency'];
    UserID = json['UserID'];
    Small = json['Small'];
    Medium = json['Medium'];
    Large = json['Large'];
    REVIEWCOUNT = json['REVIEW_COUNT'];
    AVGRATING = json['AVG_RATING'] != null ? json['AVG_RATING'] : '0';
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

part of 'product_bloc.dart';

abstract class ProductEvent {}

class GetStore extends ProductEvent {
  final String storeName;
  final String search;
  final int offset;
  GetStore(
      {required this.storeName, required this.offset, required this.search});
}

class GetRecentlyViewedItems extends ProductEvent {
  final int offset;
  GetRecentlyViewedItems({required this.offset});
}

class GetWishList extends ProductEvent {
  GetWishList();
}

class GetTrendingForYouItems extends ProductEvent {
  final int offset;
  final String country;
  final String search;
  GetTrendingForYouItems(
      {required this.offset, required this.country, required this.search});
}

class GetTopRatedItems extends ProductEvent {
  final int offset;
  final String country;
  final String search;
  GetTopRatedItems(
      {required this.offset, required this.country, required this.search});
}

class GetCategories extends ProductEvent {
  GetCategories();
}

class GetGeoLocation extends ProductEvent {
  GetGeoLocation();
}

class GetSubCategoriesProducts extends ProductEvent {
  final int id;
  GetSubCategoriesProducts({required this.id});
}

class GetProductDetails extends ProductEvent {
  final int id;
  GetProductDetails({required this.id});
}

class GetVendorAllowedCountries extends ProductEvent {
  GetVendorAllowedCountries();
}

class AddClickToAProduct extends ProductEvent {
  final int id;
  String? uniqueNumber;
  AddClickToAProduct({required this.id, this.uniqueNumber});
}

class DeleteCartLocalProduct extends ProductEvent {
  String? uniqueNumber;
  DeleteCartLocalProduct({this.uniqueNumber});
}

class GetLocalUserProductsClickData extends ProductEvent {
  GetLocalUserProductsClickData();
}

class GetHomePageProducts extends ProductEvent {
  final int id;
  final String country;
  GetHomePageProducts({required this.country, required this.id});
}

class Search extends ProductEvent {
  final int searchType;
  final int limit;
  final int offset;

  final String search;
  Search({
    required this.searchType,
    required this.limit,
    required this.offset,
    required this.search,
  });
}

class AddToWishList extends ProductEvent {
  final int productId;
  final int variantId;

  AddToWishList({
    required this.productId,
    required this.variantId,
  });
}

class AddToCart extends ProductEvent {
  final AddToCartModel addToCartModel;
  ProductDetailsResponse? productDetailsResponse;
  final double productPrice;
  AddToCart({
    required this.addToCartModel,
    this.productDetailsResponse,
    required this.productPrice,
  });
}

class RemoveFromWishList extends ProductEvent {
  final int productId;

  RemoveFromWishList({
    required this.productId,
  });
}

class GetLocalCartDetails extends ProductEvent {
  GetLocalCartDetails();
}

class GetLocalCartCombinationDetails extends ProductEvent {
  GetLocalCartCombinationDetails();
}

class AddUserReview extends ProductEvent {
  final int productID;
  final int rating;
  final String review;
  AddUserReview({
    required this.productID,
    required this.rating,
    required this.review,
  });
}

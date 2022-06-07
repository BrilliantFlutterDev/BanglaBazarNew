part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class LoadingState extends ProductState {}

class ErrorState extends ProductState {
  final String error;
  ErrorState({required this.error});
}

class CartDetailsLocalDBState extends ProductState {
  final RequestUserCartProducts requestUserCartProducts;
  CartDetailsLocalDBState({required this.requestUserCartProducts});
}

class CartDetailsState extends ProductState {
  final cart_details.CartDetailsResponse cartDetailsResponse;
  CartDetailsState({required this.cartDetailsResponse});
}

class CartCombinationDetailsLocalDBState extends ProductState {
  final RequestUserCartProductsCombinations requestUserCartProductsCombinations;
  CartCombinationDetailsLocalDBState(
      {required this.requestUserCartProductsCombinations});
}

class GetLocalUserProductsClickDataState extends ProductState {
  final RequestUserProductClicksData localUserClicksResponse;
  GetLocalUserProductsClickDataState({required this.localUserClicksResponse});
}

class ProductClickAddedToLocalDBState extends ProductState {
  ProductClickAddedToLocalDBState();
}

class InternetErrorState extends ProductState {
  final String error;
  InternetErrorState({required this.error});
}

class StoreData extends ProductState {
  final StoreResponse storeResponse;
  StoreData({required this.storeResponse});
}

class RecentlyViewedItemsDataFetched extends ProductState {
  final RecentlyViewedItemsResponse recentlyViewedItemsResponse;
  RecentlyViewedItemsDataFetched({required this.recentlyViewedItemsResponse});
}

class WishListDataFetched extends ProductState {
  final WishListResponse wishListResponse;
  WishListDataFetched({required this.wishListResponse});
}

class TrendingForyouDataFetched extends ProductState {
  final TrendingForYouResponse trendingForYouResponse;
  TrendingForyouDataFetched({required this.trendingForYouResponse});
}

class TopRatedDataFetched extends ProductState {
  final TopRatedProductsResponse topRatedProductsResponse;
  TopRatedDataFetched({required this.topRatedProductsResponse});
}

class SubCategoriesProductFetched extends ProductState {
  final SubCategoriesResponse subCategoriesResponse;
  SubCategoriesProductFetched({required this.subCategoriesResponse});
}

class ProductDetailsFetched extends ProductState {
  final ProductDetailsResponse productDetailsResponse;
  ProductDetailsFetched({required this.productDetailsResponse});
}

class ClickAddedToProduct extends ProductState {
  final AddaClickofProductResponse addaClickofProductResponse;
  ClickAddedToProduct({required this.addaClickofProductResponse});
}

class HomePageProductsFetched extends ProductState {
  final HomePageApiResponse homePageApiResponse;
  HomePageProductsFetched({required this.homePageApiResponse});
}

class SearchResultFetched extends ProductState {
  final SearchResponse searchResponse;
  SearchResultFetched({required this.searchResponse});
}

class AddedInWishList extends ProductState {
  final AddToWishListResponse addToWishListResponse;
  AddedInWishList({required this.addToWishListResponse});
}

class AddedToCart extends ProductState {
  final AddToCartResponse addToCartResponse;
  AddedToCart({required this.addToCartResponse});
}

class ReviewAdded extends ProductState {
  final AddReviewResponse addReviewResponse;
  ReviewAdded({required this.addReviewResponse});
}

class CategoriesData extends ProductState {
  final CategoriesAndSubcategoriesResponse categoriesAndSubcategoriesResponse;
  CategoriesData({required this.categoriesAndSubcategoriesResponse});
}

class GeoLocationData extends ProductState {
  final GeoLocationResponse geoLocationResponse;
  GeoLocationData({required this.geoLocationResponse});
}

class VendorAllowedCountries extends ProductState {
  final AllowedCountriesResponse allowedCountriesResponse;
  VendorAllowedCountries({required this.allowedCountriesResponse});
}

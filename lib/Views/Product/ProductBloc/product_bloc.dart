import 'dart:async';
import 'dart:convert';

import 'package:bangla_bazar/Helper/db_helper.dart';
import 'package:bangla_bazar/ModelClasses/add_a_click_of_product_response.dart';
import 'package:bangla_bazar/ModelClasses/add_review_response.dart';
import 'package:bangla_bazar/ModelClasses/add_to_cart_model.dart';
import 'package:bangla_bazar/ModelClasses/add_to_cart_response.dart';
import 'package:bangla_bazar/ModelClasses/add_to_wish_list_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_countries_list_response.dart';
import 'package:bangla_bazar/ModelClasses/cart_details_response.dart'
    as cart_details;
import 'package:bangla_bazar/ModelClasses/categories_subcategories_response.dart';
import 'package:bangla_bazar/ModelClasses/geo_location_response.dart';
import 'package:bangla_bazar/ModelClasses/home_page_api_reponse.dart';
import 'package:bangla_bazar/ModelClasses/product_details_response.dart';
import 'package:bangla_bazar/ModelClasses/recently_viewed_reponse.dart';
import 'package:bangla_bazar/ModelClasses/search_response.dart';
import 'package:bangla_bazar/ModelClasses/store_response.dart';
import 'package:bangla_bazar/ModelClasses/sub_categories_response.dart';
import 'package:bangla_bazar/ModelClasses/top_rated_product_response.dart';
import 'package:bangla_bazar/ModelClasses/trending_for_you_response.dart';
import 'package:bangla_bazar/ModelClasses/wish_list_response.dart';

import 'package:bangla_bazar/Repository/repository.dart';
import 'package:bangla_bazar/Utils/add_to_cart_local_db.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/common_functions.dart';
import 'package:bangla_bazar/Utils/user_click_local_db.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());
  final dbHelper = DatabaseHelper.instance;

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is GetStore) {
      yield LoadingState();
      if (event.storeName.isEmpty) {
        yield ErrorState(error: '');
      } else {
        var isInternetConnected = await checkInternetConnectivity();
        if (isInternetConnected == false) {
          yield InternetErrorState(error: 'Internet not connected');
        } else {
          try {
            dynamic response = await Repository().getStore(
                storeName: event.storeName,
                offset: event.offset,
                search: event.search);
            print('|||||||||||');
            print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              StoreResponse storeResponse =
                  StoreResponse.fromJson(jsonDecode(response.toString()));
              print('||||||||||12');

              yield StoreData(storeResponse: storeResponse);
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'Error');
          }
        }
      }
    } else if (event is GetRecentlyViewedItems) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getRecentlyViewed(
            offset: event.offset,
          );
          print('|||||||||||');
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            RecentlyViewedItemsResponse recentlyViewedItemsResponse =
                RecentlyViewedItemsResponse.fromJson(
                    jsonDecode(response.toString()));

            yield RecentlyViewedItemsDataFetched(
                recentlyViewedItemsResponse: recentlyViewedItemsResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Error');
        }
      }
    } else if (event is GetWishList) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getWishList();
          print('|||||||||||');
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            WishListResponse wishListResponse =
                WishListResponse.fromJson(jsonDecode(response.toString()));

            yield WishListDataFetched(wishListResponse: wishListResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Error');
        }
      }
    } else if (event is GetTrendingForYouItems) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getTrendingForYou(
            offset: event.offset,
            search: event.search,
            country: event.country,
          );
          print('|||||||||||');
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            TrendingForYouResponse trendingForYouResponse =
                TrendingForYouResponse.fromJson(
                    jsonDecode(response.toString()));

            yield TrendingForyouDataFetched(
                trendingForYouResponse: trendingForYouResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Error');
        }
      }
    } else if (event is GetTopRatedItems) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getTopRated(
            offset: event.offset,
            search: event.search,
            country: event.country,
          );
          print('|||||||||||');
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            TopRatedProductsResponse topRatedProductsResponse =
                TopRatedProductsResponse.fromJson(
                    jsonDecode(response.toString()));

            yield TopRatedDataFetched(
                topRatedProductsResponse: topRatedProductsResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Error');
        }
      }
    } else if (event is GetCategories) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          print('|||||||||||');
          dynamic response = await Repository().getCategories();

          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            CategoriesAndSubcategoriesResponse categories =
                CategoriesAndSubcategoriesResponse.fromJson(
                    jsonDecode(response.toString()));
            print('||||||||||13');

            yield CategoriesData(
                categoriesAndSubcategoriesResponse: categories);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Error');
        }
      }
    } else if (event is GetGeoLocation) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getGeoLocation();

          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            GeoLocationResponse geoLocationResponse =
                GeoLocationResponse.fromJson(jsonDecode(response.toString()));

            AppGlobal.currentCountry = geoLocationResponse.countryName!;
            yield GeoLocationData(geoLocationResponse: geoLocationResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Error');
        }
      }
    } else if (event is GetSubCategoriesProducts) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getSubCategoriesProducts(
            id: event.id,
          );
          print('|||||||||||');
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            SubCategoriesResponse subCategoriesResponse =
                SubCategoriesResponse.fromJson(jsonDecode(response.toString()));
            print('||||||||||13');

            yield SubCategoriesProductFetched(
                subCategoriesResponse: subCategoriesResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'No product found');
        }
      }
    } else if (event is GetProductDetails) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getProductDetails(
            id: event.id,
          );
          print('|||||||||||');
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            ProductDetailsResponse productDetailsResponse =
                ProductDetailsResponse.fromJson(
                    jsonDecode(response.toString()));
            print('||||||||||13');

            yield ProductDetailsFetched(
                productDetailsResponse: productDetailsResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'No product found');
        }
      }
    } else if (event is GetLocalUserProductsClickData) {
      yield LoadingState();

      try {
        var data = await dbHelper.queryAllUserProductClicks();
        RequestUserProductClicksData localUserClicksResponse =
            RequestUserProductClicksData.fromJson(data);

        yield GetLocalUserProductsClickDataState(
            localUserClicksResponse: localUserClicksResponse);
      } catch (e) {
        yield ErrorState(error: 'No data found!');
        print(e.toString());
      }
    } else if (event is GetVendorAllowedCountries) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getVendorAllowedCountries();
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AllowedCountriesResponse allowedCountriesResponse =
                AllowedCountriesResponse.fromJson(
                    jsonDecode(response.toString()));

            if (allowedCountriesResponse.status == true) {
              yield VendorAllowedCountries(
                  allowedCountriesResponse: allowedCountriesResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is AddClickToAProduct) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        if (AppGlobal.userID == -1) {
          String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
          UserProductClickLocalDB userProductClickLocalDB =
              UserProductClickLocalDB(
                  productID: event.id, uniqueNumber: timeStamp);
          print(
              '>>>>>>>>>Saving data to UserClick to Local DB ${userProductClickLocalDB.productID}');
          await dbHelper
              .insertProductUserClick(userProductClickLocalDB.toJson());
          yield ProductClickAddedToLocalDBState();
        } else {
          try {
            dynamic response = await Repository().addClickToAProduct(
              id: event.id,
            );

            print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              if (event.uniqueNumber != null) {
                var deleteClick =
                    await dbHelper.deleteProductUserClicks(event.uniqueNumber!);
              }
              AddaClickofProductResponse addaClickofProductResponse =
                  AddaClickofProductResponse.fromJson(
                      jsonDecode(response.toString()));

              yield ClickAddedToProduct(
                  addaClickofProductResponse: addaClickofProductResponse);
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'No product found');
          }
        }
      }
    } else if (event is GetLocalCartDetails) {
      yield LoadingState();

      try {
        var data = await dbHelper.queryAllCartProduct();
        print(data);
        RequestUserCartProducts requestUserCartProducts =
            RequestUserCartProducts.fromJson(data);

        yield CartDetailsLocalDBState(
            requestUserCartProducts: requestUserCartProducts);
      } catch (e) {
        yield ErrorState(error: 'No data found!');
        print(e.toString());
      }
    } else if (event is GetLocalCartCombinationDetails) {
      yield LoadingState();

      try {
        var data = await dbHelper.queryAllCartProductCombination();
        print(data);
        RequestUserCartProductsCombinations
            requestUserCartProductsCombinations =
            RequestUserCartProductsCombinations.fromJson(data);

        yield CartCombinationDetailsLocalDBState(
            requestUserCartProductsCombinations:
                requestUserCartProductsCombinations);
      } catch (e) {
        yield ErrorState(error: 'No data found!');
        print(e.toString());
      }
    } else if (event is GetHomePageProducts) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .getHomePageProducts(id: event.id, country: event.country);

          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            HomePageApiResponse homePageApiResponse =
                HomePageApiResponse.fromJson(jsonDecode(response.toString()));
            print('>>>>>>>>>>13');

            yield HomePageProductsFetched(
                homePageApiResponse: homePageApiResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'No product found');
        }
      }
    } else if (event is Search) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().search(
              searchType: event.searchType,
              offset: event.offset,
              limit: event.limit,
              search: event.search);
          print('|||||||||||');
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            SearchResponse searchResponse =
                SearchResponse.fromJson(jsonDecode(response.toString()));
            print('||||||||||13');

            yield SearchResultFetched(searchResponse: searchResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'No product found');
        }
      }
    } else if (event is AddToWishList) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().addToWishList(
            productId: event.productId,
            variantId: event.variantId,
          );
          print('|||||||||||');
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            AddToWishListResponse addToWishListResponse =
                AddToWishListResponse.fromJson(jsonDecode(response.toString()));
            print('||||||||||13');

            yield AddedInWishList(addToWishListResponse: addToWishListResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'No product found');
        }
      }
    } else if (event is AddToCart) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        if (AppGlobal.userID == -1) {
          String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
          ProductCartList productCartList = ProductCartList(
              ProductID: event.productDetailsResponse!.productDetail.ProductID,
              Title: event.productDetailsResponse!.productDetail.Title,
              CompanyName:
                  event.productDetailsResponse!.productDetail.StoreName,
              VendorID: event.productDetailsResponse!.productDetail.VendorID,
              City: event.productDetailsResponse!.productDetail.ProductCity,
              Native: event.productDetailsResponse!.productDetail.CityNative,
              BasePrice: event.productPrice.toString(),
              Currency: event.productDetailsResponse!.productDetail.Currency,
              UserID: -1,
              TotalQuantity:
                  event.addToCartModel.productDetail![0].quantity.toString(),
              Small: event.productDetailsResponse!.MainImage,
              Medium: event.productDetailsResponse!.MainImage,
              Large: event.productDetailsResponse!.MainImage,
              MainImage: event.productDetailsResponse!.MainImage,
              REVIEWCOUNT: event.productDetailsResponse!
                  .productAverageRatingAndReviews.TotalReviews,
              AllowStorePickup:
                  event.productDetailsResponse!.productDetail.AllowStorePickup,
              ProductCityID: event.productDetailsResponse!.product[0].CityID,
              ProductCountry:
                  event.productDetailsResponse!.product[0].CountryID,
              uniqueNumber: timeStamp);

          await dbHelper.insertCartProduct(productCartList.toJson());
          for (int i = 0; i < event.addToCartModel.productDetail!.length; i++) {
            for (int j = 0;
                j <
                    event.addToCartModel.productDetail![i]
                        .productVariantCombinationDetail!.length;
                j++) {
              ProductCombinations productCombinations = ProductCombinations(
                  ProductID:
                      event.productDetailsResponse!.productDetail.ProductID,
                  ProductVariantCombinationID: event
                      .addToCartModel
                      .productDetail![i]
                      .productVariantCombinationDetail![j]
                      .productVariantCombinationID,
                  uniqueNumber: timeStamp);
              await dbHelper
                  .insertCartProductCombination(productCombinations.toJson());
              print('Combination Added in local DB');
            }
          }

          yield ErrorState(error: 'Product added to local cart');
        } else {
          try {
            dynamic response = await Repository()
                .addToCart(addToCartModel: event.addToCartModel);

            print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              print('||||||||||12');
              AddToCartResponse addToCartResponse =
                  AddToCartResponse.fromJson(jsonDecode(response.toString()));
              print('||||||||||13');
              if (addToCartResponse.status == true) {
                var deleteProducts = dbHelper.deleteAllCartProducts();
                var deleteCombination =
                    dbHelper.deleteAllCartProductsCombination();
              }

              yield AddedToCart(addToCartResponse: addToCartResponse);
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'No product found');
          }
        }
      }
    } else if (event is RemoveFromWishList) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().removeFromWishList(
            productId: event.productId,
          );
          print('|||||||||||');
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            AddToWishListResponse addToWishListResponse =
                AddToWishListResponse.fromJson(jsonDecode(response.toString()));
            print('||||||||||13');

            yield AddedInWishList(addToWishListResponse: addToWishListResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'No product found');
        }
      }
    } else if (event is AddUserReview) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().addUserReview(
            productID: event.productID,
            rating: event.rating,
            review: event.review,
          );
          print('|||||||||||');
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            AddReviewResponse addReviewResponse =
                AddReviewResponse.fromJson(jsonDecode(response.toString()));
            print('||||||||||13');

            yield ReviewAdded(addReviewResponse: addReviewResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'No product found');
        }
      }
    } else if (event is GetCartDetails) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getCartDetails();
          //print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            cart_details.CartDetailsResponse cartDetailsResponse =
                cart_details.CartDetailsResponse.fromJson(
                    jsonDecode(response.toString()));
            print('||||||||||12');
            for (int i = 0;
                i < cartDetailsResponse.productCartList.length;
                i++) {
              cartDetailsResponse
                      .productCartList[i].calculateTotalProductPrice =
                  double.parse(cartDetailsResponse.productCartList[i].Price!);

              for (int j = 0;
                  j <
                      cartDetailsResponse
                          .productCartList[i].productCombinations.length;
                  j++) {
                cartDetailsResponse.productCartList[i]
                    .calculateTotalProductPrice = cartDetailsResponse
                        .productCartList[i].calculateTotalProductPrice! +
                    double.parse(cartDetailsResponse.productCartList[i]
                        .productCombinations[j].ProductCombinationPrice);
                String productTotalPrice = cartDetailsResponse
                    .productCartList[i].calculateTotalProductPrice!
                    .toStringAsFixed(2);
                cartDetailsResponse
                        .productCartList[i].calculateTotalProductPrice =
                    double.parse(productTotalPrice);
              }
              cartDetailsResponse.productCartList[i]
                  .calculateTotalProductPrice = cartDetailsResponse
                      .productCartList[i].calculateTotalProductPrice! *
                  cartDetailsResponse.productCartList[i].TotalQuantity!;
              cartDetailsResponse.cartTotalPrice =
                  cartDetailsResponse.cartTotalPrice +
                      cartDetailsResponse
                          .productCartList[i].calculateTotalProductPrice!;

              String cartTotalPrice =
                  cartDetailsResponse.cartTotalPrice.toStringAsFixed(2);
              cartDetailsResponse.cartTotalPrice = double.parse(cartTotalPrice);

              ///Calculating tax

              cartDetailsResponse.productCartList[i].perProductTax =
                  (double.parse(
                              cartDetailsResponse.productCartList[i].TaxRate!) /
                          100) *
                      cartDetailsResponse
                          .productCartList[i].calculateTotalProductPrice!;

              cartDetailsResponse.productCartList[i].perProductTax =
                  double.parse(cartDetailsResponse
                      .productCartList[i].perProductTax!
                      .toStringAsFixed(2));

              cartDetailsResponse.totalTax = cartDetailsResponse.totalTax +
                  cartDetailsResponse.productCartList[i].perProductTax!;

              print(
                  'This Product Tax  : ${cartDetailsResponse.productCartList[i].perProductTax!}');
            }

            print('Total Tax  : ${cartDetailsResponse.totalTax}');

            yield CartDetailsState(cartDetailsResponse: cartDetailsResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid credentials');
        }
      }
    }
  }
}

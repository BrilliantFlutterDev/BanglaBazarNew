import 'dart:collection';
import 'dart:io';

import 'package:bangla_bazar/ModelClasses/add_to_cart_model.dart';
import 'package:bangla_bazar/Providers/base_provider.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/web_services.dart';

class ProductProvider extends BaseProvider {
  static Future getStore({
    required String storeName,
    required int offset,
    required String search,
  }) async {
    try {
      String url =
          '${AppGlobal.baseURL}store-management/buisness-detail/$storeName';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('limit', () => 5);
      params.putIfAbsent('offset', () => offset);
      params.putIfAbsent('search', () => search);
      params.putIfAbsent('sort', () => 'ASC');

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getRecentlyViewed({
    required int offset,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}landing-page/recenltyViewedProducts';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('limit', () => 10);
      params.putIfAbsent('offset', () => offset);
      params.putIfAbsent('UserID', () => AppGlobal.userID);

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getWishList() async {
    try {
      String url = '${AppGlobal.baseURL}wish-list/viewUserWishList';

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiGetAuthenticationBearerToken(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getTrendingForYou({
    required int offset,
    required String search,
    required String country,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}landing-page/trendingForyouProducts';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('limit', () => 20);
      params.putIfAbsent('offset', () => offset);
      params.putIfAbsent('Country', () => AppGlobal.currentCountry);
      params.putIfAbsent('search', () => search);
      params.putIfAbsent('sort', () => 'ASC');

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getTopRated({
    required int offset,
    required String search,
    required String country,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}landing-page/topRatedProducts';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('limit', () => 20);
      params.putIfAbsent('offset', () => offset);
      params.putIfAbsent('Country', () => AppGlobal.currentCountry);
      params.putIfAbsent('search', () => search);
      params.putIfAbsent('sort', () => 'ASC');

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getSubCategoriesProducts({
    required int id,
  }) async {
    try {
      String url =
          '${AppGlobal.baseURL}product/get-productDetailsBySubCategory/$id';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('limit', () => 6);
      params.putIfAbsent('offset', () => 0);
      params.putIfAbsent('sort', () => 'ASC');

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getProductDetails({
    required int id,
  }) async {
    try {
      String url =
          '${AppGlobal.baseURL}product/get-productAllDetails/$id/${AppGlobal.userID}';
      print(url);

      dynamic response = await WebServices.apiGet(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future addClickToAProduct({
    required int id,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}product/addProductClicks';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('ProductID', () => [id]);
      params.putIfAbsent('UserID', () => AppGlobal.userID);
      params.putIfAbsent('SessionID', () => [11]);
      params.putIfAbsent('Country', () => [AppGlobal.currentCountry]);
      params.putIfAbsent('IPAddress', () => [AppGlobal.ipAddress]);
      print(url);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getHomePageProducts({
    required int id,
    required String country,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}landing-page/showProductsViews';
      print(url);
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('UserID', () => id);
      params.putIfAbsent('Country', () => AppGlobal.currentCountry);

      dynamic response =
          await WebServices.apiPostAuthenticationBearerToken(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future search({
    required int searchType,
    required int limit,
    required int offset,
    required String search,
  }) async {
    try {
      String url =
          '${AppGlobal.baseURL}product/get-gloabalProductsSearchByCategory';
      print(url);
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('CategoryID', () => '');
      params.putIfAbsent('offset', () => offset);
      params.putIfAbsent('limit', () => limit);
      params.putIfAbsent('searchType', () => searchType);
      params.putIfAbsent('search', () => search);
      print(params);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future addToWishList({
    required int productId,
    required int variantId,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}wish-list/addUserWishList';
      print(url);
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('ProductID', () => productId);
      params.putIfAbsent('ProductVariantCombinationID', () => variantId);
      print(params);

      dynamic response =
          await WebServices.apiPostAuthenticationBearerToken(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future addToCart({
    required AddToCartModel addToCartModel,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}wish-list/addCart';
      print(url);

      dynamic response = await WebServices.apiPostToJson(url, addToCartModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future removeFromWishList({
    required int productId,
  }) async {
    try {
      String url =
          '${AppGlobal.baseURL}wish-list/deleteUserWishList/${productId}';
      print(url);

      dynamic response =
          await WebServices.apiDeleteAuthenticationBearerToken(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future addUserReview({
    required int productID,
    required int rating,
    required String review,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}product/addProductRating';
      print(url);
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('UserID', () => AppGlobal.userID);
      params.putIfAbsent('ProductID', () => productID);
      params.putIfAbsent('Review', () => review);
      params.putIfAbsent('Rating', () => rating);
      params.putIfAbsent('PurchaseVerified', () => 'Y');
      print(params);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getCategories() async {
    try {
      String url =
          '${AppGlobal.baseURL}category/get-allCategoriesAndSubCategories';
      print(url);

      dynamic response = await WebServices.apiGet(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getGeoLocation() async {
    try {
      String url = 'https://geolocation-db.com/json/';
      print(url);

      dynamic response = await WebServices.apiGet(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

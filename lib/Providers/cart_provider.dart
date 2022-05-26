import 'dart:collection';
import 'dart:io';

import 'package:bangla_bazar/ModelClasses/add_process_order_model.dart';
import 'package:bangla_bazar/ModelClasses/add_user_payment_model.dart';
import 'package:bangla_bazar/ModelClasses/auth_net_payment_model.dart';

import 'package:bangla_bazar/ModelClasses/cod_init_model.dart';
import 'package:bangla_bazar/ModelClasses/delivery_products_check_model.dart';
import 'package:bangla_bazar/ModelClasses/remove_from_cart_model.dart';
import 'package:bangla_bazar/ModelClasses/ssl_get_detail_model.dart';
import 'package:bangla_bazar/ModelClasses/sslcommerce_init_model.dart';
import 'package:bangla_bazar/ModelClasses/stripe_trans_init_model.dart';
import 'package:bangla_bazar/ModelClasses/update_cart_model.dart';
import 'package:bangla_bazar/Providers/base_provider.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/web_services.dart';
import 'package:bangla_bazar/Views/Cart/CartBloc/cart_bloc.dart';
import 'package:bangla_bazar/ModelClasses/add_to_cart_model.dart' as cart;

class CartProvider extends BaseProvider {
  static Future getCartDetails() async {
    try {
      String url = '${AppGlobal.baseURL}wish-list/viewCart-m';
      print(url);

      dynamic response = await WebServices.apiGetAuthenticationBearerToken(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getUserAddressHistory() async {
    try {
      String url = '${AppGlobal.baseURL}payment/user-history';
      print(url);

      dynamic response = await WebServices.apiGetAuthenticationBearerToken(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future transectioninit(
      {required SSLCommerceTransInitModel transInitModel}) async {
    try {
      String url = '${AppGlobal.baseURL}sslCommerz/init';
      print(url);

      // Map params = HashMap<String, dynamic>();
      //
      // params.putIfAbsent('CategoryID', () => '');
      // params.putIfAbsent('offset', () => offset);
      // params.putIfAbsent('limit', () => limit);
      // params.putIfAbsent('searchType', () => searchType);
      // params.putIfAbsent('search', () => search);
      // print(params);

      dynamic response = await WebServices.apiPostToJson(url, transInitModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future transectionInitStripe(
      {required StripeTransInitModel stripeTransInitModel}) async {
    try {
      String url = '${AppGlobal.baseURL}stripe/init';
      print(url);

      // Map params = HashMap<String, dynamic>();
      //
      // params.putIfAbsent('CategoryID', () => '');
      // params.putIfAbsent('offset', () => offset);
      // params.putIfAbsent('limit', () => limit);
      // params.putIfAbsent('searchType', () => searchType);
      // params.putIfAbsent('search', () => search);
      // print(params);

      dynamic response =
          await WebServices.apiPostToJson(url, stripeTransInitModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future authNetTransectionInit(
      {required AuthorizedNetPaymentModel transInitModel}) async {
    try {
      String url = '${AppGlobal.baseURL}autorizeNet/init';
      print(url);

      // Map params = HashMap<String, dynamic>();
      //
      // params.putIfAbsent('CategoryID', () => '');
      // params.putIfAbsent('offset', () => offset);
      // params.putIfAbsent('limit', () => limit);
      // params.putIfAbsent('searchType', () => searchType);
      // params.putIfAbsent('search', () => search);
      // print(params);

      dynamic response = await WebServices.apiPostToJson(url, transInitModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future cashOnDeliveryInit(
      {required CODInitModel cashOnDeliveryInit}) async {
    try {
      String url = '${AppGlobal.baseURL}payment/processPayment';
      print(url);

      // Map params = HashMap<String, dynamic>();
      //
      // params.putIfAbsent('CategoryID', () => '');
      // params.putIfAbsent('offset', () => offset);
      // params.putIfAbsent('limit', () => limit);
      // params.putIfAbsent('searchType', () => searchType);
      // params.putIfAbsent('search', () => search);
      // print(params);

      dynamic response =
          await WebServices.apiPostToJson(url, cashOnDeliveryInit);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future addUserPayment(
      {required AddUserPaymentModel addUserPaymentModel}) async {
    try {
      String url = '${AppGlobal.baseURL}payment/add-userPayment';
      print(url);

      // Map params = HashMap<String, dynamic>();
      //
      // params.putIfAbsent('CategoryID', () => '');
      // params.putIfAbsent('offset', () => offset);
      // params.putIfAbsent('limit', () => limit);
      // params.putIfAbsent('searchType', () => searchType);
      // params.putIfAbsent('search', () => search);
      // print(params);

      dynamic response =
          await WebServices.apiPostToJson(url, addUserPaymentModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future addProcessOrder(
      {required AddProcessOrderModel addProcessOrderModel}) async {
    try {
      String url = '${AppGlobal.baseURL}payment/add-processOrder';
      print(url);

      // Map params = HashMap<String, dynamic>();
      //
      // params.putIfAbsent('CategoryID', () => '');
      // params.putIfAbsent('offset', () => offset);
      // params.putIfAbsent('limit', () => limit);
      // params.putIfAbsent('searchType', () => searchType);
      // params.putIfAbsent('search', () => search);
      // print(params);

      dynamic response =
          await WebServices.apiPostToJson(url, addProcessOrderModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getShippingStatus(
      {required DeliveryProductsCheckModel deliveryProductsCheckModel}) async {
    try {
      String url = '${AppGlobal.baseURL}payment/shipping-status';
      print(url);

      // Map params = HashMap<String, dynamic>();
      //
      // params.putIfAbsent('CategoryID', () => '');
      // params.putIfAbsent('offset', () => offset);
      // params.putIfAbsent('limit', () => limit);
      // params.putIfAbsent('searchType', () => searchType);
      // params.putIfAbsent('search', () => search);
      // print(params);

      dynamic response = await WebServices.apiPostToJsonWithoutBearerToken(
          url, deliveryProductsCheckModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getTransectionDetails({
    required SSLGetDetailsModel sslGetDetailsModel,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}sslCommerz/get-detail';

      dynamic response = await WebServices.apiPostToJsonWithoutBearerToken(
          url, sslGetDetailsModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future updatePaymentStatus({
    required String id,
    required String status,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}payment/clear-payment/$id/$status';

      dynamic response = await WebServices.apiGet(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getInAppNotifications() async {
    try {
      String url = '${AppGlobal.baseURL}admin/notifications';

      dynamic response = await WebServices.apiGetAuthenticationBearerToken(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future removeProductFromCart({
    required String id,
    required RemoveFromCartModel removeFromCartModel,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}wish-list/removeCart/$id';

      dynamic response =
          await WebServices.apiPostToJson(url, removeFromCartModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future updateCart({
    required UpdateCartModel productDetail,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}wish-list/updateCart';
      print(url);

      dynamic response = await WebServices.apiPutToJson(url, productDetail);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

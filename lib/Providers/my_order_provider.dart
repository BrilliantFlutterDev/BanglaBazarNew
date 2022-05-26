import 'dart:collection';
import 'dart:io';

import 'package:bangla_bazar/ModelClasses/dashboard_model.dart';
import 'package:bangla_bazar/ModelClasses/driver_orders_by_status_model.dart';
import 'package:bangla_bazar/ModelClasses/order_return_model.dart';
import 'package:bangla_bazar/ModelClasses/order_status_change_model.dart';
import 'package:bangla_bazar/ModelClasses/user_refund_form_model.dart';
import 'package:bangla_bazar/Providers/base_provider.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/web_services.dart';
import 'package:bangla_bazar/Views/MyOrders/MyOrdersBloc/myorder_bloc.dart';

class MyOrdersProvider extends BaseProvider {
  static Future getMyOrders() async {
    try {
      String url = '${AppGlobal.baseURL}payment/order-details';
      print(url);

      dynamic response = await WebServices.apiGetAuthenticationBearerToken(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getOrderDetails({required String orderNumber}) async {
    try {
      String url = '${AppGlobal.baseURL}admin/orderDetails/$orderNumber';
      print(url);

      dynamic response = await WebServices.apiGet(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future returnOrder(
      {required OrderReturnModel orderReturnModel}) async {
    try {
      String url = '${AppGlobal.baseURL}deliveryDriver/markReturnStatus';
      print(url);

      dynamic response = await WebServices.apiPostToJson(url, orderReturnModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future userReturnOrder(
      {required UserRefundFormModel userRefundFormModel}) async {
    try {
      String url = '${AppGlobal.baseURL}payment/refund-form';
      print(url);

      dynamic response =
          await WebServices.apiPostToJson(url, userRefundFormModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future orderStatusChange(
      {required OrderStatusChangeModel orderStatusChangeModel}) async {
    try {
      String url = '${AppGlobal.baseURL}deliveryDriver/changeDriverStatus';
      print(url);

      dynamic response =
          await WebServices.apiPostToJson(url, orderStatusChangeModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future dashBoard({required DashBoardModel dashBoardModel}) async {
    try {
      String url = '${AppGlobal.baseURL}deliveryDriver/driver-dashboard';
      print(url);

      dynamic response = await WebServices.apiPostToJson(url, dashBoardModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getDriversOrders(
      {required int offset, required String status}) async {
    try {
      String url = '${AppGlobal.baseURL}deliveryDriver/getDriverOrders';
      print(url);
      DriverOrdersByStatusModel driverOrdersByStatusModel =
          DriverOrdersByStatusModel(
              status: status,
              offset: offset.toString(),
              DeliveryDriverID: AppGlobal.deliveryDriverID.toString(),
              sort: 'ASC',
              limit: '20');
      dynamic response =
          await WebServices.apiPostToJson(url, driverOrdersByStatusModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

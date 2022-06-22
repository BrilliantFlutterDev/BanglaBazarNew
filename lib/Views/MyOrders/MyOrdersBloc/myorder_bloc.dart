import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bangla_bazar/ModelClasses/dashboard_model.dart';
import 'package:bangla_bazar/ModelClasses/dashboard_response.dart';
import 'package:bangla_bazar/ModelClasses/get_driver_orders_by_status_response.dart';
import 'package:bangla_bazar/ModelClasses/get_order_details_response.dart';
import 'package:bangla_bazar/ModelClasses/order_details_response.dart';
import 'package:bangla_bazar/ModelClasses/order_return_model.dart';
import 'package:bangla_bazar/ModelClasses/order_status_change_model.dart';
import 'package:bangla_bazar/ModelClasses/order_status_change_response.dart';
import 'package:bangla_bazar/ModelClasses/sigin_model.dart';
import 'package:bangla_bazar/ModelClasses/user_refund_form_model.dart';

import 'package:bangla_bazar/Repository/repository.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/common_functions.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import 'package:meta/meta.dart';

part 'myorder_event.dart';
part 'myorder_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrdersState> {
  MyOrdersBloc() : super(MyOrdersInitial());

  @override
  Stream<MyOrdersState> mapEventToState(
    MyOrdersEvent event,
  ) async* {
    if (event is GetMyOrders) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .getMyOrders(offset: event.offset, search: event.search);
          //print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            OrderDetailsResponse orderDetailsResponse =
                OrderDetailsResponse.fromJson(jsonDecode(response.toString()));

            if (orderDetailsResponse.status == true) {
              for (int i = 0;
                  i < orderDetailsResponse.orderDetails.length;
                  i++) {
                orderDetailsResponse.orderDetails[i].OrderDate =
                    DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(
                            orderDetailsResponse.orderDetails[i].OrderDate))
                        .toString();

                for (int j = 0;
                    j <
                        orderDetailsResponse
                            .orderDetails[i].productDetail.length;
                    j++) {
                  orderDetailsResponse.orderDetails[i].productDetail[j]
                      .totalProductPrice = orderDetailsResponse
                          .orderDetails[i].productDetail[j].totalProductPrice +
                      double.parse(orderDetailsResponse
                          .orderDetails[i].productDetail[j].BasePrice);
                  orderDetailsResponse.orderDetails[i].totalOrderTax =
                      orderDetailsResponse.orderDetails[i].totalOrderTax +
                          double.parse(orderDetailsResponse.orderDetails[i]
                              .productDetail[j].ItemsEstimatedTax);
                  orderDetailsResponse.orderDetails[i].totalOrderShippingPrice =
                      orderDetailsResponse
                              .orderDetails[i].totalOrderShippingPrice +
                          double.parse(orderDetailsResponse.orderDetails[i]
                              .productDetail[j].ItemsShippingHandling);
                  orderDetailsResponse.orderDetails[i].totalOrderPrice =
                      orderDetailsResponse.orderDetails[i].totalOrderPrice +
                          double.parse(orderDetailsResponse
                              .orderDetails[i].productDetail[j].ItemsPrice);
                  for (int k = 0;
                      k <
                          orderDetailsResponse.orderDetails[i].productDetail[j]
                              .productCombinations.length;
                      k++) {
                    orderDetailsResponse.orderDetails[i].productDetail[j]
                        .totalProductPrice = orderDetailsResponse
                            .orderDetails[i]
                            .productDetail[j]
                            .totalProductPrice +
                        double.parse(orderDetailsResponse
                            .orderDetails[i]
                            .productDetail[j]
                            .productCombinations[k]
                            .ProductCombinationPrice);
                  }
                }
              }
              yield GetMyOrdersState(
                  orderDetailsResponse: orderDetailsResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid credentials');
        }
      }
    } else if (event is GetOrderDetails) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .getOrderDetails(orderNumber: event.orderNumber);
          //print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            GetOrderDetailsResponse getOrderDetailsResponse =
                GetOrderDetailsResponse.fromJson(
                    jsonDecode(response.toString()));

            print('||||||||||13');

            if (getOrderDetailsResponse.status == true) {
              getOrderDetailsResponse.orderDetails.OrderDate =
                  DateFormat('dd  MMM  yyyy')
                      .format(DateTime.parse(
                          getOrderDetailsResponse.orderDetails.OrderDate!))
                      .toString();
              for (int i = 0;
                  i < getOrderDetailsResponse.orderDetails.productDetail.length;
                  i++) {
                getOrderDetailsResponse
                        .orderDetails.productDetail[i].totalProductPrice =
                    double.parse(getOrderDetailsResponse
                        .orderDetails.productDetail[i].BasePrice);
                for (int j = 0;
                    j <
                        getOrderDetailsResponse.orderDetails.productDetail[i]
                            .productCombinations.length;
                    j++) {
                  getOrderDetailsResponse.orderDetails.productDetail[i]
                      .totalProductPrice = getOrderDetailsResponse
                          .orderDetails.productDetail[i].totalProductPrice +
                      double.parse(getOrderDetailsResponse
                          .orderDetails
                          .productDetail[i]
                          .productCombinations[j]
                          .ProductCombinationPrice);
                }
                getOrderDetailsResponse.orderDetails.totalOrderTax =
                    getOrderDetailsResponse.orderDetails.totalOrderTax +
                        double.parse(getOrderDetailsResponse
                            .orderDetails.productDetail[i].ItemsEstimatedTax);
                getOrderDetailsResponse.orderDetails.totalOrderShippingPrice =
                    getOrderDetailsResponse
                            .orderDetails.totalOrderShippingPrice +
                        double.parse(getOrderDetailsResponse.orderDetails
                            .productDetail[i].ItemsShippingHandling);
                getOrderDetailsResponse.orderDetails.totalOrderPrice =
                    getOrderDetailsResponse.orderDetails.totalOrderPrice +
                        double.parse(getOrderDetailsResponse
                            .orderDetails.productDetail[i].ItemsPrice);
              }
              yield GetOrderDetailsState(
                  getOrderDetailsResponse: getOrderDetailsResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid credentials');
        }
      }
    } else if (event is ReturnOrder) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .returnOrder(orderReturnModel: event.orderReturnModel);
          //print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            OrderStatusChangeResponse orderStatusChangeResponse =
                OrderStatusChangeResponse.fromJson(
                    jsonDecode(response.toString()));

            if (orderStatusChangeResponse.status == true) {
              yield OrderStatusChangeState(
                  orderStatusChangeResponse: orderStatusChangeResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid credentials');
        }
      }
    } else if (event is UserReturnOrder) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .userReturnOrder(userRefundFormModel: event.userRefundFormModel);
          //print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            OrderStatusChangeResponse orderStatusChangeResponse =
                OrderStatusChangeResponse.fromJson(
                    jsonDecode(response.toString()));

            if (orderStatusChangeResponse.status == true) {
              yield UserOrderReturnState(
                  orderStatusChangeResponse: orderStatusChangeResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid credentials');
        }
      }
    } else if (event is OrderStatusChange) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().orderStatusChange(
              orderStatusChangeModel: event.orderStatusChangeModel);
          //print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            OrderStatusChangeResponse orderStatusChangeResponse =
                OrderStatusChangeResponse.fromJson(
                    jsonDecode(response.toString()));

            if (orderStatusChangeResponse.status == true) {
              yield OrderStatusChangeState(
                  orderStatusChangeResponse: orderStatusChangeResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid credentials');
        }
      }
    } else if (event is OrderStatusChangePic) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().orderStatusChangePic(
              orderStatusChangeModel: event.orderStatusChangeModel,
              photo: event.selectedImage);

          if (response != null) {
            print('||||||||||12');
            OrderStatusChangeResponse orderStatusChangeResponse =
                OrderStatusChangeResponse.fromJson(
                    jsonDecode(response.toString()));

            if (orderStatusChangeResponse.status == true) {
              yield OrderStatusChangeState(
                  orderStatusChangeResponse: orderStatusChangeResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid credentials');
        }
      }
    } else if (event is DashBoard) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .dashBoard(dashBoardModel: event.dashBoardModel);
          //print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            DashBoardResponse dashBoardResponse =
                DashBoardResponse.fromJson(jsonDecode(response.toString()));

            if (dashBoardResponse.status == true) {
              yield DashBoardState(dashBoardResponse: dashBoardResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid credentials');
        }
      }
    } else if (event is GetDriversOrders) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .getDriversOrders(status: event.status, offset: event.offset);
          //print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            GetDriverOrdersByStatusResponse orderDetailsResponse =
                GetDriverOrdersByStatusResponse.fromJson(
                    jsonDecode(response.toString()));
            print('||||||||||222');

            if (orderDetailsResponse.status == true) {
              for (int i = 0;
                  i < orderDetailsResponse.orderDetails.length;
                  i++) {
                orderDetailsResponse.orderDetails[i].OrderDate =
                    DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(
                            orderDetailsResponse.orderDetails[i].OrderDate!))
                        .toString();

                for (int j = 0;
                    j <
                        orderDetailsResponse
                            .orderDetails[i].productDetail.length;
                    j++) {
                  orderDetailsResponse.orderDetails[i].productDetail[j]
                      .totalProductPrice = orderDetailsResponse
                          .orderDetails[i].productDetail[j].totalProductPrice +
                      double.parse(orderDetailsResponse
                          .orderDetails[i].productDetail[j].BasePrice);
                  orderDetailsResponse.orderDetails[i].totalOrderTax =
                      orderDetailsResponse.orderDetails[i].totalOrderTax +
                          double.parse(orderDetailsResponse.orderDetails[i]
                              .productDetail[j].ItemsEstimatedTax);
                  orderDetailsResponse.orderDetails[i].totalOrderShippingPrice =
                      orderDetailsResponse
                              .orderDetails[i].totalOrderShippingPrice +
                          double.parse(orderDetailsResponse.orderDetails[i]
                              .productDetail[j].ItemsShippingHandling);
                  orderDetailsResponse.orderDetails[i].totalOrderPrice =
                      orderDetailsResponse.orderDetails[i].totalOrderPrice +
                          double.parse(orderDetailsResponse
                              .orderDetails[i].productDetail[j].ItemsPrice);
                  for (int k = 0;
                      k <
                          orderDetailsResponse.orderDetails[i].productDetail[j]
                              .productCombinations.length;
                      k++) {
                    orderDetailsResponse.orderDetails[i].productDetail[j]
                        .totalProductPrice = orderDetailsResponse
                            .orderDetails[i]
                            .productDetail[j]
                            .totalProductPrice +
                        double.parse(orderDetailsResponse
                            .orderDetails[i]
                            .productDetail[j]
                            .productCombinations[k]
                            .ProductCombinationPrice);
                  }
                }
              }
              yield GetDriverOrdersState(
                  getDriverOrdersByStatusResponse: orderDetailsResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
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

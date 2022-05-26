import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bangla_bazar/Helper/db_helper.dart';
import 'package:bangla_bazar/ModelClasses/add_process_order_model.dart';
import 'package:bangla_bazar/ModelClasses/add_process_order_response.dart';
import 'package:bangla_bazar/ModelClasses/add_user_payment_model.dart';
import 'package:bangla_bazar/ModelClasses/add_user_payment_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_countries_list_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_city_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_states_response.dart';
import 'package:bangla_bazar/ModelClasses/auth_net_payment_model.dart';
import 'package:bangla_bazar/ModelClasses/auth_net_payment_response.dart';
import 'package:bangla_bazar/ModelClasses/card_details_response.dart';
import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/ModelClasses/check_delivery_driver_model.dart';
import 'package:bangla_bazar/ModelClasses/check_delivery_driver_response.dart';
import 'package:bangla_bazar/ModelClasses/cod_init_model.dart';
import 'package:bangla_bazar/ModelClasses/cod_init_response.dart';
import 'package:bangla_bazar/ModelClasses/delivery_products_check_model.dart';
import 'package:bangla_bazar/ModelClasses/get_inventory_count_response.dart';
import 'package:bangla_bazar/ModelClasses/get_shipping_status_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_access_token_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_area_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_area_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_cities_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_price_calculation_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_price_calculation_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_token_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_zone_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_zones_response.dart';
import 'package:bangla_bazar/ModelClasses/payment_history_response.dart';
import 'package:bangla_bazar/ModelClasses/remove_from_cart_model.dart';
import 'package:bangla_bazar/ModelClasses/sigin_model.dart';
import 'package:bangla_bazar/ModelClasses/ssl_commerz_init_response.dart';
import 'package:bangla_bazar/ModelClasses/ssl_get_detail_model.dart';
import 'package:bangla_bazar/ModelClasses/sslcommerce_init_model.dart';
import 'package:bangla_bazar/ModelClasses/stripe_response.dart';
import 'package:bangla_bazar/ModelClasses/stripe_trans_init_model.dart';
import 'package:bangla_bazar/ModelClasses/transection_details_response.dart';
import 'package:bangla_bazar/ModelClasses/update_cart_model.dart';
import 'package:bangla_bazar/ModelClasses/user_address_history.dart';
import 'package:bangla_bazar/ModelClasses/usps_address_verify_model.dart';
import 'package:bangla_bazar/ModelClasses/usps_address_verify_response.dart';
import 'package:bangla_bazar/ModelClasses/usps_rate_calculation_model.dart';
import 'package:bangla_bazar/ModelClasses/usps_rate_calculation_response.dart';

import 'package:bangla_bazar/Repository/repository.dart';
import 'package:bangla_bazar/Utils/add_to_cart_local_db.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/common_functions.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());
  final dbHelper = DatabaseHelper.instance;

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is GetCartDetails) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getCartDetails();
          //print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            CartDetailsResponse cartDetailsResponse =
                CartDetailsResponse.fromJson(jsonDecode(response.toString()));
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
    } else if (event is GetUserAddressHistory) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getUserAddressHistory();
          //print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            print('||||||||||12');
            UsersHistoryAddresses usersHistoryAddresses =
                UsersHistoryAddresses.fromJson(jsonDecode(response.toString()));

            if (usersHistoryAddresses.status == true) {
              yield UsersHistoryAddressesState(
                  usersHistoryAddresses: usersHistoryAddresses);
            } else {
              yield ErrorState(error: 'False');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid credentials');
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
    } else if (event is DeleteCartLocalProduct) {
      yield LoadingState();

      try {
        var deleteProducts =
            await dbHelper.deleteCartProducts(event.uniqueNumber);
        var deleteCombinations =
            await dbHelper.deleteCartProductsCombination(event.uniqueNumber);

        yield ErrorState(error: 'Product Deleted (L)');
      } catch (e) {
        yield ErrorState(error: 'No data found!');
        print(e.toString());
      }
    } else if (event is GetUserCardDetails) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getUserCardDetails();
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            CardDetailsResponse cardDetailsResponse =
                CardDetailsResponse.fromJson(jsonDecode(response.toString()));

            if (cardDetailsResponse.status == true) {
              yield CardDetailsState(cardDetailsResponse: cardDetailsResponse);
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
    } else if (event is GetPathaoAccessToken) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getPathaoAccessToken();
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            PathaoAccessTokenResponse pathaoAccessTokenResponse =
                PathaoAccessTokenResponse.fromJson(
                    jsonDecode(response.toString()));

            //log(pathaoAccessTokenResponse.token);

            if (pathaoAccessTokenResponse.status == true) {
              yield PathaoGetAccessTokenState(
                  pathaoAccessTokenResponse: pathaoAccessTokenResponse);
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
    } else if (event is GetPaymentHistory) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getPaymentHistory();
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            PaymentHistory paymentHistory =
                PaymentHistory.fromJson(jsonDecode(response.toString()));

            if (paymentHistory.status == true) {
              yield GetPaymentHistoryState(paymentHistory: paymentHistory);
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
    } else if (event is GetVendorAllowedStates) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response =
              await Repository().getVendorAllowedStates(id: event.id);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AllowedVendorStatesResponse allowedVendorStatesResponse =
                AllowedVendorStatesResponse.fromJson(
                    jsonDecode(response.toString()));

            if (allowedVendorStatesResponse.status == true) {
              yield VendorAllowedStates(
                  allowedVendorStatesResponse: allowedVendorStatesResponse);
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
    } else if (event is GetVendorAllowedCities) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response =
              await Repository().getVendorAllowedCities(id: event.id);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AllowedVendorCityResponse allowedVendorCityResponse =
                AllowedVendorCityResponse.fromJson(
                    jsonDecode(response.toString()));

            if (allowedVendorCityResponse.status == true) {
              yield VendorAllowedCities(
                  allowedVendorCityResponse: allowedVendorCityResponse);
            } else {
              yield ErrorState(error: '');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is GetPathaoCities) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .getPathaoCities(pathaoTokenModel: event.pathaoTokenModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            PathaoCitiesResponse pathaoCitiesResponse =
                PathaoCitiesResponse.fromJson(jsonDecode(response.toString()));

            if (pathaoCitiesResponse.status == true) {
              yield PathaoCitiesState(
                  pathaoCitiesResponse: pathaoCitiesResponse);
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
    } else if (event is GetPathaoZones) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .getPathaoZones(pathaoZoneModel: event.pathaoZoneModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            PathaoZonesResponse pathaoZonesResponse =
                PathaoZonesResponse.fromJson(jsonDecode(response.toString()));

            if (pathaoZonesResponse.status == true) {
              yield PathaoZonesState(pathaoZonesResponse: pathaoZonesResponse);
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
    } else if (event is GetPathaoAreas) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .getPathaoAreas(pathaoAreaModel: event.pathaoAreaModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            PathaoAreaResponse pathaoAreaResponse =
                PathaoAreaResponse.fromJson(jsonDecode(response.toString()));

            if (pathaoAreaResponse.status == true) {
              yield PathaoAreasState(pathaoAreaResponse: pathaoAreaResponse);
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
    } else if (event is PathaoPriceCalculation) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().pathaoPriceCalculation(
              pathaoPriceCalculationModel: event.pathaoPriceCalculationModel);
          log('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            PathaoPriceCalculationResponse pathaoPriceCalculationResponse =
                PathaoPriceCalculationResponse.fromJson(
                    jsonDecode(response.toString()));

            if (pathaoPriceCalculationResponse.status == true) {
              yield PathaoPriceCalculationState(
                  pathaoPriceCalculationResponse:
                      pathaoPriceCalculationResponse);
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
    } else if (event is GetInventory) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getInventory(
              cartDetailsResponseTemp: event.cartDetailsResponseTemp);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            GetInventoryCountResponse getInventoryCountResponse =
                GetInventoryCountResponse.fromJson(
                    jsonDecode(response.toString()));

            if (getInventoryCountResponse.status == true) {
              yield GetInventoryState(
                  getInventoryCountResponse: getInventoryCountResponse);
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
    } else if (event is CheckDriverAvailability) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().checkDriverAvailability(
              checkDeliveryDriverModel: event.checkDeliveryDriverModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            CheckDeliveryDriverResponse checkDeliveryDriverResponse =
                CheckDeliveryDriverResponse.fromJson(
                    jsonDecode(response.toString()));

            if (checkDeliveryDriverResponse.status == true) {
              yield CheckDriverAvailabilityState(
                  checkDeliveryDriverResponse: checkDeliveryDriverResponse);
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
    } else if (event is VerifyUspsAddress) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().verifyUspsAddress(
              uspsAddressVerifyModel: event.uspsAddressVerifyModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            UspsAddressVerifyResponse uspsAddressVerifyResponse =
                UspsAddressVerifyResponse.fromJson(
                    jsonDecode(response.toString()));

            yield VerifyUspsAddressState(
                uspsAddressVerifyResponse: uspsAddressVerifyResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is UspsCalculateRate) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().uspsCalculateRate(
              uspsRateCalculationModel: event.uspsRateCalculationModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            UspsRateCalculationResponse uspsRateCalculationResponse =
                UspsRateCalculationResponse.fromJson(
                    jsonDecode(response.toString()));

            yield UspsCalculateRateState(
                uspsRateCalculationResponse: uspsRateCalculationResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is GetTransectionDetails) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getTransectionDetails(
              sslGetDetailsModel: event.sslGetDetailsModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            TransectionDetailsResponse transectionDetailsResponse =
                TransectionDetailsResponse.fromJson(
                    jsonDecode(response.toString()));

            if (transectionDetailsResponse.status == true) {
              yield GetTransectionDetailsState(
                  transectionDetailsResponse: transectionDetailsResponse);
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
    } else if (event is UpdatePaymentStatus) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .updatePaymentStatus(id: event.id, status: event.status);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AddOrderProcessResponse addOrderProcessResponse =
                AddOrderProcessResponse.fromJson(
                    jsonDecode(response.toString()));

            if (addOrderProcessResponse.status == true) {
              yield ErrorState(error: 'Payment ${event.status}');
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
    } else if (event is RemoveProductFromCart) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().removeProductFromCart(
              id: event.id, removeFromCartModel: event.removeFromCartModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AddOrderProcessResponse addOrderProcessResponse =
                AddOrderProcessResponse.fromJson(
                    jsonDecode(response.toString()));

            if (addOrderProcessResponse.status == true) {
              yield ProductRemoveFromCartState(
                  addOrderProcessResponse: addOrderProcessResponse);
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
    } else if (event is UpdateCart) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response =
              await Repository().updateCart(productDetail: event.productDetail);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AddOrderProcessResponse addOrderProcessResponse =
                AddOrderProcessResponse.fromJson(
                    jsonDecode(response.toString()));

            if (addOrderProcessResponse.status == true) {
              yield CartUpdatedState(
                  addOrderProcessResponse: addOrderProcessResponse);
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
    } else if (event is TransectionInitSSLCommerce) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .transectioninit(transInitModel: event.transInitModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            SSLCommerzInitResponse sslCommerzInitResponse =
                SSLCommerzInitResponse.fromJson(
                    jsonDecode(response.toString()));
            yield TransectionInitializedState(
                sslCommerzInitResponse: sslCommerzInitResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is TransectionInitStripe) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().transectionInitStripe(
              stripeTransInitModel: event.stripeTransInitModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          print('<<<<<<<<<<<<<1234');

          if (response != null) {
            StripInitResponse stripInitResponse =
                StripInitResponse.fromJson(jsonDecode(response.toString()));
            print('<<<<<<<<<<<<<1234567');
            yield TransectionInitStripeState(
                stripInitResponse: stripInitResponse);
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is AuthNetTransectionInit) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .authNetTransectionInit(transInitModel: event.transInitModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AuthorizedNetPaymentResponse authorizedNetPaymentResponse =
                AuthorizedNetPaymentResponse.fromJson(
                    jsonDecode(response.toString()));

            if (authorizedNetPaymentResponse.status == true) {
              yield AuthNetTransectionInitializedState(
                  authorizedNetPaymentResponse: authorizedNetPaymentResponse);
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
    } else if (event is CashOnDeliveryInitEvent) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .cashOnDeliveryInit(cashOnDeliveryInit: event.cashOnDeliveryInit);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            CODInitResponse cashOnDeliveryInitResponse =
                CODInitResponse.fromJson(jsonDecode(response.toString()));

            if (cashOnDeliveryInitResponse.status == true) {
              yield CashOnDeliveryInitState(
                  cashOnDeliveryInitResponse: cashOnDeliveryInitResponse);
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
    } else if (event is AddUserPayment) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .addUserPayment(addUserPaymentModel: event.addUserPaymentModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AddUserPaymentResponse addUserPaymentResponse =
                AddUserPaymentResponse.fromJson(
                    jsonDecode(response.toString()));

            if (addUserPaymentResponse.status == true) {
              yield AddUserPaymentState(
                  addUserPaymentResponse: addUserPaymentResponse);
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
    } else if (event is AddProcessOrder) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().addProcessOrder(
              addProcessOrderModel: event.addProcessOrderModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AddOrderProcessResponse addOrderProcessResponse =
                AddOrderProcessResponse.fromJson(
                    jsonDecode(response.toString()));

            if (addOrderProcessResponse.status == true) {
              yield OrderPlacedSuccessfullyState();
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
    } else if (event is GetShippingStatus) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getShippingStatus(
              deliveryProductsCheckModel: event.deliveryProductsCheckModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            GetShippingDetailsResponse getShippingDetailsResponse =
                GetShippingDetailsResponse.fromJson(
                    jsonDecode(response.toString()));

            if (getShippingDetailsResponse.status == true) {
              yield GetShippingStatusState(
                  getShippingDetailsResponse: getShippingDetailsResponse);
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
    }
  }
}

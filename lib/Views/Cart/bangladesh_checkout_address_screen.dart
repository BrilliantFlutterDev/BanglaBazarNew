import 'dart:developer';
import 'dart:io';

import 'package:bangla_bazar/ModelClasses/BangladeshPaymentUserData.dart';
import 'package:bangla_bazar/ModelClasses/allowed_countries_list_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_city_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_states_response.dart';
import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/ModelClasses/check_delivery_driver_model.dart';
import 'package:bangla_bazar/ModelClasses/check_delivery_driver_response.dart';
import 'package:bangla_bazar/ModelClasses/delivery_products_check_model.dart';
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
import 'package:bangla_bazar/ModelClasses/user_address_history.dart'
    as user_history;
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/Cart/CartBloc/cart_bloc.dart';
import 'package:bangla_bazar/Views/Cart/bangladesh_checkout_payment_screen.dart';
import 'package:bangla_bazar/Views/Cart/checkout_payment_screen.dart';
import 'package:bangla_bazar/Views/Cart/checkout_summary_screen.dart';
import 'package:bangla_bazar/Views/Cart/stripe_payment_screen.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:bangla_bazar/ModelClasses/get_inventory_count_response.dart'
    as inventory_response;

class BangladeshCheckoutAddressScreen extends StatefulWidget {
  CartDetailsResponse cartDetailsResponse;
  var allowedCountriesISO2List;
  AllowedCountriesResponse allowedCountriesResponse;
  int selectedCountryId;
  AllowedVendorStatesResponse? allowedVendorStatesResponse;
  AllowedVendorCityResponse? allowedVendorCityResponse;
  bool creditCardPayment;
  UserPaymentHistory? userPaymentHistory;

  /// Delivery Checks variable
  final bool countriesAreSame;
  final bool globalShipping;
  final bool shippingAvailable;
  final String shippingAvailableCity;
  final int shippingAvailableCountryID;
  final String globalShippingCountry;
  BangladeshCheckoutAddressScreen(
      {Key? key,
      required this.cartDetailsResponse,
      required this.allowedCountriesISO2List,
      required this.allowedCountriesResponse,
      required this.selectedCountryId,
      required this.allowedVendorStatesResponse,
      required this.allowedVendorCityResponse,
      required this.creditCardPayment,
      this.userPaymentHistory,
      required this.countriesAreSame,
      required this.globalShipping,
      required this.shippingAvailable,
      required this.shippingAvailableCity,
      required this.shippingAvailableCountryID,
      required this.globalShippingCountry})
      : super(key: key);
  @override
  _BangladeshCheckoutAddressScreenState createState() =>
      _BangladeshCheckoutAddressScreenState();
}

class _BangladeshCheckoutAddressScreenState
    extends State<BangladeshCheckoutAddressScreen> {
  late CartBloc _cartBloc;

  /// For payment address
  TextEditingController nameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  TextEditingController createdDateController = TextEditingController();

  PhoneNumber phoneNumber = PhoneNumber();
  final TextEditingController controller = TextEditingController();

  late DateTime pickedDate;

  late String selectedCity = '';

  late String selectedState = '';
  final TextEditingController deliveryAddressNickName = TextEditingController();

  late String selectedDeliveryCity = '';
  late int selectedDeliveryCityId = 0;

  late String selectedDeliveryZone = '';
  late int selectedDeliveryZoneId = 0;

  late String selectedDeliveryArea = '';
  late int selectedDeliveryAreaId = 0;

  BangladeshPaymentUserData? bangladeshPaymentUserData;
  var _selectedDialogCountry;

  DeliveryProductsCheckModel? deliveryProductsCheckModel;
  GetShippingDetailsResponse? getShippingDetailsResponse;

  /// for delivery addresss

  TextEditingController nameDeliveryController = TextEditingController();
  TextEditingController address1DeliveryController = TextEditingController();
  TextEditingController address2DeliveryController = TextEditingController();
  TextEditingController zipCodeDeliveryController = TextEditingController();

  TextEditingController adminDeliveryNoteController = TextEditingController();

  TextEditingController phoneDeliveryNumberController = TextEditingController();
  TextEditingController deliveryCityController = TextEditingController();
  TextEditingController cardNumber = TextEditingController();

  late String selectedCityDelivery = '';

  late int selectedTempCityIdDelivery = 0;

  late String _chooseCountryCodeDelivery = '';

  bool deliveryAddressFlag = false;

  bool banglaBazarPickup = true;
  bool pickUpAvailable = false;

  PathaoAccessTokenResponse? pathaoAccessTokenResponse;
  PathaoTokenModel? pathaoTokenModel;
  PathaoCitiesResponse pathaoCitiesResponse =
      PathaoCitiesResponse(status: true, cities: []);

  PathaoZoneModel? pathaoZoneModel;
  PathaoZonesResponse pathaoZonesResponse =
      PathaoZonesResponse(status: true, zones: []);

  PathaoAreaModel? pathaoAreaModel;
  PathaoAreaResponse pathaoAreaResponse =
      PathaoAreaResponse(status: true, areas: []);

  PathaoPriceCalculationModel? pathaoPriceCalculationModel;
  PathaoPriceCalculationResponse? pathaoPriceCalculationResponse;
  double totalWeightOfAllProducts = 0.0;

  bool productsAndUserCitiesAreSame = true;

  CheckDeliveryDriverModel? checkDeliveryDriverModel;
  CheckDeliveryDriverResponse? checkDeliveryDriverResponse;

  int selectedPaymentCountryID = -1;

  bool countryPaymentSelected = false;

  double shippingPrice = 0.0;

  user_history.UsersHistoryAddresses? usersHistoryAddresses;

  bool showSameAsAbove = true;

  late int tempDeliveryAddressCountry;

  bool savePaymentAddress = false;
  bool saveDeliveryAddress = false;

  bool citiesOfAllProductsSame = true;
  bool checkDeliveryConditionsProceed = true;
  late String checkDeliveryConditionsProceedReason;

  inventory_response.GetInventoryCountResponse? getInventoryCountResponse;

  int previousSelectedPaymentIndex = -1;
  int previousSelectedDeliveryIndex = -1;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    tempDeliveryAddressCountry = widget.selectedCountryId;
    _cartBloc = BlocProvider.of<CartBloc>(context);
    // _cartBloc.add(GetCartDetails());
    _cartBloc.add(GetUserAddressHistory());
    // _cartBloc.add(GetVendorAllowedCountries());
    deliveryProductsCheckModel = DeliveryProductsCheckModel(productDetail: []);
    for (int i = 0;
        i < widget.cartDetailsResponse.productCartList.length;
        i++) {
      deliveryProductsCheckModel!.productDetail.add(ProductDetail(
          ProductID: widget.cartDetailsResponse.productCartList[i].ProductID
              .toString()));

      ///  below code is For delivery apis
      totalWeightOfAllProducts = totalWeightOfAllProducts +
          double.parse(widget.cartDetailsResponse.productCartList[i].Weight!);
      if (widget.cartDetailsResponse.productCartList[i].City !=
          widget.cartDetailsResponse.productCartList[0].City) {
        productsAndUserCitiesAreSame = false;
      }
    }
    _cartBloc.add(GetShippingStatus(
        deliveryProductsCheckModel: deliveryProductsCheckModel!));

    if (widget.userPaymentHistory != null) {
      nameController.text = widget.userPaymentHistory!.Name;
      address1Controller.text = widget.userPaymentHistory!.Address1;
      address2Controller.text = widget.userPaymentHistory!.Address2;
      zipCodeController.text = widget.userPaymentHistory!.ZipCode;
      selectedCity = widget.userPaymentHistory!.City;
      //selectedZone=widget.userPaymentHistory!.
    }
    _cartBloc.add(GetPathaoAccessToken());
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<CartBloc, CartState>(listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is ErrorState) {
        Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
      } else if (state is InternetErrorState) {
        Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
      } else if (state is UsersHistoryAddressesState) {
        usersHistoryAddresses = state.usersHistoryAddresses;
      } else if (state is PathaoGetAccessTokenState) {
        pathaoAccessTokenResponse = state.pathaoAccessTokenResponse;
        pathaoTokenModel =
            PathaoTokenModel(token: pathaoAccessTokenResponse!.token);
        _cartBloc.add(GetPathaoCities(pathaoTokenModel: pathaoTokenModel!));
      } else if (state is PathaoCitiesState) {
        pathaoCitiesResponse = state.pathaoCitiesResponse;
      } else if (state is PathaoZonesState) {
        pathaoZonesResponse = state.pathaoZonesResponse;
        print('>>>>>>>>>>>>>>Get Pathao Zones');
      } else if (state is PathaoAreasState) {
        pathaoAreaResponse = state.pathaoAreaResponse;
        print('>>>>>>>>>>>>>>>>>>> Get Pathao Area');
      } else if (state is CheckInventoryState) {
        print('>>>>>>>>>>>>>>Inventory Checked');
        getInventoryCountResponse = state.getInventoryCountResponse;

        if (getInventoryCountResponse!.outOfStockProducts.isEmpty) {
          ///Empty array means no product is out of stock

          /// For pathao and bangladaesh
          if (selectedPaymentCountryID != 226) {
            if (widget.creditCardPayment == true) {
              if (nameDeliveryController.text != '') {
                if (address1DeliveryController.text.length > 25) {
                  if (phoneDeliveryNumberController.text.length == 11) {
                    print('Proceeding the payment>>>>>>>>>146');
                    if (zipCodeDeliveryController.text != '') {
                      print('Proceeding the payment>>>>>>>>>13');
                      if (selectedDeliveryCity != '') {
                        if (selectedDeliveryZone != '') {
                          if (selectedDeliveryArea != '') {
                            print('Proceeding the payment>>>>>>>>>12');
                            if (selectedDeliveryCity !=
                                widget.cartDetailsResponse.productCartList[0]
                                    .City) {
                              pickUpAvailable = false;
                            }
                            print('Proceeding the payment>>>>>>>>>');
                            bangladeshPaymentUserData =
                                BangladeshPaymentUserData(
                                    selectedPaymentCountry:
                                        selectedPaymentCountryID,
                                    name: nameController.text,
                                    cardNumber: cardNumber.text,
                                    address1: address1Controller.text,
                                    address2: address2Controller.text,
                                    phoneCode: '',
                                    phoneNumber: AppGlobal.phoneNumber.length ==
                                            11
                                        ? AppGlobal.phoneNumber
                                        : phoneDeliveryNumberController.text,
                                    country: selectedPaymentCountryID == 16
                                        ? 'Bangladesh'
                                        : 'USA',
                                    countryID: selectedPaymentCountryID,
                                    zipCode: zipCodeController.text,
                                    city: selectedCity,
                                    createdAtDate: createdDateController.text,
                                    selectedDeliveryCountry:
                                        widget.selectedCountryId,
                                    banglaBazarDelivery: banglaBazarPickup,
                                    pickUp: pickUpAvailable,
                                    address1Delivery:
                                        address1DeliveryController.text,
                                    address2Delivery:
                                        address2DeliveryController.text,
                                    adminNoteDelivery:
                                        adminDeliveryNoteController.text,
                                    phoneNumberDelivery:
                                        phoneDeliveryNumberController.text,
                                    nameDelivery: nameDeliveryController.text,
                                    zipCodeDelivery:
                                        zipCodeDeliveryController.text,
                                    phoneCodeDelivery:
                                        _chooseCountryCodeDelivery,
                                    nickNameDelivery:
                                        deliveryAddressNickName.text,
                                    zoneDeliveryID: selectedDeliveryZoneId,
                                    cityDeliveryID: selectedTempCityIdDelivery,
                                    areaDeliveryID: selectedDeliveryAreaId,
                                    state: selectedState,
                                    shippingPrice: shippingPrice,
                                    cityDelivery: selectedDeliveryCity,
                                    zoneDelivery: selectedDeliveryZone,
                                    areaDelivery: selectedDeliveryArea,
                                    savePaymentAddress: savePaymentAddress,
                                    saveDeliveryAddress: saveDeliveryAddress);
                            print('Proceeding the payment>>>>>>>>>12345');

                            if (checkDeliveryDriverResponse != null) {
                              print('Proceeding the payment>>>>>>>>>12346');
                              if (checkDeliveryDriverResponse!
                                      .deliveryDriverStatus ==
                                  false) {
                                productsAndUserCitiesAreSame = false;
                              } else if (checkDeliveryDriverResponse!
                                      .deliveryDriverStatus ==
                                  true) {
                                productsAndUserCitiesAreSame = true;
                              }
                            }

                            if (selectedPaymentCountryID == 16) {
                              print('Proceeding the payment>>>>>>>>>12347');
                              if (checkDeliveryConditionsProceed == true) {
                                print('Proceeding the payment>>>>>>>>>1212');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutSummaryScreen(
                                      cartDetailsResponse:
                                          widget.cartDetailsResponse,
                                      bangladeshPaymentUserData:
                                          bangladeshPaymentUserData!,
                                      productsAndUserCitiesAreSame:
                                          productsAndUserCitiesAreSame,
                                      creditCardPayment:
                                          widget.creditCardPayment,
                                      pathaoPriceCalculationResponse:
                                          pathaoPriceCalculationResponse,
                                    ),
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: checkDeliveryConditionsProceedReason,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey.shade400,
                                    textColor: Colors.white,
                                    fontSize: 12.0);
                              }
                            } else if (selectedPaymentCountryID == 226) {
                              print('Proceeding the payment>>>>>>>>>222222');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutPaymentScreen(
                                    cartDetailsResponse:
                                        widget.cartDetailsResponse,
                                    // bangladeshPaymentUserData:
                                    // bangladeshPaymentUserData!,
                                    productsAndUserCitiesAreSame:
                                        productsAndUserCitiesAreSame,
                                    creditCardPayment: widget.creditCardPayment,
                                    selectedCountryId: selectedPaymentCountryID,
                                    bangladeshPaymentUserData:
                                        bangladeshPaymentUserData!,
                                    pathaoPriceCalculationResponse:
                                        pathaoPriceCalculationResponse,

                                    // pathaoPriceCalculationResponse:
                                    // pathaoPriceCalculationResponse,
                                  ),
                                ),
                              );
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Please enter delivery area',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade400,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please enter delivery zone',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade400,
                              textColor: Colors.white,
                              fontSize: 12.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Please enter delivery City',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey.shade400,
                            textColor: Colors.white,
                            fontSize: 12.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please enter delivery zip code',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey.shade400,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }
                  } else {
                    print(
                        '<<<<<<<<<<Phone Number Length: ${phoneDeliveryNumberController.text.length}');
                    // Fluttertoast.showToast(
                    //     msg:
                    //         'Please enter correct delivery phone number',
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.BOTTOM,
                    //     timeInSecForIosWeb: 1,
                    //     backgroundColor: Colors.grey.shade400,
                    //     textColor: Colors.white,
                    //     fontSize: 12.0);
                    print(
                        '<<<<<<<<<<Phone Number Length2: ${phoneDeliveryNumberController.text.length}');
                  }
                } else {
                  Fluttertoast.showToast(
                      msg:
                          'Please enter delivery address 1 of length minimum 25 characters',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey.shade400,
                      textColor: Colors.white,
                      fontSize: 12.0);
                }
              } else {
                Fluttertoast.showToast(
                    msg: 'Please enter Name of person to deliver',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey.shade400,
                    textColor: Colors.white,
                    fontSize: 12.0);
              }
            } else {
              if (nameDeliveryController.text != '') {
                if (address1DeliveryController.text.length > 25) {
                  if (phoneDeliveryNumberController.text.length == 11) {
                    if (zipCodeDeliveryController.text != '') {
                      if (selectedDeliveryCity != '') {
                        if (selectedDeliveryZone != '') {
                          if (selectedDeliveryArea != '') {
                            if (selectedDeliveryCity !=
                                widget.cartDetailsResponse.productCartList[0]
                                    .City) {
                              pickUpAvailable = false;
                            }
                            print('Proceeding the card payment>>>>>>>>>');
                            bangladeshPaymentUserData =
                                BangladeshPaymentUserData(
                                    selectedPaymentCountry:
                                        selectedPaymentCountryID,
                                    name: nameController.text,
                                    cardNumber: cardNumber.text,
                                    address1: address1Controller.text,
                                    address2: address2Controller.text,
                                    phoneCode: '',
                                    phoneNumber: AppGlobal.phoneNumber.length ==
                                            11
                                        ? AppGlobal.phoneNumber
                                        : phoneDeliveryNumberController.text,
                                    country: widget.selectedCountryId == 16
                                        ? 'Bangladesh'
                                        : 'USA',
                                    countryID: selectedPaymentCountryID,
                                    zipCode: zipCodeController.text,
                                    city: selectedCity,
                                    createdAtDate: createdDateController.text,
                                    selectedDeliveryCountry:
                                        widget.selectedCountryId,
                                    banglaBazarDelivery: banglaBazarPickup,
                                    pickUp: pickUpAvailable,
                                    address1Delivery:
                                        address1DeliveryController.text,
                                    address2Delivery:
                                        address2DeliveryController.text,
                                    adminNoteDelivery:
                                        adminDeliveryNoteController.text,
                                    phoneNumberDelivery:
                                        phoneDeliveryNumberController.text,
                                    nameDelivery: nameDeliveryController.text,
                                    zipCodeDelivery:
                                        zipCodeDeliveryController.text,
                                    phoneCodeDelivery:
                                        _chooseCountryCodeDelivery,
                                    nickNameDelivery:
                                        deliveryAddressNickName.text,
                                    zoneDeliveryID: selectedDeliveryZoneId,
                                    cityDeliveryID: selectedTempCityIdDelivery,
                                    areaDeliveryID: selectedDeliveryAreaId,
                                    state: selectedState,
                                    shippingPrice: shippingPrice,
                                    cityDelivery: selectedDeliveryCity,
                                    zoneDelivery: selectedDeliveryZone,
                                    areaDelivery: selectedDeliveryArea,
                                    savePaymentAddress: savePaymentAddress,
                                    saveDeliveryAddress: saveDeliveryAddress);
                            print('Proceeding the card payment>>>>>>>>>12345');

                            if (checkDeliveryDriverResponse != null) {
                              print(
                                  'Proceeding the  card payment>>>>>>>>>12346');
                              if (checkDeliveryDriverResponse!
                                      .deliveryDriverStatus ==
                                  false) {
                                productsAndUserCitiesAreSame = false;
                              } else if (checkDeliveryDriverResponse!
                                      .deliveryDriverStatus ==
                                  true) {
                                productsAndUserCitiesAreSame = true;
                              }
                            }

                            if (widget.selectedCountryId == 16) {
                              print('Proceeding the payment>>>>>>>>>12347');
                              if (checkDeliveryConditionsProceed == true) {
                                print('Proceeding the payment>>>>>>>>>1212');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutSummaryScreen(
                                      cartDetailsResponse:
                                          widget.cartDetailsResponse,
                                      bangladeshPaymentUserData:
                                          bangladeshPaymentUserData!,
                                      productsAndUserCitiesAreSame:
                                          productsAndUserCitiesAreSame,
                                      creditCardPayment:
                                          widget.creditCardPayment,
                                      pathaoPriceCalculationResponse:
                                          pathaoPriceCalculationResponse,
                                    ),
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: checkDeliveryConditionsProceedReason,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey.shade400,
                                    textColor: Colors.white,
                                    fontSize: 12.0);
                              }
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Please enter delivery area',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade400,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please enter delivery zone',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade400,
                              textColor: Colors.white,
                              fontSize: 12.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Please enter delivery City',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey.shade400,
                            textColor: Colors.white,
                            fontSize: 12.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please enter delivery zip code',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey.shade400,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Please enter correct delivery phone number',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey.shade400,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                } else {
                  Fluttertoast.showToast(
                      msg:
                          'Please enter delivery address 1 of length minimum 25 characters',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey.shade400,
                      textColor: Colors.white,
                      fontSize: 12.0);
                }
              } else {
                Fluttertoast.showToast(
                    msg: 'Please enter Name of person to deliver',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey.shade400,
                    textColor: Colors.white,
                    fontSize: 12.0);
              }
            }
          } else {
            bangladeshPaymentUserData = BangladeshPaymentUserData(
                selectedPaymentCountry: selectedPaymentCountryID,
                name: nameController.text,
                cardNumber: cardNumber.text,
                address1: address1Controller.text,
                address2: address2Controller.text,
                phoneCode: '',
                phoneNumber: AppGlobal.phoneNumber.length == 11
                    ? AppGlobal.phoneNumber
                    : phoneDeliveryNumberController.text,
                country: widget.selectedCountryId == 16 ? 'Bangladesh' : 'USA',
                countryID: selectedPaymentCountryID,
                zipCode: zipCodeController.text,
                city: selectedCity,
                createdAtDate: createdDateController.text,
                selectedDeliveryCountry: widget.selectedCountryId,
                banglaBazarDelivery: banglaBazarPickup,
                pickUp: pickUpAvailable,
                address1Delivery: address1DeliveryController.text,
                address2Delivery: address2DeliveryController.text,
                adminNoteDelivery: adminDeliveryNoteController.text,
                phoneNumberDelivery: phoneDeliveryNumberController.text,
                nameDelivery: nameDeliveryController.text,
                zipCodeDelivery: zipCodeDeliveryController.text,
                phoneCodeDelivery: _chooseCountryCodeDelivery,
                nickNameDelivery: deliveryAddressNickName.text,
                zoneDeliveryID: selectedDeliveryZoneId,
                cityDeliveryID: selectedTempCityIdDelivery,
                areaDeliveryID: selectedDeliveryAreaId,
                state: selectedState,
                shippingPrice: shippingPrice,
                cityDelivery: selectedDeliveryCity,
                zoneDelivery: selectedDeliveryZone,
                areaDelivery: selectedDeliveryArea,
                savePaymentAddress: savePaymentAddress,
                saveDeliveryAddress: saveDeliveryAddress);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StripePaymentScreen(
                        cartDetailsResponse: widget.cartDetailsResponse,
                        productsAndUserCitiesAreSame:
                            productsAndUserCitiesAreSame,
                        creditCardPayment: widget.creditCardPayment,
                        pathaoPriceCalculationResponse:
                            pathaoPriceCalculationResponse,
                        bangladeshPaymentUserData: bangladeshPaymentUserData,
                      )),
            );
          }

          ///Empty array means no product is out of stock
        } else {
          for (int i = 0;
              i < getInventoryCountResponse!.outOfStockProducts.length;
              i++) {
            for (int j = 0;
                j <
                    getInventoryCountResponse!
                        .outOfStockProducts[i].productDetail.length;
                j++) {
              if (getInventoryCountResponse!
                      .outOfStockProducts[i].productDetail[j].Inventory ==
                  0) {
                Fluttertoast.showToast(
                    msg:
                        "${getInventoryCountResponse!.outOfStockProducts[i].productDetail[j].Title} >>> Variant : ${getInventoryCountResponse!.outOfStockProducts[i].productDetail[j].OptionValue} is not available.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey.shade400,
                    textColor: Colors.white,
                    fontSize: 12.0);
              }
            }
          }
        }
      } else if (state is PathaoPriceCalculationState) {
        pathaoPriceCalculationResponse = state.pathaoPriceCalculationResponse;
        print('>>>>>>>>>>>>>>>>>>> Get Pathao Price Calculation');
        shippingPrice = 0;
        for (int i = 0;
            i < pathaoPriceCalculationResponse!.saveResponse.length;
            i++) {
          shippingPrice = shippingPrice +
              pathaoPriceCalculationResponse!.saveResponse[i].data.price +
              pathaoPriceCalculationResponse!
                  .saveResponse[i].data.additionalCharge;
        }
      } else if (state is CheckDriverAvailabilityState) {
        checkDeliveryDriverResponse = state.checkDeliveryDriverResponse;
        print(
            '>>>>>>>>>>>Checked driver availability${checkDeliveryDriverResponse!.deliveryDriverStatus}');
      } else if (state is GetShippingStatusState) {
        getShippingDetailsResponse = state.getShippingDetailsResponse;
        if (AppGlobal.defaultPayment == 'Y') {
          if (AppGlobal.nameOnCard != '') {
            nameController.text = AppGlobal.nameOnCard;
          }
          // if (AppGlobal.address1 != '') {
          //   address1Controller.text = AppGlobal.address1;
          // }
          // if (AppGlobal.address2 != '') {
          //   address2Controller.text = AppGlobal.address2;
          // }
          // if (AppGlobal.zipCode != '') {
          //   zipCodeController.text = AppGlobal.zipCode;
          // }
          // if (AppGlobal.userAddressCity != '') {
          //   selectedCity = AppGlobal.userAddressCity;
          // }
          // if (AppGlobal.userAddressState != '') {
          //   selectedState = AppGlobal.userAddressState;
          // }
          if (AppGlobal.countryId != -1) {
            // widget.selectedCountryId = AppGlobal.countryId;

            for (int i = 0;
                i < widget.allowedCountriesResponse.countries.length;
                i++) {
              if (widget.allowedCountriesResponse.countries[i].CountryID ==
                  widget.selectedCountryId) {
                ///se = allowedCountriesResponse.countries[i].Country;
                _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode(
                    widget.allowedCountriesResponse.countries[i].ISO2);
                break;
              }
            }

            // _cartBloc.add(GetVendorAllowedStates(id: widget.selectedCountryId));
            // _cartBloc.add(GetVendorAllowedCities(id: widget.selectedCountryId));
          }
        }
      } else if (state is GetInventoryState) {
        getInventoryCountResponse = state.getInventoryCountResponse;
        if (getInventoryCountResponse!.outOfStockProducts.isEmpty) {
          ///Empty array means no product is out of stock

          /// For pathao and bangladaesh
          if (selectedPaymentCountryID != 226) {
            if (widget.creditCardPayment == true) {
              if (nameController.text != '') {
                if (address1Controller.text.length > 25) {
                  if (zipCodeController.text != '') {
                    if (selectedCity != '') {
                      if (nameDeliveryController.text != '') {
                        if (address1DeliveryController.text.length > 25) {
                          if (phoneDeliveryNumberController.text.length == 11) {
                            if (zipCodeDeliveryController.text != '') {
                              if (selectedDeliveryCity != '') {
                                if (selectedDeliveryZone != '') {
                                  if (selectedDeliveryArea != '') {
                                    if (selectedDeliveryCity !=
                                        widget.cartDetailsResponse
                                            .productCartList[0].City) {
                                      pickUpAvailable = false;
                                    }
                                    bangladeshPaymentUserData = BangladeshPaymentUserData(
                                        selectedPaymentCountry:
                                            selectedPaymentCountryID,
                                        name: nameController.text,
                                        cardNumber: cardNumber.text,
                                        address1: address1Controller.text,
                                        address2: address2Controller.text,
                                        phoneCode: '',
                                        phoneNumber:
                                            AppGlobal.phoneNumber.length == 11
                                                ? AppGlobal.phoneNumber
                                                : phoneDeliveryNumberController
                                                    .text,
                                        country: selectedPaymentCountryID == 16
                                            ? 'Bangladesh'
                                            : 'USA',
                                        countryID: selectedPaymentCountryID,
                                        zipCode: zipCodeController.text,
                                        city: selectedCity,
                                        createdAtDate:
                                            createdDateController.text,
                                        selectedDeliveryCountry:
                                            widget.selectedCountryId,
                                        banglaBazarDelivery: banglaBazarPickup,
                                        pickUp: pickUpAvailable,
                                        address1Delivery:
                                            address1DeliveryController.text,
                                        address2Delivery:
                                            address2DeliveryController.text,
                                        adminNoteDelivery:
                                            adminDeliveryNoteController.text,
                                        phoneNumberDelivery:
                                            phoneDeliveryNumberController.text,
                                        nameDelivery:
                                            nameDeliveryController.text,
                                        zipCodeDelivery:
                                            zipCodeDeliveryController.text,
                                        phoneCodeDelivery:
                                            _chooseCountryCodeDelivery,
                                        nickNameDelivery:
                                            deliveryAddressNickName.text,
                                        zoneDeliveryID: selectedDeliveryZoneId,
                                        cityDeliveryID:
                                            selectedTempCityIdDelivery,
                                        areaDeliveryID: selectedDeliveryAreaId,
                                        state: selectedState,
                                        shippingPrice: shippingPrice,
                                        cityDelivery: selectedDeliveryCity,
                                        zoneDelivery: selectedDeliveryZone,
                                        areaDelivery: selectedDeliveryArea,
                                        savePaymentAddress: savePaymentAddress,
                                        saveDeliveryAddress:
                                            saveDeliveryAddress);
                                    if (checkDeliveryDriverResponse != null) {
                                      if (checkDeliveryDriverResponse!
                                              .deliveryDriverStatus ==
                                          false) {
                                        productsAndUserCitiesAreSame = false;
                                      } else if (checkDeliveryDriverResponse!
                                              .deliveryDriverStatus ==
                                          true) {
                                        productsAndUserCitiesAreSame = true;
                                      }
                                    }

                                    if (selectedPaymentCountryID == 16) {
                                      if (checkDeliveryConditionsProceed ==
                                          true) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CheckoutSummaryScreen(
                                              cartDetailsResponse:
                                                  widget.cartDetailsResponse,
                                              bangladeshPaymentUserData:
                                                  bangladeshPaymentUserData!,
                                              productsAndUserCitiesAreSame:
                                                  productsAndUserCitiesAreSame,
                                              creditCardPayment:
                                                  widget.creditCardPayment,
                                              pathaoPriceCalculationResponse:
                                                  pathaoPriceCalculationResponse,
                                            ),
                                          ),
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                checkDeliveryConditionsProceedReason,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                Colors.grey.shade400,
                                            textColor: Colors.white,
                                            fontSize: 12.0);
                                      }
                                    } else if (selectedPaymentCountryID ==
                                        226) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CheckoutPaymentScreen(
                                            cartDetailsResponse:
                                                widget.cartDetailsResponse,
                                            // bangladeshPaymentUserData:
                                            // bangladeshPaymentUserData!,
                                            productsAndUserCitiesAreSame:
                                                productsAndUserCitiesAreSame,
                                            creditCardPayment:
                                                widget.creditCardPayment,
                                            selectedCountryId:
                                                selectedPaymentCountryID,
                                            bangladeshPaymentUserData:
                                                bangladeshPaymentUserData!,
                                            pathaoPriceCalculationResponse:
                                                pathaoPriceCalculationResponse,

                                            // pathaoPriceCalculationResponse:
                                            // pathaoPriceCalculationResponse,
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Please enter delivery area',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey.shade400,
                                        textColor: Colors.white,
                                        fontSize: 12.0);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Please enter delivery zone',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey.shade400,
                                      textColor: Colors.white,
                                      fontSize: 12.0);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Please enter delivery City',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey.shade400,
                                    textColor: Colors.white,
                                    fontSize: 12.0);
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Please enter delivery zip code',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey.shade400,
                                  textColor: Colors.white,
                                  fontSize: 12.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Please enter 11 digit phone number',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade400,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  'Please enter delivery address 1 of length minimum 25 characters',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade400,
                              textColor: Colors.white,
                              fontSize: 12.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Please enter Name of person to deliver',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey.shade400,
                            textColor: Colors.white,
                            fontSize: 12.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please select a City',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey.shade400,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Please enter Zip Code',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey.shade400,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                } else {
                  Fluttertoast.showToast(
                      msg:
                          'Please enter Address 1 of length minimum 25 characters',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey.shade400,
                      textColor: Colors.white,
                      fontSize: 12.0);
                }
              } else {
                Fluttertoast.showToast(
                    msg: 'Please enter full name',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey.shade400,
                    textColor: Colors.white,
                    fontSize: 12.0);
              }
            } else {
              if (nameDeliveryController.text != '') {
                if (address1DeliveryController.text.length > 25) {
                  if (phoneDeliveryNumberController.text.length == 11) {
                    if (zipCodeDeliveryController.text != '') {
                      if (selectedDeliveryCity != '') {
                        if (selectedDeliveryZone != '') {
                          if (selectedDeliveryArea != '') {
                            if (selectedDeliveryCity !=
                                widget.cartDetailsResponse.productCartList[0]
                                    .City) {
                              pickUpAvailable = false;
                            }
                            print('Proceeding the card payment>>>>>>>>>');
                            bangladeshPaymentUserData =
                                BangladeshPaymentUserData(
                                    selectedPaymentCountry:
                                        selectedPaymentCountryID,
                                    name: nameController.text,
                                    cardNumber: cardNumber.text,
                                    address1: address1Controller.text,
                                    address2: address2Controller.text,
                                    phoneCode: '',
                                    phoneNumber: AppGlobal.phoneNumber.length ==
                                            11
                                        ? AppGlobal.phoneNumber
                                        : phoneDeliveryNumberController.text,
                                    country: widget.selectedCountryId == 16
                                        ? 'Bangladesh'
                                        : 'USA',
                                    countryID: selectedPaymentCountryID,
                                    zipCode: zipCodeController.text,
                                    city: selectedCity,
                                    createdAtDate: createdDateController.text,
                                    selectedDeliveryCountry:
                                        widget.selectedCountryId,
                                    banglaBazarDelivery: banglaBazarPickup,
                                    pickUp: pickUpAvailable,
                                    address1Delivery:
                                        address1DeliveryController.text,
                                    address2Delivery:
                                        address2DeliveryController.text,
                                    adminNoteDelivery:
                                        adminDeliveryNoteController.text,
                                    phoneNumberDelivery:
                                        phoneDeliveryNumberController.text,
                                    nameDelivery: nameDeliveryController.text,
                                    zipCodeDelivery:
                                        zipCodeDeliveryController.text,
                                    phoneCodeDelivery:
                                        _chooseCountryCodeDelivery,
                                    nickNameDelivery:
                                        deliveryAddressNickName.text,
                                    zoneDeliveryID: selectedDeliveryZoneId,
                                    cityDeliveryID: selectedTempCityIdDelivery,
                                    areaDeliveryID: selectedDeliveryAreaId,
                                    state: selectedState,
                                    shippingPrice: shippingPrice,
                                    cityDelivery: selectedDeliveryCity,
                                    zoneDelivery: selectedDeliveryZone,
                                    areaDelivery: selectedDeliveryArea,
                                    savePaymentAddress: savePaymentAddress,
                                    saveDeliveryAddress: saveDeliveryAddress);
                            print('Proceeding the card payment>>>>>>>>>12345');

                            if (checkDeliveryDriverResponse != null) {
                              print(
                                  'Proceeding the  card payment>>>>>>>>>12346');
                              if (checkDeliveryDriverResponse!
                                      .deliveryDriverStatus ==
                                  false) {
                                productsAndUserCitiesAreSame = false;
                              } else if (checkDeliveryDriverResponse!
                                      .deliveryDriverStatus ==
                                  true) {
                                productsAndUserCitiesAreSame = true;
                              }
                            }

                            if (widget.selectedCountryId == 16) {
                              print('Proceeding the payment>>>>>>>>>12347');
                              if (checkDeliveryConditionsProceed == true) {
                                print('Proceeding the payment>>>>>>>>>1212');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutSummaryScreen(
                                      cartDetailsResponse:
                                          widget.cartDetailsResponse,
                                      bangladeshPaymentUserData:
                                          bangladeshPaymentUserData!,
                                      productsAndUserCitiesAreSame:
                                          productsAndUserCitiesAreSame,
                                      creditCardPayment:
                                          widget.creditCardPayment,
                                      pathaoPriceCalculationResponse:
                                          pathaoPriceCalculationResponse,
                                    ),
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: checkDeliveryConditionsProceedReason,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey.shade400,
                                    textColor: Colors.white,
                                    fontSize: 12.0);
                              }
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Please enter delivery area',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade400,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please enter delivery zone',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade400,
                              textColor: Colors.white,
                              fontSize: 12.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Please enter delivery City',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey.shade400,
                            textColor: Colors.white,
                            fontSize: 12.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please enter delivery zip code',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey.shade400,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Please enter correct delivery phone number',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey.shade400,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                } else {
                  Fluttertoast.showToast(
                      msg:
                          'Please enter delivery address 1 of length minimum 25 characters',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey.shade400,
                      textColor: Colors.white,
                      fontSize: 12.0);
                }
              } else {
                Fluttertoast.showToast(
                    msg: 'Please enter Name of person to deliver',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey.shade400,
                    textColor: Colors.white,
                    fontSize: 12.0);
              }
            }
          } else {
            bangladeshPaymentUserData = BangladeshPaymentUserData(
                selectedPaymentCountry: selectedPaymentCountryID,
                name: nameController.text,
                cardNumber: cardNumber.text,
                address1: address1Controller.text,
                address2: address2Controller.text,
                phoneCode: '',
                phoneNumber: AppGlobal.phoneNumber.length == 11
                    ? AppGlobal.phoneNumber
                    : phoneDeliveryNumberController.text,
                country: widget.selectedCountryId == 16 ? 'Bangladesh' : 'USA',
                countryID: selectedPaymentCountryID,
                zipCode: zipCodeController.text,
                city: selectedCity,
                createdAtDate: createdDateController.text,
                selectedDeliveryCountry: widget.selectedCountryId,
                banglaBazarDelivery: banglaBazarPickup,
                pickUp: pickUpAvailable,
                address1Delivery: address1DeliveryController.text,
                address2Delivery: address2DeliveryController.text,
                adminNoteDelivery: adminDeliveryNoteController.text,
                phoneNumberDelivery: phoneDeliveryNumberController.text,
                nameDelivery: nameDeliveryController.text,
                zipCodeDelivery: zipCodeDeliveryController.text,
                phoneCodeDelivery: _chooseCountryCodeDelivery,
                nickNameDelivery: deliveryAddressNickName.text,
                zoneDeliveryID: selectedDeliveryZoneId,
                cityDeliveryID: selectedTempCityIdDelivery,
                areaDeliveryID: selectedDeliveryAreaId,
                state: selectedState,
                shippingPrice: shippingPrice,
                cityDelivery: selectedDeliveryCity,
                zoneDelivery: selectedDeliveryZone,
                areaDelivery: selectedDeliveryArea,
                savePaymentAddress: savePaymentAddress,
                saveDeliveryAddress: saveDeliveryAddress);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StripePaymentScreen(
                        cartDetailsResponse: widget.cartDetailsResponse,
                        productsAndUserCitiesAreSame:
                            productsAndUserCitiesAreSame,
                        creditCardPayment: widget.creditCardPayment,
                        pathaoPriceCalculationResponse:
                            pathaoPriceCalculationResponse,
                        bangladeshPaymentUserData: bangladeshPaymentUserData,
                      )),
            );
          }

          ///Empty array means no product is out of stock

        } else {
          for (int i = 0;
              i < getInventoryCountResponse!.outOfStockProducts.length;
              i++) {
            for (int j = 0;
                j <
                    getInventoryCountResponse!
                        .outOfStockProducts[i].productDetail.length;
                j++) {
              if (getInventoryCountResponse!
                      .outOfStockProducts[i].productDetail[j].Inventory ==
                  0) {
                Fluttertoast.showToast(
                    msg:
                        "${getInventoryCountResponse!.outOfStockProducts[i].productDetail[j].Title} >>> Variant : ${getInventoryCountResponse!.outOfStockProducts[i].productDetail[j].OptionValue} is not available.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey.shade400,
                    textColor: Colors.white,
                    fontSize: 12.0);
              }
            }
          }
        }
        print('>>>>>>>>>>>>>>>>>>>>>Get Inventory Checked');
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
            backgroundColor: kColorWhite,
            // extendBody: true,
            // resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                ///This is the body
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          // color: Colors.yellow,
                          width: screenSize.width,
                          height: screenSize.height * 0.15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kColorPrimary,
                                // border: Border.all(
                                //     color: kColorDarkGreyText, width: 3),
                                // image: DecorationImage(
                                //   image: Image.asset("assets/icons/eyeicon.png",),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: const Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      color: kColorWhite, fontSize: 16),
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              width: screenSize.width * 0.26,
                              color: kColorFieldsBorders,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kColorWhite,
                                border: Border.all(
                                    color: kColorFieldsBorders, width: 1),
                                // image: DecorationImage(
                                //   image: Image.asset("assets/icons/eyeicon.png",),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: const Center(
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                      color: kColorFieldsBorders, fontSize: 16),
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              width: screenSize.width * 0.26,
                              color: kColorFieldsBorders,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kColorWhite,
                                border: Border.all(
                                    color: kColorFieldsBorders, width: 1),
                                // image: DecorationImage(
                                //   image: Image.asset("assets/icons/eyeicon.png",),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: const Center(
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                      color: kColorFieldsBorders, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Address',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Container(
                              //height: 1,
                              width: screenSize.width * 0.19,
                              //color: kColorDarkGreyText,
                            ),
                            const Text(
                              'Summary',
                              style: TextStyle(
                                  color: kColorFieldsBorders, fontSize: 14),
                            ),
                            Container(
                              //height: 1,
                              width: screenSize.width * 0.19,
                              //color: kColorDarkGreyText,
                            ),
                            const Text(
                              'Payment',
                              style: TextStyle(
                                  color: kColorFieldsBorders, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenSize.height * 0.07,
                        ),

                        ///
                        Visibility(
                          visible: widget.creditCardPayment,
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Payment Address',
                                  style: TextStyle(
                                      fontSize: 18, color: kColorPrimary),
                                ),
                              ),
                              usersHistoryAddresses != null
                                  ? usersHistoryAddresses!
                                          .userPaymentHistory.isNotEmpty
                                      ? const SizedBox(
                                          height: 25,
                                        )
                                      : const SizedBox()
                                  : const SizedBox(),
                              usersHistoryAddresses != null
                                  ? usersHistoryAddresses!
                                          .userPaymentHistory.isNotEmpty
                                      ? Container(
                                          width: screenSize.width,
                                          height: screenSize.height * 0.065,
                                          child: ListView.builder(
                                              itemCount:
                                                  usersHistoryAddresses == null
                                                      ? 0
                                                      : usersHistoryAddresses!
                                                          .userPaymentHistory
                                                          .length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (usersHistoryAddresses!
                                                              .userPaymentHistory[
                                                                  index]
                                                              .isSelected ==
                                                          true) {
                                                        usersHistoryAddresses!
                                                            .userPaymentHistory[
                                                                index]
                                                            .isSelected = false;
                                                        selectedPaymentCountryID =
                                                            -1;

                                                        _selectedDialogCountry =
                                                            null;

                                                        countryPaymentSelected =
                                                            false;
                                                        nameController.text =
                                                            '';
                                                        cardNumber.text = '';
                                                        address1Controller
                                                            .text = '';
                                                        address2Controller
                                                            .text = '';
                                                        zipCodeController.text =
                                                            '';
                                                        selectedCity = '';
                                                        cityController.text =
                                                            '';
                                                        selectedState = '';
                                                        stateController.text =
                                                            '';
                                                        setState(() {});
                                                      } else {
                                                        if (previousSelectedPaymentIndex !=
                                                            -1) {
                                                          usersHistoryAddresses!
                                                              .userPaymentHistory[
                                                                  previousSelectedPaymentIndex]
                                                              .isSelected = false;
                                                        }
                                                        previousSelectedPaymentIndex =
                                                            index;
                                                        usersHistoryAddresses!
                                                            .userPaymentHistory[
                                                                index]
                                                            .isSelected = true;
                                                        selectedPaymentCountryID =
                                                            usersHistoryAddresses!
                                                                .userPaymentHistory[
                                                                    index]
                                                                .CountryID;

                                                        for (int i = 0;
                                                            i <
                                                                widget
                                                                    .allowedCountriesResponse
                                                                    .countries
                                                                    .length;
                                                            i++) {
                                                          if (widget
                                                                  .allowedCountriesResponse
                                                                  .countries[i]
                                                                  .CountryID ==
                                                              selectedPaymentCountryID) {
                                                            _selectedDialogCountry =
                                                                CountryPickerUtils
                                                                    .getCountryByIsoCode(widget
                                                                        .allowedCountriesResponse
                                                                        .countries[
                                                                            i]
                                                                        .ISO2);
                                                            break;
                                                          }
                                                        }

                                                        countryPaymentSelected =
                                                            true;
                                                        nameController.text =
                                                            usersHistoryAddresses!
                                                                .userPaymentHistory[
                                                                    index]
                                                                .Name;
                                                        cardNumber.text =
                                                            usersHistoryAddresses!
                                                                .userPaymentHistory[
                                                                    index]
                                                                .CardNumber;
                                                        address1Controller
                                                                .text =
                                                            usersHistoryAddresses!
                                                                .userPaymentHistory[
                                                                    index]
                                                                .Address1;
                                                        address2Controller
                                                                .text =
                                                            usersHistoryAddresses!
                                                                .userPaymentHistory[
                                                                    index]
                                                                .Address2;
                                                        zipCodeController.text =
                                                            usersHistoryAddresses!
                                                                .userPaymentHistory[
                                                                    index]
                                                                .ZipCode;
                                                        selectedCity =
                                                            usersHistoryAddresses!
                                                                .userPaymentHistory[
                                                                    index]
                                                                .City;
                                                        cityController.text =
                                                            usersHistoryAddresses!
                                                                .userPaymentHistory[
                                                                    index]
                                                                .City;
                                                        selectedState =
                                                            usersHistoryAddresses!
                                                                .userPaymentHistory[
                                                                    index]
                                                                .State;
                                                        stateController.text =
                                                            usersHistoryAddresses!
                                                                .userPaymentHistory[
                                                                    index]
                                                                .State;

                                                        setState(() {});
                                                      }
                                                    },
                                                    child: Container(
                                                      height:
                                                          screenSize.height *
                                                              0.05,
                                                      // width: screenSize.width * 0.33,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            kColorWidgetBackgroundColor,
                                                        border: Border.all(
                                                            color: usersHistoryAddresses!
                                                                        .userPaymentHistory[
                                                                            index]
                                                                        .isSelected ==
                                                                    true
                                                                ? kColorPrimary
                                                                : kColorWidgetBackgroundColor,
                                                            width: 2),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(10.0),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20),
                                                        child: Row(
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment.center,
                                                          // crossAxisAlignment:
                                                          //     CrossAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.credit_card,
                                                              size: 30,
                                                              color: usersHistoryAddresses!
                                                                          .userPaymentHistory[
                                                                              index]
                                                                          .isSelected ==
                                                                      true
                                                                  ? kColorPrimary
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Text(
                                                              usersHistoryAddresses ==
                                                                      null
                                                                  ? ''
                                                                  : usersHistoryAddresses!
                                                                      .userPaymentHistory[
                                                                          index]
                                                                      .CardNumber,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          18),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        )
                                      : const SizedBox()
                                  : const SizedBox(),
                              const SizedBox(
                                height: 25,
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Payment Address Country',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              countryPaymentSelected == false
                                  ? InkWell(
                                      onTap: _openCountryPickerDialog,
                                      child: Container(
                                        height: screenSize.height * 0.06,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            color: kColorWhite,
                                            border: Border.all(
                                                color: kColorFieldsBorders)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                'Select Country',
                                                style: TextStyle(
                                                    color: kColorFieldsBorders),
                                              ),
                                              Icon(Icons.arrow_drop_down_sharp)
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: screenSize.height * 0.068,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          color: kColorWhite,
                                          border: Border.all(
                                              color: kColorFieldsBorders)),
                                      child: Center(
                                        child: ListTile(
                                          onTap: _openCountryPickerDialog,
                                          title: _buildDialogItem(
                                              _selectedDialogCountry),
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 25,
                              ),

                              ///Invisible while USA
                              selectedPaymentCountryID == 226
                                  ? Column(
                                      children: [
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Full Name',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: screenSize.height * 0.06,
                                          child: TextField(
                                            controller: nameController,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            style: const TextStyle(
                                                color: kColorDarkGreyText),
                                            decoration: InputDecoration(
                                              // floatingLabelStyle:
                                              // const TextStyle(color: kColorPrimary),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                borderSide: const BorderSide(
                                                  color: kColorFieldsBorders,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  borderSide: const BorderSide(
                                                    color: kColorPrimary,
                                                  )),
                                              hintText: 'Enter Full Name',
                                              hintStyle: const TextStyle(
                                                  color: kColorFieldsBorders),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        widget.creditCardPayment == true
                                            ? const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Card Number',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                              )
                                            : const SizedBox(),
                                        widget.creditCardPayment == true
                                            ? const SizedBox(
                                                height: 5,
                                              )
                                            : const SizedBox(),
                                        widget.creditCardPayment == true
                                            ? Container(
                                                height:
                                                    screenSize.height * 0.06,
                                                child: TextField(
                                                  controller: cardNumber,
                                                  textCapitalization:
                                                      TextCapitalization.words,
                                                  style: const TextStyle(
                                                      color:
                                                          kColorDarkGreyText),
                                                  decoration: InputDecoration(
                                                    // floatingLabelStyle:
                                                    // const TextStyle(color: kColorPrimary),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            kColorFieldsBorders,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0),
                                                            borderSide:
                                                                const BorderSide(
                                                              color:
                                                                  kColorPrimary,
                                                            )),
                                                    hintText:
                                                        'Enter Card Number',
                                                    hintStyle: const TextStyle(
                                                        color:
                                                            kColorFieldsBorders),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                        widget.creditCardPayment == true
                                            ? const SizedBox(
                                                height: 25,
                                              )
                                            : const SizedBox(),
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Address 1',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextField(
                                          controller: address1Controller,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          style: const TextStyle(
                                              color: kColorDarkGreyText),
                                          decoration: InputDecoration(
                                            // floatingLabelStyle:
                                            // const TextStyle(color: kColorPrimary),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              borderSide: const BorderSide(
                                                color: kColorFieldsBorders,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                borderSide: const BorderSide(
                                                  color: kColorPrimary,
                                                )),
                                            hintText: 'Enter Address 1',
                                            hintStyle: const TextStyle(
                                                color: kColorFieldsBorders),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(),
                                              Text(
                                                '${address1Controller.text.length}',
                                                style: const TextStyle(
                                                    color: kColorDarkGreyText),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Note : Address 1 should contains at least 25 characters.',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: kColorOrangeText,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Address 2 ${widget.selectedCountryId != 226 ? '(Optional)' : ''}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextField(
                                          controller: address2Controller,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          style: const TextStyle(
                                              color: kColorDarkGreyText),
                                          decoration: InputDecoration(
                                            // floatingLabelStyle:
                                            // const TextStyle(color: kColorPrimary),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              borderSide: const BorderSide(
                                                color: kColorFieldsBorders,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                borderSide: const BorderSide(
                                                  color: kColorPrimary,
                                                )),
                                            hintText: 'Enter Address 2',
                                            hintStyle: const TextStyle(
                                                color: kColorFieldsBorders),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(),
                                              Text(
                                                '${address2Controller.text.length}',
                                                style: const TextStyle(
                                                    color: kColorDarkGreyText),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Note : Address 2 should contains at least 25 characters.',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: kColorOrangeText,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Zip Code',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: screenSize.height * 0.06,
                                          child: TextField(
                                            controller: zipCodeController,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: const TextStyle(
                                                color: kColorDarkGreyText),
                                            decoration: InputDecoration(
                                              // floatingLabelStyle:
                                              // const TextStyle(color: kColorPrimary),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                borderSide: const BorderSide(
                                                  color: kColorFieldsBorders,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  borderSide: const BorderSide(
                                                    color: kColorPrimary,
                                                  )),
                                              hintText: 'Enter Zip Code',
                                              hintStyle: const TextStyle(
                                                  color: kColorFieldsBorders),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'City',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: screenSize.height * 0.06,
                                          child: TextField(
                                            textCapitalization:
                                                TextCapitalization.words,
                                            controller: cityController,
                                            onChanged: (value) {
                                              selectedCity = value;
                                              //print(selectedState);
                                            },
                                            style: const TextStyle(
                                                color: kColorDarkGreyText),
                                            decoration: InputDecoration(
                                              // floatingLabelStyle:
                                              // const TextStyle(color: kColorPrimary),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                borderSide: const BorderSide(
                                                  color: kColorFieldsBorders,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  borderSide: const BorderSide(
                                                    color: kColorPrimary,
                                                  )),
                                              hintText: 'Enter City',
                                              hintStyle: const TextStyle(
                                                  color: kColorFieldsBorders),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'State',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: screenSize.height * 0.06,
                                          child: TextField(
                                            textCapitalization:
                                                TextCapitalization.words,
                                            controller: stateController,
                                            onChanged: (value) {
                                              selectedState = value;
                                              //print(selectedState);
                                            },
                                            style: const TextStyle(
                                                color: kColorDarkGreyText),
                                            decoration: InputDecoration(
                                              // floatingLabelStyle:
                                              // const TextStyle(color: kColorPrimary),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                borderSide: const BorderSide(
                                                  color: kColorFieldsBorders,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  borderSide: const BorderSide(
                                                    color: kColorPrimary,
                                                  )),
                                              hintText: 'Enter State',
                                              hintStyle: const TextStyle(
                                                  color: kColorFieldsBorders),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          children: [
                                            Theme(
                                                data: ThemeData(
                                                    unselectedWidgetColor:
                                                        Colors.grey),
                                                child: Checkbox(
                                                  value: savePaymentAddress,
                                                  onChanged: (state) {
                                                    if (savePaymentAddress) {
                                                      savePaymentAddress =
                                                          false;
                                                    } else {
                                                      savePaymentAddress = true;
                                                    }

                                                    setState(() {});
                                                  },
                                                  activeColor: kColorPrimary,
                                                  checkColor: Colors.white,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .padded,
                                                )),
                                            const Text('Save payment address')
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                      ],
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),

                        // const Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text(
                        //     'Order Note (Optional)',
                        //     style: TextStyle(fontSize: 14, color: Colors.black),
                        //   ),
                        // ),
                        // Container(
                        //   height: screenSize.height * 0.3,
                        //   width: screenSize.width,
                        //   decoration: const BoxDecoration(
                        //     boxShadow: [],
                        //     borderRadius: BorderRadius.all(Radius.circular(6)),
                        //     color: kColorWhite,
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                        //     child: TextField(
                        //       textCapitalization: TextCapitalization.sentences,
                        //       keyboardType: TextInputType.text,
                        //       controller: adminNoteController,
                        //       //focusNode: fObservation,
                        //       // maxLength: 200,
                        //       style: const TextStyle(
                        //         color: Colors.black,
                        //       ),
                        //       onChanged: (value) {
                        //         setState(() {
                        //           //charLength = value.length;
                        //         });
                        //         //print('$value,$charLength');
                        //       },
                        //       maxLines: 8,
                        //       cursorColor: kColorPrimary,
                        //       decoration: InputDecoration(
                        //         floatingLabelBehavior:
                        //             FloatingLabelBehavior.always,
                        //         // hintText: getTranslated(context,
                        //         //     'typeherestartdictation'),
                        //         isDense: true,
                        //         contentPadding:
                        //             const EdgeInsets.fromLTRB(10, 20, 40, 0),
                        //         hintStyle:
                        //             TextStyle(color: Colors.grey.shade400),
                        //         enabledBorder: const OutlineInputBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(5.0)),
                        //           borderSide: BorderSide(
                        //               color: kColorFieldsBorders, width: 1),
                        //         ),
                        //         focusedBorder: const OutlineInputBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(5.0)),
                        //           borderSide: BorderSide(
                        //               color: kColorFieldsBorders, width: 1),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Delivery Address',
                            style:
                                TextStyle(fontSize: 18, color: kColorPrimary),
                          ),
                        ),

                        widget.selectedCountryId == selectedPaymentCountryID &&
                                selectedPaymentCountryID == 226
                            ? Visibility(
                                visible: showSameAsAbove,
                                child: Row(
                                  children: [
                                    Theme(
                                        data: ThemeData(
                                            unselectedWidgetColor: Colors.grey),
                                        child: Checkbox(
                                          value: deliveryAddressFlag,
                                          onChanged: (state) {
                                            if (deliveryAddressFlag == false) {
                                              deliveryAddressFlag = true;
                                              nameDeliveryController.text =
                                                  nameController.text;
                                              address1DeliveryController.text =
                                                  address1Controller.text;
                                              address2DeliveryController.text =
                                                  address2Controller.text;
                                              zipCodeDeliveryController.text =
                                                  zipCodeController.text;

                                              // if (selectedDeliveryZoneId != 0) {
                                              //   selectedDeliveryArea = '';
                                              //   selectedDeliveryAreaId = 0;
                                              //   pathaoAreaModel = PathaoAreaModel(
                                              //       token:
                                              //           pathaoAccessTokenResponse!
                                              //               .token,
                                              //       zoneId:
                                              //           selectedDeliveryZoneId
                                              //               .toString());
                                              //   _cartBloc.add(GetPathaoAreas(
                                              //       pathaoAreaModel:
                                              //           pathaoAreaModel!));
                                              //   pathaoPriceCalculationModel =
                                              //       PathaoPriceCalculationModel(
                                              //           token:
                                              //               pathaoAccessTokenResponse!
                                              //                   .token,
                                              //           itemWeight:
                                              //               totalWeightOfAllProducts
                                              //                   .toString(),
                                              //           recipientCity:
                                              //               selectedDeliveryCityId
                                              //                   .toString(),
                                              //           recipientZone:
                                              //               selectedDeliveryZoneId
                                              //                   .toString());
                                              //   _cartBloc.add(PathaoPriceCalculation(
                                              //       pathaoPriceCalculationModel:
                                              //           pathaoPriceCalculationModel!));
                                              // }
                                            } else {
                                              deliveryAddressFlag = false;
                                              nameDeliveryController.text = '';
                                              address1DeliveryController.text =
                                                  '';
                                              address2DeliveryController.text =
                                                  '';
                                              zipCodeDeliveryController.text =
                                                  '';
                                              adminDeliveryNoteController.text =
                                                  '';

                                              _chooseCountryCodeDelivery = '';
                                              phoneDeliveryNumberController
                                                  .text = '';
                                            }

                                            setState(() {});
                                          },
                                          activeColor: kColorPrimary,
                                          checkColor: Colors.white,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.padded,
                                        )),
                                    const Text('Same as above')
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        usersHistoryAddresses != null
                            ? usersHistoryAddresses!
                                    .userAddressHistory.isNotEmpty
                                ? const SizedBox(
                                    height: 25,
                                  )
                                : const SizedBox()
                            : const SizedBox(),

                        usersHistoryAddresses != null
                            ? usersHistoryAddresses!
                                    .userAddressHistory.isNotEmpty
                                ? Container(
                                    width: screenSize.width,
                                    height: screenSize.height * 0.065,
                                    child: ListView.builder(
                                        itemCount: usersHistoryAddresses == null
                                            ? 0
                                            : usersHistoryAddresses!
                                                .userAddressHistory.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: InkWell(
                                              onTap: () {
                                                if (usersHistoryAddresses!
                                                        .userAddressHistory[
                                                            index]
                                                        .isSelected ==
                                                    true) {
                                                  usersHistoryAddresses!
                                                      .userAddressHistory[index]
                                                      .isSelected = false;
                                                  showSameAsAbove = true;
                                                  deliveryAddressFlag = false;

                                                  widget.selectedCountryId =
                                                      tempDeliveryAddressCountry;

                                                  nameDeliveryController.text =
                                                      '';

                                                  address1DeliveryController
                                                      .text = '';
                                                  address2DeliveryController
                                                      .text = '';
                                                  zipCodeDeliveryController
                                                      .text = '';
                                                  phoneDeliveryNumberController
                                                      .text = '';
                                                  selectedCityDelivery = '';
                                                  selectedDeliveryCityId = 0;

                                                  selectedDeliveryZone = '';
                                                  selectedDeliveryZoneId = 0;
                                                  selectedDeliveryArea = '';
                                                  selectedDeliveryAreaId = 0;
                                                  setState(() {});
                                                } else {
                                                  if (previousSelectedDeliveryIndex !=
                                                      -1) {
                                                    usersHistoryAddresses!
                                                        .userAddressHistory[
                                                            previousSelectedDeliveryIndex]
                                                        .isSelected = false;
                                                  }
                                                  previousSelectedDeliveryIndex =
                                                      index;
                                                  usersHistoryAddresses!
                                                      .userAddressHistory[index]
                                                      .isSelected = true;
                                                  showSameAsAbove = false;
                                                  widget.selectedCountryId =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .CountryID;

                                                  nameDeliveryController.text =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .Name;

                                                  address1DeliveryController
                                                          .text =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .Address1;
                                                  address2DeliveryController
                                                          .text =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .Address2;
                                                  phoneDeliveryNumberController
                                                          .text =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .PhoneNumber;
                                                  zipCodeDeliveryController
                                                          .text =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .ZipCode;
                                                  selectedDeliveryCity =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .City;
                                                  selectedDeliveryCityId =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .CityID;

                                                  selectedTempCityIdDelivery =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .PathaoCityID;

                                                  ///
                                                  if (selectedDeliveryCityId !=
                                                      0) {
                                                    if (selectedDeliveryCity !=
                                                        widget
                                                            .cartDetailsResponse
                                                            .productCartList[0]
                                                            .City) {
                                                      productsAndUserCitiesAreSame =
                                                          false;
                                                    }
                                                    if (productsAndUserCitiesAreSame ==
                                                        true) {
                                                      checkDeliveryDriverModel =
                                                          CheckDeliveryDriverModel(
                                                              CityName:
                                                                  selectedDeliveryCity);
                                                      _cartBloc.add(
                                                          CheckDriverAvailability(
                                                              checkDeliveryDriverModel:
                                                                  checkDeliveryDriverModel!));
                                                    }
                                                    pathaoZoneModel = PathaoZoneModel(
                                                        token:
                                                            pathaoAccessTokenResponse!
                                                                .token,
                                                        cityId:
                                                            selectedDeliveryCityId
                                                                .toString());
                                                    _cartBloc.add(GetPathaoZones(
                                                        pathaoZoneModel:
                                                            pathaoZoneModel!));
                                                  }

                                                  ///

                                                  selectedDeliveryZone =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .DeliveryZone;
                                                  selectedDeliveryZoneId =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .ZoneID;

                                                  ///
                                                  if (selectedDeliveryZoneId !=
                                                      0) {
                                                    pathaoAreaModel = PathaoAreaModel(
                                                        token:
                                                            pathaoAccessTokenResponse!
                                                                .token,
                                                        zoneId:
                                                            selectedDeliveryZoneId
                                                                .toString());
                                                    _cartBloc.add(GetPathaoAreas(
                                                        pathaoAreaModel:
                                                            pathaoAreaModel!));

                                                    late List<String>
                                                        productIDs = [];

                                                    for (int p = 0;
                                                        p <
                                                            widget
                                                                .cartDetailsResponse
                                                                .productCartList
                                                                .length;
                                                        p++) {
                                                      productIDs.add(widget
                                                          .cartDetailsResponse
                                                          .productCartList[p]
                                                          .ProductID
                                                          .toString());
                                                    }
                                                    pathaoPriceCalculationModel =
                                                        PathaoPriceCalculationModel(
                                                            token:
                                                                pathaoAccessTokenResponse!
                                                                    .token,
                                                            recipientCity:
                                                                selectedTempCityIdDelivery
                                                                    .toString(),
                                                            recipientZone:
                                                                selectedDeliveryZoneId
                                                                    .toString(),
                                                            ProductIDs:
                                                                productIDs,
                                                            DBCityID:
                                                                selectedTempCityIdDelivery
                                                                    .toString());
                                                    _cartBloc.add(
                                                        PathaoPriceCalculation(
                                                            pathaoPriceCalculationModel:
                                                                pathaoPriceCalculationModel!));
                                                  }

                                                  ///
                                                  selectedDeliveryArea =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .DeliveryArea;
                                                  selectedDeliveryAreaId =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .AreaID;
                                                  deliveryAddressNickName.text =
                                                      usersHistoryAddresses!
                                                          .userAddressHistory[
                                                              index]
                                                          .AddressLabel;

                                                  setState(() {});
                                                }
                                              },
                                              child: Container(
                                                height:
                                                    screenSize.height * 0.05,
                                                // width: screenSize.width * 0.33,
                                                decoration: BoxDecoration(
                                                  color:
                                                      kColorWidgetBackgroundColor,
                                                  border: Border.all(
                                                      color: usersHistoryAddresses!
                                                                  .userAddressHistory[
                                                                      index]
                                                                  .isSelected ==
                                                              true
                                                          ? kColorPrimary
                                                          : kColorWidgetBackgroundColor,
                                                      width: 2),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment.center,
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        MyFlutterApp
                                                            .ic_location_on,
                                                        size: 25,
                                                        color: usersHistoryAddresses!
                                                                    .userAddressHistory[
                                                                        index]
                                                                    .isSelected ==
                                                                true
                                                            ? kColorPrimary
                                                            : Colors.black,
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        usersHistoryAddresses ==
                                                                null
                                                            ? ''
                                                            : usersHistoryAddresses!
                                                                .userAddressHistory[
                                                                    index]
                                                                .AddressLabel,
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                : const SizedBox()
                            : const SizedBox(),

                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Full Name (Delivery)',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: screenSize.height * 0.06,
                          child: TextField(
                            controller: nameDeliveryController,
                            textCapitalization: TextCapitalization.words,
                            style: const TextStyle(color: kColorDarkGreyText),
                            decoration: InputDecoration(
                              // floatingLabelStyle:
                              // const TextStyle(color: kColorPrimary),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                  color: kColorFieldsBorders,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: const BorderSide(
                                    color: kColorPrimary,
                                  )),
                              hintText: 'Enter Full Name',
                              hintStyle:
                                  const TextStyle(color: kColorFieldsBorders),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Delivery Address 1',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: address1DeliveryController,
                          textCapitalization: TextCapitalization.words,
                          style: const TextStyle(color: kColorDarkGreyText),
                          decoration: InputDecoration(
                            // floatingLabelStyle:
                            // const TextStyle(color: kColorPrimary),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: kColorFieldsBorders,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                  color: kColorPrimary,
                                )),
                            hintText: 'Enter Address 1',
                            hintStyle:
                                const TextStyle(color: kColorFieldsBorders),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Text(
                                '${address1DeliveryController.text.length}',
                                style:
                                    const TextStyle(color: kColorDarkGreyText),
                              )
                            ],
                          ),
                        ),
                        widget.selectedCountryId == 16
                            ? const SizedBox(
                                height: 5,
                              )
                            : const SizedBox(),
                        widget.selectedCountryId == 16
                            ? const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Note : Address 1 should contains at least 25 characters.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: kColorOrangeText,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Delivery Address 2 ${widget.selectedCountryId == 226 ? '' : '(Optional)'}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: address2DeliveryController,
                          textCapitalization: TextCapitalization.words,
                          style: const TextStyle(color: kColorDarkGreyText),
                          decoration: InputDecoration(
                            // floatingLabelStyle:
                            // const TextStyle(color: kColorPrimary),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: kColorFieldsBorders,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                  color: kColorPrimary,
                                )),
                            hintText: 'Enter Address 2',
                            hintStyle:
                                const TextStyle(color: kColorFieldsBorders),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Text(
                                '${address2DeliveryController.text.length}',
                                style:
                                    const TextStyle(color: kColorDarkGreyText),
                              )
                            ],
                          ),
                        ),
                        widget.selectedCountryId == 16
                            ? const SizedBox(
                                height: 5,
                              )
                            : const SizedBox(),
                        widget.selectedCountryId == 16
                            ? const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Note : Address should contains at least 25 characters.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: kColorOrangeText,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Delivery Phone Number',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                width: screenSize.width * 0.25,
                                height: screenSize.height * 0.06,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kColorFieldsBorders, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                  color: kColorWhite,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _chooseCountryCodeDelivery == ''
                                          ? 'CC'
                                          : _chooseCountryCodeDelivery,
                                      style: const TextStyle(
                                        color: kColorDarkGreyText,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: kColorDarkGreyText,
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                _countryCodePickerDialog(deliveryPhone: true);
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: screenSize.height * 0.06,
                              width: screenSize.width * 0.6,
                              child: TextField(
                                controller: phoneDeliveryNumberController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                // readOnly: AppGlobal.phoneVerified == 'N'
                                //     ? true
                                //     : false,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                style:
                                    const TextStyle(color: kColorDarkGreyText),
                                decoration: InputDecoration(
                                    // floatingLabelStyle:
                                    // const TextStyle(color: kColorPrimary),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: const BorderSide(
                                        color: kColorFieldsBorders,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        borderSide: const BorderSide(
                                          color: kColorPrimary,
                                        )),
                                    hintText: 'Add number',
                                    hintStyle: const TextStyle(
                                        color: kColorFieldsBorders)),
                              ),
                            ),
                          ],
                        ),
                        //ToDo: Verify the  number before adding
                        // AppGlobal.phoneVerified == 'N' ||
                        //         AppGlobal.phoneChangeVerify == false
                        //     ? Column(
                        //         children: [
                        //           const SizedBox(
                        //             height: 10,
                        //           ),
                        //           InkWell(
                        //             onTap: () {
                        //               // _loginBloc.add(ResendOTPSignUpUser(
                        //               //   email: AppGlobal.emailAddress,
                        //               // ));
                        //               if (_chooseCountryCode.length > 1 &&
                        //                   phoneNumberController.text.length >
                        //                       7) {
                        //                 Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                     builder: (context) =>
                        //                         CodeVerificationScreen(
                        //                       moduleName:
                        //                           'phoneChangeEditProfile',
                        //                       userEmail: _chooseCountryCode +
                        //                           phoneNumberController.text,
                        //                     ),
                        //                   ),
                        //                 );
                        //               } else {
                        //                 Fluttertoast.showToast(
                        //                     msg:
                        //                         'Please enter a valid phone number',
                        //                     toastLength: Toast.LENGTH_SHORT,
                        //                     gravity: ToastGravity.BOTTOM,
                        //                     timeInSecForIosWeb: 1,
                        //                     backgroundColor:
                        //                         Colors.grey.shade400,
                        //                     textColor: Colors.white,
                        //                     fontSize: 12.0);
                        //               }
                        //             },
                        //             child: Column(
                        //               children: const [
                        //                 Text.rich(
                        //                   TextSpan(
                        //                     children: [
                        //                       TextSpan(
                        //                         text:
                        //                             'Note:Email not verified. To update profile you have to verify the email first. ',
                        //                         style: TextStyle(
                        //                             color: kColorFieldsBorders),
                        //                       ),
                        //                       TextSpan(
                        //                         text: 'Verify email?',
                        //                         style: TextStyle(
                        //                             color: Colors.blue,
                        //                             fontWeight:
                        //                                 FontWeight.bold),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        //     : SizedBox(),

                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Delivery Zip Code',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: screenSize.height * 0.06,
                          child: TextField(
                            controller: zipCodeDeliveryController,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: const TextStyle(color: kColorDarkGreyText),
                            decoration: InputDecoration(
                              // floatingLabelStyle:
                              // const TextStyle(color: kColorPrimary),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                  color: kColorFieldsBorders,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: const BorderSide(
                                    color: kColorPrimary,
                                  )),
                              hintText: 'Enter Zip Code',
                              hintStyle:
                                  const TextStyle(color: kColorFieldsBorders),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        widget.selectedCountryId == 226
                            ? const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Delivery State',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              )
                            : const SizedBox(),

                        widget.selectedCountryId == 16
                            ? const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Delivery City',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 5,
                        ),
                        pathaoCitiesResponse.cities.isNotEmpty
                            ? Container(
                                width: screenSize.width * 0.93,
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(
                                    width: 1,
                                    color:
                                        kColorFieldsBorders, //                   <--- border width here
                                  ),
                                ),
                                child: DropdownButton(
                                  hint: Text(
                                      selectedDeliveryCity == ''
                                          ? 'Select'
                                          : selectedDeliveryCity,
                                      style: const TextStyle(
                                        color: kColorDarkGreyText,
                                      )),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  dropdownColor: kColorWidgetBackgroundColor,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: kColorDarkGreyIcon,
                                    size: 25,
                                  ),
                                  iconSize: 36,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  onChanged: (valueItem) {},
                                  items: pathaoCitiesResponse.cities
                                      .map((valueItem) {
                                    return DropdownMenuItem(
                                      child: Text(valueItem.cityName),
                                      value: valueItem,
                                      onTap: () {
                                        setState(() {
                                          selectedDeliveryCity =
                                              valueItem.cityName;
                                          selectedDeliveryCityId =
                                              valueItem.cityId;
                                          selectedTempCityIdDelivery =
                                              valueItem.DBCityID;
                                          if (selectedDeliveryCityId != 0) {
                                            if (selectedDeliveryCity !=
                                                widget.cartDetailsResponse
                                                    .productCartList[0].City) {
                                              productsAndUserCitiesAreSame =
                                                  false;
                                            }
                                            if (productsAndUserCitiesAreSame ==
                                                true) {
                                              print(
                                                  '>>>>>>>>>>>>>>Delivery Driver Api going to hit');
                                              checkDeliveryDriverModel =
                                                  CheckDeliveryDriverModel(
                                                      CityName:
                                                          selectedDeliveryCity);
                                              print(
                                                  '>>>>>>>>>>>>>>Checking Driver Availability');
                                              _cartBloc.add(CheckDriverAvailability(
                                                  checkDeliveryDriverModel:
                                                      checkDeliveryDriverModel!));
                                            }
                                            selectedDeliveryZone = '';
                                            selectedDeliveryZoneId = 0;
                                            pathaoZoneModel = PathaoZoneModel(
                                                token:
                                                    pathaoAccessTokenResponse!
                                                        .token,
                                                cityId: selectedDeliveryCityId
                                                    .toString());
                                            print(
                                                '>>>>>>>>>>>>>>Getting Pathao Zones');
                                            _cartBloc.add(GetPathaoZones(
                                                pathaoZoneModel:
                                                    pathaoZoneModel!));
                                          }

                                          ///Delivery Custom Checks

                                          if (widget.shippingAvailable ==
                                                  false &&
                                              widget.globalShipping == false) {
                                            if (widget.shippingAvailableCity
                                                    .trim() ==
                                                selectedDeliveryCity.trim()) {
                                              checkDeliveryConditionsProceed =
                                                  true;
                                              print(
                                                  '>>>>>>>>Condition 1(a): Country is same && Cities of all products and delivery city should be same implement loop on next page');
                                            } else {
                                              checkDeliveryConditionsProceed =
                                                  false;
                                              checkDeliveryConditionsProceedReason =
                                                  'Delivery of these products is only available in ${widget.shippingAvailableCity}';
                                              print(
                                                  '>>>>>>>>Condition 1(a): Error');
                                            }
                                          } else if (widget.shippingAvailable ==
                                                  false &&
                                              widget.globalShipping == true) {
                                            if (widget.shippingAvailableCity
                                                    .trim() ==
                                                selectedDeliveryCity.trim()) {
                                              checkDeliveryConditionsProceed =
                                                  true;
                                              print(
                                                  '>>>>>>>>Condition 2(a): Country is same && Cities of all products and delivery city should be same implement loop on next page');
                                            } else {
                                              checkDeliveryConditionsProceed =
                                                  false;
                                              checkDeliveryConditionsProceedReason =
                                                  'Delivery of these products is only available in ${widget.shippingAvailableCity}';
                                              print(
                                                  '>>>>>>>>Condition 2(a): Error');
                                            }
                                          } else if (widget.shippingAvailable ==
                                                  true &&
                                              widget.globalShipping == false) {
                                            if (widget.selectedCountryId ==
                                                widget
                                                    .shippingAvailableCountryID) {
                                              checkDeliveryConditionsProceed =
                                                  true;
                                              print(
                                                  '>>>>>>>>Condition 3(a): Country Should be same and can choose any city, cities product should,shouldn\'t be same on next page');
                                            } else {
                                              checkDeliveryConditionsProceed =
                                                  false;
                                              checkDeliveryConditionsProceedReason =
                                                  'Delivery of these products is not same';
                                              print(
                                                  '>>>>>>>>Condition 3(a): Error');
                                            }
                                          } else if (widget.shippingAvailable ==
                                                  true &&
                                              widget.globalShipping == true) {
                                            checkDeliveryConditionsProceed =
                                                true;
                                          }
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              )
                            : Container(
                                height: screenSize.height * 0.06,
                                child: TextField(
                                  textCapitalization: TextCapitalization.words,
                                  onChanged: (value) {
                                    selectedDeliveryCity = value;
                                    //print(selectedState);
                                  },
                                  style: const TextStyle(
                                      color: kColorDarkGreyText),
                                  decoration: InputDecoration(
                                    // floatingLabelStyle:
                                    // const TextStyle(color: kColorPrimary),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: const BorderSide(
                                        color: kColorFieldsBorders,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        borderSide: const BorderSide(
                                          color: kColorPrimary,
                                        )),
                                    hintText: 'Enter City',
                                    hintStyle: const TextStyle(
                                        color: kColorFieldsBorders),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Delivery Zone',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        pathaoZonesResponse.zones.isNotEmpty
                            ? Container(
                                width: screenSize.width * 0.93,
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(
                                    width: 1,
                                    color:
                                        kColorFieldsBorders, //                   <--- border width here
                                  ),
                                ),
                                child: DropdownButton(
                                  hint: Text(
                                      selectedDeliveryZone == ''
                                          ? 'Select'
                                          : selectedDeliveryZone,
                                      style: const TextStyle(
                                        color: kColorDarkGreyText,
                                      )),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  dropdownColor: kColorWidgetBackgroundColor,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: kColorDarkGreyIcon,
                                    size: 25,
                                  ),
                                  iconSize: 36,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  onChanged: (valueItem) {},
                                  items: pathaoZonesResponse.zones
                                      .map((valueItem) {
                                    return DropdownMenuItem(
                                      child: Text(valueItem.zoneName),
                                      value: valueItem,
                                      onTap: () {
                                        setState(() {
                                          selectedDeliveryZone =
                                              valueItem.zoneName;
                                          selectedDeliveryZoneId =
                                              valueItem.zoneId;
                                          if (selectedDeliveryZoneId != 0) {
                                            selectedDeliveryArea = '';
                                            selectedDeliveryAreaId = 0;
                                            pathaoAreaModel = PathaoAreaModel(
                                                token:
                                                    pathaoAccessTokenResponse!
                                                        .token,
                                                zoneId: selectedDeliveryZoneId
                                                    .toString());
                                            print(
                                                '>>>>>>>>>>>>>>>>>>> Getting Pathao Areas');
                                            _cartBloc.add(GetPathaoAreas(
                                                pathaoAreaModel:
                                                    pathaoAreaModel!));

                                            late List<String> productIDs = [];

                                            for (int p = 0;
                                                p <
                                                    widget.cartDetailsResponse
                                                        .productCartList.length;
                                                p++) {
                                              productIDs.add(widget
                                                  .cartDetailsResponse
                                                  .productCartList[p]
                                                  .ProductID
                                                  .toString());
                                            }
                                            pathaoPriceCalculationModel =
                                                PathaoPriceCalculationModel(
                                                    token:
                                                        pathaoAccessTokenResponse!
                                                            .token,
                                                    recipientCity:
                                                        selectedDeliveryCityId
                                                            .toString(),
                                                    recipientZone:
                                                        selectedDeliveryZoneId
                                                            .toString(),
                                                    ProductIDs: productIDs,
                                                    DBCityID:
                                                        selectedTempCityIdDelivery
                                                            .toString());
                                            log(pathaoPriceCalculationModel!
                                                .toJson()
                                                .toString());
                                            log('>>>>>>>>>>>>>>>>>>> Pathao Price Calculation: ${pathaoPriceCalculationModel!.toJson()}');
                                            _cartBloc.add(PathaoPriceCalculation(
                                                pathaoPriceCalculationModel:
                                                    pathaoPriceCalculationModel!));
                                          }
                                          // paymentUserData!.cityID = valueItem.CityID;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              )
                            : Container(
                                height: screenSize.height * 0.06,
                                child: TextField(
                                  textCapitalization: TextCapitalization.words,
                                  onChanged: (value) {
                                    selectedDeliveryZone = value;
                                    //print(selectedState);
                                  },
                                  style: const TextStyle(
                                      color: kColorDarkGreyText),
                                  decoration: InputDecoration(
                                    // floatingLabelStyle:
                                    // const TextStyle(color: kColorPrimary),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: const BorderSide(
                                        color: kColorFieldsBorders,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        borderSide: const BorderSide(
                                          color: kColorPrimary,
                                        )),
                                    hintText: 'Enter Zone',
                                    hintStyle: const TextStyle(
                                        color: kColorFieldsBorders),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Delivery Area',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        pathaoAreaResponse.areas.isNotEmpty
                            ? Container(
                                width: screenSize.width * 0.93,
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(
                                    width: 1,
                                    color:
                                        kColorFieldsBorders, //                   <--- border width here
                                  ),
                                ),
                                child: DropdownButton(
                                  hint: Text(
                                      selectedDeliveryArea == ''
                                          ? 'Select'
                                          : selectedDeliveryArea,
                                      style: const TextStyle(
                                        color: kColorDarkGreyText,
                                      )),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  dropdownColor: kColorWidgetBackgroundColor,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: kColorDarkGreyIcon,
                                    size: 25,
                                  ),
                                  iconSize: 36,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  onChanged: (valueItem) {},
                                  items:
                                      pathaoAreaResponse.areas.map((valueItem) {
                                    return DropdownMenuItem(
                                      child: Text(valueItem.areaName),
                                      value: valueItem,
                                      onTap: () {
                                        setState(() {
                                          selectedDeliveryArea =
                                              valueItem.areaName;
                                          selectedDeliveryAreaId =
                                              valueItem.areaId;

                                          // paymentUserData!.cityID = valueItem.CityID;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              )
                            : Container(
                                height: screenSize.height * 0.06,
                                child: TextField(
                                  textCapitalization: TextCapitalization.words,
                                  onChanged: (value) {
                                    selectedDeliveryArea = value;
                                    //print(selectedState);
                                  },
                                  style: const TextStyle(
                                      color: kColorDarkGreyText),
                                  decoration: InputDecoration(
                                    // floatingLabelStyle:
                                    // const TextStyle(color: kColorPrimary),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: const BorderSide(
                                        color: kColorFieldsBorders,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        borderSide: const BorderSide(
                                          color: kColorPrimary,
                                        )),
                                    hintText: 'Enter Area',
                                    hintStyle: const TextStyle(
                                        color: kColorFieldsBorders),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Desire Date',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [
                            Container(
                              height: screenSize.height * 0.06,
                              child: TextField(
                                controller: createdDateController,
                                style:
                                    const TextStyle(color: kColorDarkGreyText),
                                readOnly: true,
                                decoration: InputDecoration(
                                    // floatingLabelStyle:
                                    // const TextStyle(color: kColorPrimary),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: const BorderSide(
                                        color: kColorFieldsBorders,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        borderSide: const BorderSide(
                                          color: kColorPrimary,
                                        )),
                                    hintText: 'dd/mm/yyyy',
                                    hintStyle: const TextStyle(
                                        color: kColorFieldsBorders)),
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  _pickDate();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                        MyFlutterApp.icon_calendar_outlined),
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Delivery Address Label',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: screenSize.height * 0.06,
                          child: TextField(
                            textCapitalization: TextCapitalization.words,
                            controller: deliveryAddressNickName,
                            style: const TextStyle(color: kColorDarkGreyText),
                            decoration: InputDecoration(
                              // floatingLabelStyle:
                              // const TextStyle(color: kColorPrimary),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                  color: kColorFieldsBorders,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: const BorderSide(
                                    color: kColorPrimary,
                                  )),
                              hintText: 'Enter Label',
                              hintStyle:
                                  const TextStyle(color: kColorFieldsBorders),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.grey),
                                child: Checkbox(
                                  value: saveDeliveryAddress,
                                  onChanged: (state) {
                                    if (saveDeliveryAddress) {
                                      saveDeliveryAddress = false;
                                    } else {
                                      saveDeliveryAddress = true;
                                    }

                                    setState(() {});
                                  },
                                  activeColor: kColorPrimary,
                                  checkColor: Colors.white,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                )),
                            const Text('Save delivery address')
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Delivery Order Note (Optional)',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Container(
                          height: screenSize.height * 0.3,
                          width: screenSize.width,
                          decoration: const BoxDecoration(
                            boxShadow: [],
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: kColorWhite,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.text,
                              controller: adminDeliveryNoteController,
                              //focusNode: fObservation,
                              // maxLength: 200,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  //charLength = value.length;
                                });
                                //print('$value,$charLength');
                              },
                              maxLines: 8,
                              cursorColor: kColorPrimary,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                // hintText: getTranslated(context,
                                //     'typeherestartdictation'),
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 20, 40, 0),
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(
                                      color: kColorFieldsBorders, width: 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(
                                      color: kColorFieldsBorders, width: 1),
                                ),
                              ),
                            ),
                          ),
                        ),

                        getShippingDetailsResponse != null
                            ? getShippingDetailsResponse!.banglaBazarPickup ==
                                    true
                                ? const SizedBox(
                                    height: 25,
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                        getShippingDetailsResponse != null
                            ? getShippingDetailsResponse!.banglaBazarPickup ==
                                    true
                                ? const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Bangla Bazar Delivery',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                        getShippingDetailsResponse != null
                            ? getShippingDetailsResponse!.banglaBazarPickup ==
                                    true
                                ? const SizedBox(
                                    height: 10,
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                        getShippingDetailsResponse != null
                            ? getShippingDetailsResponse!.banglaBazarPickup ==
                                    true
                                ? Row(
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: kColorDarkGreyIcon,
                                                  ),
                                                  child: Center(
                                                      child: Container(
                                                    width: 18,
                                                    height: 18,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: kColorWhite,
                                                    ),
                                                    child: Center(
                                                        child: Container(
                                                      width: 13,
                                                      height: 13,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            banglaBazarPickup ==
                                                                    true
                                                                ? kColorPrimary
                                                                : kColorWhite,
                                                      ),
                                                    )),
                                                  )),
                                                ),
                                                onTap: () {
                                                  if (banglaBazarPickup ==
                                                      false) {
                                                    setState(() {
                                                      banglaBazarPickup = true;
                                                      pickUpAvailable = false;
                                                    });
                                                  }
                                                },
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'Yes',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 75,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: kColorDarkGreyIcon,
                                                  ),
                                                  child: Center(
                                                      child: Container(
                                                    width: 18,
                                                    height: 18,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: kColorWhite,
                                                    ),
                                                    child: Center(
                                                        child: Container(
                                                      width: 13,
                                                      height: 13,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            banglaBazarPickup ==
                                                                    false
                                                                ? kColorPrimary
                                                                : kColorWhite,
                                                      ),
                                                    )),
                                                  )),
                                                ),
                                                onTap: () {
                                                  if (banglaBazarPickup ==
                                                      true) {
                                                    setState(() {
                                                      banglaBazarPickup = false;
                                                    });
                                                  }
                                                },
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'No',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                        getShippingDetailsResponse != null
                            ? getShippingDetailsResponse!.banglaBazarPickup ==
                                    true
                                ? const SizedBox(
                                    height: 25,
                                  )
                                : const SizedBox()
                            : const SizedBox(),

                        getShippingDetailsResponse != null
                            ? getShippingDetailsResponse!.pickUpByUser == true
                                ? selectedCityDelivery ==
                                        widget.cartDetailsResponse
                                            .productCartList[0].City
                                    ? const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Pick up',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      )
                                    : const SizedBox()
                                : const SizedBox()
                            : const SizedBox(),
                        getShippingDetailsResponse != null
                            ? getShippingDetailsResponse!.pickUpByUser == true
                                ? const SizedBox(
                                    height: 10,
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                        getShippingDetailsResponse != null
                            ? getShippingDetailsResponse!.pickUpByUser == true
                                ? selectedCityDelivery ==
                                        widget.cartDetailsResponse
                                            .productCartList[0].City
                                    ? Row(
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            kColorDarkGreyIcon,
                                                      ),
                                                      child: Center(
                                                          child: Container(
                                                        width: 18,
                                                        height: 18,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: kColorWhite,
                                                        ),
                                                        child: Center(
                                                            child: Container(
                                                          width: 13,
                                                          height: 13,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: pickUpAvailable ==
                                                                    true
                                                                ? kColorPrimary
                                                                : kColorWhite,
                                                          ),
                                                        )),
                                                      )),
                                                    ),
                                                    onTap: () {
                                                      if (pickUpAvailable ==
                                                          false) {
                                                        setState(() {
                                                          pickUpAvailable =
                                                              true;
                                                          banglaBazarPickup =
                                                              false;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 75,
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            kColorDarkGreyIcon,
                                                      ),
                                                      child: Center(
                                                          child: Container(
                                                        width: 18,
                                                        height: 18,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: kColorWhite,
                                                        ),
                                                        child: Center(
                                                            child: Container(
                                                          width: 13,
                                                          height: 13,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: pickUpAvailable ==
                                                                    false
                                                                ? kColorPrimary
                                                                : kColorWhite,
                                                          ),
                                                        )),
                                                      )),
                                                    ),
                                                    onTap: () {
                                                      if (pickUpAvailable ==
                                                          true) {
                                                        setState(() {
                                                          pickUpAvailable =
                                                              false;
                                                          banglaBazarPickup =
                                                              true;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    : const SizedBox()
                                : const SizedBox()
                            : const SizedBox(),
                        getShippingDetailsResponse != null
                            ? getShippingDetailsResponse!.pickUpByUser == true
                                ? const SizedBox(
                                    height: 25,
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: screenSize.height * 0.065,
                                width: screenSize.width * 0.43,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                      Border.all(color: kColorFieldsBorders),
                                  color: kColorWhite,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Previous',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: kColorDarkGreyText,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                /// Check inventory
                                _cartBloc.add(CheckInventory(
                                    cartDetailsResponseTemp:
                                        widget.cartDetailsResponse));
                              },
                              child: Container(
                                height: screenSize.height * 0.065,
                                width: screenSize.width * 0.43,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: kColorPrimary,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Next',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: kColorWhite, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenSize.height * 0.2,
                        ),
                      ],
                    ),
                  ),
                ),

                ///This is appbar
                Column(
                  children: [
                    Container(
                      color: kColorWhite,
                      width: screenSize.width,
                      height: screenSize.height * 0.042,
                    ),
                    Container(
                      color: kColorWhite,
                      width: screenSize.width,
                      height: screenSize.height * 0.09,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/BanglaBazarLogo.png',
                              width: screenSize.width * 0.50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      );
    });
  }

  final picker = ImagePicker();

  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
    );

    if (date != null) {
      pickedDate = date;

      print('picked Date' + pickedDate.toString());
      createdDateController.text =
          DateFormat('yyyy-MM-dd').format(pickedDate).toString();
      setState(() {});
    }
  }

  Widget _buildDialogItem(country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          const SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: const InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: const Text('Select your country'),
            onValuePicked: (country) {
              setState(() => _selectedDialogCountry = country);

              for (int i = 0;
                  i < widget.allowedCountriesResponse.countries.length;
                  i++) {
                if (widget.allowedCountriesResponse.countries[i].ISO2 ==
                    _selectedDialogCountry.isoCode) {
                  if (selectedPaymentCountryID !=
                      widget.allowedCountriesResponse.countries[i].CountryID) {
                    // widget.allowedVendorStatesResponse!.states.clear();
                    // widget.allowedVendorCityResponse!.cities.clear();
                  }
                  selectedPaymentCountryID =
                      widget.allowedCountriesResponse.countries[i].CountryID;
                  if (selectedPaymentCountryID == 16) {
                    nameController.text = AppGlobal.userName;
                  } else {
                    nameController.text = '';
                  }
                  countryPaymentSelected = true;

                  break;
                }
              }
            },

            itemFilter: (c) =>
                widget.allowedCountriesISO2List.contains(c.isoCode),
            itemBuilder: _buildDialogItem,
            // priorityList: [
            //   CountryPickerUtils.getCountryByIsoCode('TR'),
            //   CountryPickerUtils.getCountryByIsoCode('US'),
            // ],
          ),
        ),
      );
  void _countryCodePickerDialog({required bool deliveryPhone}) => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: const InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: const Text('Select your phone code'),
            onValuePicked: (country) {
              _chooseCountryCodeDelivery = '+' + country.phoneCode;

              setState(() {});
            },

            itemFilter: (c) =>
                widget.allowedCountriesISO2List.contains(c.isoCode),
            itemBuilder: _buildDialogItem,
            // priorityList: [
            //   CountryPickerUtils.getCountryByIsoCode('TR'),
            //   CountryPickerUtils.getCountryByIsoCode('US'),
            // ],
          ),
        ),
      );
}

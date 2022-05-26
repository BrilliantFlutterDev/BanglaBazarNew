// import 'dart:io';
//
// import 'package:bangla_bazar/ModelClasses/allowed_countries_list_response.dart';
// import 'package:bangla_bazar/ModelClasses/allowed_vendor_city_response.dart';
// import 'package:bangla_bazar/ModelClasses/allowed_vendor_states_response.dart';
// import 'package:bangla_bazar/ModelClasses/card_details_response.dart';
// import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
// import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
// import 'package:bangla_bazar/ModelClasses/check_delivery_driver_model.dart';
// import 'package:bangla_bazar/ModelClasses/check_delivery_driver_response.dart';
// import 'package:bangla_bazar/ModelClasses/delivery_products_check_model.dart';
// import 'package:bangla_bazar/ModelClasses/get_shipping_status_response.dart';
// import 'package:bangla_bazar/ModelClasses/pathao_access_token_response.dart';
// import 'package:bangla_bazar/ModelClasses/pathao_area_model.dart';
// import 'package:bangla_bazar/ModelClasses/pathao_area_response.dart';
// import 'package:bangla_bazar/ModelClasses/pathao_cities_response.dart';
// import 'package:bangla_bazar/ModelClasses/pathao_price_calculation_model.dart';
// import 'package:bangla_bazar/ModelClasses/pathao_price_calculation_response.dart';
// import 'package:bangla_bazar/ModelClasses/pathao_token_model.dart';
// import 'package:bangla_bazar/ModelClasses/pathao_zone_model.dart';
// import 'package:bangla_bazar/ModelClasses/pathao_zones_response.dart';
// import 'package:bangla_bazar/ModelClasses/payment_history_response.dart';
// import 'package:bangla_bazar/ModelClasses/payment_user_data.dart';
// import 'package:bangla_bazar/ModelClasses/usps_address_verify_model.dart';
// import 'package:bangla_bazar/ModelClasses/usps_address_verify_response.dart'
//     as uspsAddress;
// import 'package:bangla_bazar/ModelClasses/usps_rate_calculation_model.dart';
// import 'package:bangla_bazar/ModelClasses/usps_rate_calculation_response.dart';
// import 'package:bangla_bazar/Utils/app_colors.dart';
// import 'package:bangla_bazar/Utils/app_global.dart';
// import 'package:bangla_bazar/Utils/icons.dart';
// import 'package:bangla_bazar/Utils/modalprogresshud.dart';
// import 'package:bangla_bazar/Views/AuthenticationScreens/business_registration_screen3.dart';
// import 'package:bangla_bazar/Views/AuthenticationScreens/code_verfication.dart';
// import 'package:bangla_bazar/Views/Cart/CartBloc/cart_bloc.dart';
// import 'package:bangla_bazar/Views/Cart/checkout_payment_screen.dart';
// import 'package:bangla_bazar/Widgets/bottom_sheet_choose_pic_source_widget.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:country_pickers/country_picker_dialog.dart';
// import 'package:country_pickers/utils/utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
//
// class CheckoutAddressScreen extends StatefulWidget {
//   CartDetailsResponse cartDetailsResponse;
//   var allowedCountriesISO2List;
//   AllowedCountriesResponse allowedCountriesResponse;
//   int selectedCountryId;
//   AllowedVendorStatesResponse? allowedVendorStatesResponse;
//   AllowedVendorCityResponse? allowedVendorCityResponse;
//   bool creditCardPayment;
//   UserPaymentHistory? userPaymentHistory;
//   CheckoutAddressScreen(
//       {Key? key,
//       required this.cartDetailsResponse,
//       required this.allowedCountriesISO2List,
//       required this.allowedCountriesResponse,
//       required this.selectedCountryId,
//       required this.allowedVendorStatesResponse,
//       required this.allowedVendorCityResponse,
//       required this.creditCardPayment,
//       this.userPaymentHistory})
//       : super(key: key);
//   @override
//   _CheckoutAddressScreenState createState() => _CheckoutAddressScreenState();
// }
//
// class _CheckoutAddressScreenState extends State<CheckoutAddressScreen> {
//   late CartBloc _cartBloc;
//
//   /// For payment address
//   TextEditingController nameController = TextEditingController();
//   TextEditingController address1Controller = TextEditingController();
//   TextEditingController address2Controller = TextEditingController();
//   TextEditingController zipCodeController = TextEditingController();
//
//   TextEditingController adminNoteController = TextEditingController();
//
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController createdDateController = TextEditingController();
//
//   late String _chooseCountryCode = '';
//
//   PhoneNumber phoneNumber = PhoneNumber();
//   final TextEditingController controller = TextEditingController();
//
//   late DateTime pickedDate;
//   late String selectedState = '';
//   late String selectedCity = '';
//   late int selectedCityId = 0;
//
//   late String selectedZone = '';
//   late int selectedZoneId = 0;
//
//   late String selectedArea = '';
//   late int selectedAreaId = 0;
//
//   late String selectedDeliveryCity = '';
//   late int selectedDeliveryCityId = 0;
//
//   late String selectedDeliveryZone = '';
//   late int selectedDeliveryZoneId = 0;
//
//   late String selectedDeliveryArea = '';
//   late int selectedDeliveryAreaId = 0;
//
//   PaymentUserData? paymentUserData;
//   var _selectedDialogCountry;
//
//   DeliveryProductsCheckModel? deliveryProductsCheckModel;
//   GetShippingDetailsResponse? getShippingDetailsResponse;
//
//   /// for delivery addresss
//
//   TextEditingController nameDeliveryController = TextEditingController();
//   TextEditingController address1DeliveryController = TextEditingController();
//   TextEditingController address2DeliveryController = TextEditingController();
//   TextEditingController zipCodeDeliveryController = TextEditingController();
//
//   TextEditingController adminDeliveryNoteController = TextEditingController();
//
//   TextEditingController phoneDeliveryNumberController = TextEditingController();
//   TextEditingController deliveryCityController = TextEditingController();
//
//   late String selectedStateDelivery = '';
//   late String selectedCityDelivery = '';
//   late int selectedCityIdDelivery = 0;
//
//   late String _chooseCountryCodeDelivery = '';
//
//   bool deliveryAddressFlag = false;
//
//   bool banglaBazarPickup = true;
//   bool pickUpAvailable = false;
//
//   PathaoAccessTokenResponse? pathaoAccessTokenResponse;
//   PathaoTokenModel? pathaoTokenModel;
//   PathaoCitiesResponse pathaoCitiesResponse =
//       PathaoCitiesResponse(status: true, cities: []);
//
//   PathaoZoneModel? pathaoZoneModel;
//   PathaoZonesResponse pathaoZonesResponse =
//       PathaoZonesResponse(status: true, zones: []);
//
//   PathaoAreaModel? pathaoAreaModel;
//   PathaoAreaResponse pathaoAreaResponse =
//       PathaoAreaResponse(status: true, areas: []);
//
//   PathaoPriceCalculationModel? pathaoPriceCalculationModel;
//   PathaoPriceCalculationResponse? pathaoPriceCalculationResponse;
//   double totalWeightOfAllProducts = 0.0;
//
//   bool productsAndUserCitiesAreSame = true;
//
//   CheckDeliveryDriverModel? checkDeliveryDriverModel;
//   CheckDeliveryDriverResponse? checkDeliveryDriverResponse;
//
//   uspsAddress.UspsAddressVerifyResponse? uspsAddressVerifyResponse;
//   UspsAddressVerifyModel? uspsAddressVerifyModel;
//   bool verifyUspsAddress = false;
//
//   UspsRateCalculationModel? uspsRateCalculationModel;
//   UspsRateCalculationResponse? uspsRateCalculationResponse;
//
//   double uspsTotalDeliveryAmount = 0.0;
//   int uspsProductItrator = 1;
//
//   int selectedPaymentCountryID = -1;
//
//   bool countryPaymentSelected = false;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     pickedDate = DateTime.now();
//
//     _cartBloc = BlocProvider.of<CartBloc>(context);
//     // _cartBloc.add(GetCartDetails());
//     // _cartBloc.add(GetVendorAllowedCountries());
//     deliveryProductsCheckModel = DeliveryProductsCheckModel(productDetail: []);
//     for (int i = 0;
//         i < widget.cartDetailsResponse.productCartList.length;
//         i++) {
//       deliveryProductsCheckModel!.productDetail.add(ProductDetail(
//           ProductID: widget.cartDetailsResponse.productCartList[i].ProductID
//               .toString()));
//
//       ///  below code is For delivery apis
//       totalWeightOfAllProducts = totalWeightOfAllProducts +
//           double.parse(widget.cartDetailsResponse.productCartList[i].Weight);
//       if (widget.cartDetailsResponse.productCartList[i].City !=
//           widget.cartDetailsResponse.productCartList[0].City) {
//         productsAndUserCitiesAreSame = false;
//       }
//     }
//     _cartBloc.add(GetShippingStatus(
//         deliveryProductsCheckModel: deliveryProductsCheckModel!));
//
//     if (widget.selectedCountryId == 16) {
//       if (widget.userPaymentHistory != null) {
//         nameController.text = widget.userPaymentHistory!.Name;
//         address1Controller.text = widget.userPaymentHistory!.Address1;
//         address2Controller.text = widget.userPaymentHistory!.Address2;
//         zipCodeController.text = widget.userPaymentHistory!.ZipCode;
//         selectedCity = widget.userPaymentHistory!.City;
//         //selectedZone=widget.userPaymentHistory!.
//       }
//       _cartBloc.add(GetPathaoAccessToken());
//     } else if (widget.selectedCountryId == 226) {}
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     return BlocConsumer<CartBloc, CartState>(listener: (context, state) {
//       if (state is LoadingState) {
//       } else if (state is ErrorState) {
//         Fluttertoast.showToast(
//             msg: state.error,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.grey.shade400,
//             textColor: Colors.white,
//             fontSize: 12.0);
//       } else if (state is InternetErrorState) {
//         Fluttertoast.showToast(
//             msg: state.error,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.grey.shade400,
//             textColor: Colors.white,
//             fontSize: 12.0);
//       }
//
//       else if (state is PathaoGetAccessTokenState) {
//         pathaoAccessTokenResponse = state.pathaoAccessTokenResponse;
//         pathaoTokenModel =
//             PathaoTokenModel(token: pathaoAccessTokenResponse!.token);
//         _cartBloc.add(GetPathaoCities(pathaoTokenModel: pathaoTokenModel!));
//       } else if (state is PathaoCitiesState) {
//         pathaoCitiesResponse = state.pathaoCitiesResponse;
//       } else if (state is PathaoZonesState) {
//         pathaoZonesResponse = state.pathaoZonesResponse;
//       } else if (state is PathaoAreasState) {
//         pathaoAreaResponse = state.pathaoAreaResponse;
//       } else if (state is PathaoPriceCalculationState) {
//         pathaoPriceCalculationResponse = state.pathaoPriceCalculationResponse;
//       } else if (state is CheckDriverAvailabilityState) {
//         checkDeliveryDriverResponse = state.checkDeliveryDriverResponse;
//         if (widget.selectedCountryId == 226) {
//           uspsRateCalculationModel = UspsRateCalculationModel(
//               originationZip: int.parse(widget
//                   .cartDetailsResponse.productCartList[0].VendorStoreZip!),
//               destinationZip: int.parse(zipCodeDeliveryController.text),
//               pounds: double.parse(
//                       widget.cartDetailsResponse.productCartList[0].Weight)
//                   .ceil(),
//               ounces: 1,
//               height: double.parse(
//                       widget.cartDetailsResponse.productCartList[0].Height)
//                   .ceil(),
//               width: double.parse(
//                       widget.cartDetailsResponse.productCartList[0].Width)
//                   .ceil(),
//               length: double.parse(
//                       widget.cartDetailsResponse.productCartList[0].Length)
//                   .ceil());
//           _cartBloc.add(UspsCalculateRate(
//               uspsRateCalculationModel: uspsRateCalculationModel!));
//         }
//       } else if (state is VerifyUspsAddressState) {
//         uspsAddressVerifyResponse = state.uspsAddressVerifyResponse;
//         if (uspsAddressVerifyResponse!.status == true) {
//           verifyUspsAddress = true;
//           selectedStateDelivery =
//               uspsAddressVerifyResponse!.data!.address.state.text;
//           selectedCityDelivery =
//               uspsAddressVerifyResponse!.data!.address.city.text;
//           deliveryCityController.text =
//               uspsAddressVerifyResponse!.data!.address.city.text;
//           address1DeliveryController.text =
//               uspsAddressVerifyResponse!.data!.address.address1.text;
//           address2DeliveryController.text =
//               uspsAddressVerifyResponse!.data!.address.address2.text;
//         } else {
//           verifyUspsAddress = false;
//           if (uspsAddressVerifyResponse!.message == 'Invalid City.  ') {
//             Fluttertoast.showToast(
//                 msg: 'Delivery Zip code is wrong.',
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.BOTTOM,
//                 timeInSecForIosWeb: 1,
//                 backgroundColor: Colors.grey.shade400,
//                 textColor: Colors.white,
//                 fontSize: 12.0);
//           } else if (uspsAddressVerifyResponse!.message ==
//               'Multiple addresses were found for the information you entered, and no default exists.') {
//             Fluttertoast.showToast(
//                 msg:
//                     'Delivery addresses are wrong. Multiple addresses were found for the information you entered.',
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.BOTTOM,
//                 timeInSecForIosWeb: 1,
//                 backgroundColor: Colors.grey.shade400,
//                 textColor: Colors.white,
//                 fontSize: 12.0);
//           }
//         }
//
//         //print(uspsAddressVerifyResponse!.data!.address.address1);
//       } else if (state is UspsCalculateRateState) {
//         uspsRateCalculationResponse = state.uspsRateCalculationResponse;
//         uspsTotalDeliveryAmount = uspsTotalDeliveryAmount +
//             double.parse(
//                 uspsRateCalculationResponse!.data!.Package.Postage.Rate.text);
//         if (uspsProductItrator <
//             widget.cartDetailsResponse.productCartList.length) {
//           uspsRateCalculationModel = UspsRateCalculationModel(
//               originationZip: int.parse(widget.cartDetailsResponse
//                   .productCartList[uspsProductItrator].VendorStoreZip!),
//               destinationZip:
//                   double.parse(zipCodeDeliveryController.text).ceil(),
//               pounds: double.parse(widget.cartDetailsResponse
//                       .productCartList[uspsProductItrator].Weight)
//                   .ceil(),
//               ounces: 1,
//               height: double.parse(widget.cartDetailsResponse
//                       .productCartList[uspsProductItrator].Height)
//                   .ceil(),
//               width: double.parse(widget.cartDetailsResponse
//                       .productCartList[uspsProductItrator].Width)
//                   .ceil(),
//               length: double.parse(widget.cartDetailsResponse.productCartList[uspsProductItrator].Length).ceil());
//           _cartBloc.add(UspsCalculateRate(
//               uspsRateCalculationModel: uspsRateCalculationModel!));
//           uspsProductItrator++;
//         } else {
//           uspsProductItrator = 1;
//
//           /// usps payment process
//           if (selectedCityDelivery != '') {
//             if (selectedCityDelivery !=
//                 widget.cartDetailsResponse.productCartList[0].City) {
//               pickUpAvailable = false;
//             }
//             paymentUserData = PaymentUserData(
//                 name: nameController.text,
//                 address1: address1Controller.text,
//                 address2: address2Controller.text,
//                 phoneCode: _chooseCountryCode,
//                 phoneNumber: phoneNumberController.text,
//                 country: 'USA',
//                 zipCode: zipCodeController.text,
//                 state: selectedState,
//                 city: selectedCity,
//                 createdAtDate: createdDateController.text,
//                 adminNote: adminNoteController.text,
//                 cityID: selectedCityId,
//                 countryID: widget.selectedCountryId,
//                 banglaBazarDelivery: banglaBazarPickup,
//                 pickUp: pickUpAvailable,
//                 address1Delivery:
//                     uspsAddressVerifyResponse!.data!.address.address1.text,
//                 address2Delivery:
//                     uspsAddressVerifyResponse!.data!.address.address2.text,
//                 adminNoteDelivery: adminDeliveryNoteController.text,
//                 phoneNumberDelivery: phoneDeliveryNumberController.text,
//                 nameDelivery: nameDeliveryController.text,
//                 zipCodeDelivery:
//                     uspsAddressVerifyResponse!.data!.address.zip5.text,
//                 stateDelivery:
//                     uspsAddressVerifyResponse!.data!.address.state.text,
//                 phoneCodeDelivery: _chooseCountryCodeDelivery,
//                 cityDelivery: selectedCityDelivery);
//
//             widget.cartDetailsResponse.cartTotalPrice =
//                 widget.cartDetailsResponse.cartTotalPrice +
//                     uspsTotalDeliveryAmount;
//
//             if (checkDeliveryDriverResponse != null) {
//               if (checkDeliveryDriverResponse!.deliveryDriverStatus == false) {
//                 productsAndUserCitiesAreSame = false;
//               } else if (checkDeliveryDriverResponse!.deliveryDriverStatus ==
//                   true) {
//                 productsAndUserCitiesAreSame = true;
//               }
//             }
//
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => CheckoutPaymentScreen(
//                   cartDetailsResponse: widget.cartDetailsResponse,
//                   paymentUserData: paymentUserData!,
//                   selectedZoneId: selectedZoneId,
//                   selectedCountryId: widget.selectedCountryId,
//                   selectedAreaId: selectedAreaId,
//                   selectedCityId: selectedCityId,
//                   productsAndUserCitiesAreSame: productsAndUserCitiesAreSame,
//                   creditCardPayment: widget.creditCardPayment,
//                 ),
//               ),
//             );
//           }
//         }
//         // if (uspsAddressVerifyResponse!.status == true) {
//         //   verifyUspsAddress = true;
//         // }
//       } else if (state is GetShippingStatusState) {
//         getShippingDetailsResponse = state.getShippingDetailsResponse;
//         if (AppGlobal.defaultPayment == 'Y') {
//           if (AppGlobal.nameOnCard != '') {
//             nameController.text = AppGlobal.nameOnCard;
//           }
//           // if (AppGlobal.address1 != '') {
//           //   address1Controller.text = AppGlobal.address1;
//           // }
//           // if (AppGlobal.address2 != '') {
//           //   address2Controller.text = AppGlobal.address2;
//           // }
//           // if (AppGlobal.zipCode != '') {
//           //   zipCodeController.text = AppGlobal.zipCode;
//           // }
//           // if (AppGlobal.userAddressCity != '') {
//           //   selectedCity = AppGlobal.userAddressCity;
//           // }
//           // if (AppGlobal.userAddressState != '') {
//           //   selectedState = AppGlobal.userAddressState;
//           // }
//           if (AppGlobal.countryId != -1) {
//             // widget.selectedCountryId = AppGlobal.countryId;
//
//             for (int i = 0;
//                 i < widget.allowedCountriesResponse.countries.length;
//                 i++) {
//               if (widget.allowedCountriesResponse.countries[i].CountryID ==
//                   widget.selectedCountryId) {
//                 ///se = allowedCountriesResponse.countries[i].Country;
//                 _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode(
//                     widget.allowedCountriesResponse.countries[i].ISO2);
//                 break;
//               }
//             }
//
//             // _cartBloc.add(GetVendorAllowedStates(id: widget.selectedCountryId));
//             // _cartBloc.add(GetVendorAllowedCities(id: widget.selectedCountryId));
//           }
//         }
//       }
//     }, builder: (context, state) {
//       return ModalProgressHUD(
//         inAsyncCall: state is LoadingState,
//         child: Scaffold(
//             backgroundColor: kColorWhite,
//             // extendBody: true,
//             // resizeToAvoidBottomInset: false,
//             body: Stack(
//               children: [
//                 ///This is the body
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           // color: Colors.yellow,
//                           width: screenSize.width,
//                           height: screenSize.height * 0.15,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 30,
//                               height: 30,
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: kColorPrimary,
//                                 // border: Border.all(
//                                 //     color: kColorDarkGreyText, width: 3),
//                                 // image: DecorationImage(
//                                 //   image: Image.asset("assets/icons/eyeicon.png",),
//                                 //   fit: BoxFit.cover,
//                                 // ),
//                               ),
//                               child: const Center(
//                                 child: Text(
//                                   '1',
//                                   style: TextStyle(
//                                       color: kColorWhite, fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: 1,
//                               width: screenSize.width * 0.26,
//                               color: kColorFieldsBorders,
//                             ),
//                             Container(
//                               width: 30,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: kColorWhite,
//                                 border: Border.all(
//                                     color: kColorFieldsBorders, width: 1),
//                                 // image: DecorationImage(
//                                 //   image: Image.asset("assets/icons/eyeicon.png",),
//                                 //   fit: BoxFit.cover,
//                                 // ),
//                               ),
//                               child: const Center(
//                                 child: Text(
//                                   '2',
//                                   style: TextStyle(
//                                       color: kColorFieldsBorders, fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: 1,
//                               width: screenSize.width * 0.26,
//                               color: kColorFieldsBorders,
//                             ),
//                             Container(
//                               width: 30,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: kColorWhite,
//                                 border: Border.all(
//                                     color: kColorFieldsBorders, width: 1),
//                                 // image: DecorationImage(
//                                 //   image: Image.asset("assets/icons/eyeicon.png",),
//                                 //   fit: BoxFit.cover,
//                                 // ),
//                               ),
//                               child: const Center(
//                                 child: Text(
//                                   '3',
//                                   style: TextStyle(
//                                       color: kColorFieldsBorders, fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Address',
//                               style:
//                                   TextStyle(color: Colors.black, fontSize: 14),
//                             ),
//                             Container(
//                               //height: 1,
//                               width: screenSize.width * 0.19,
//                               //color: kColorDarkGreyText,
//                             ),
//                             const Text(
//                               'Payment',
//                               style: TextStyle(
//                                   color: kColorFieldsBorders, fontSize: 14),
//                             ),
//                             Container(
//                               //height: 1,
//                               width: screenSize.width * 0.19,
//                               //color: kColorDarkGreyText,
//                             ),
//                             const Text(
//                               'Summary',
//                               style: TextStyle(
//                                   color: kColorFieldsBorders, fontSize: 14),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: screenSize.height * 0.07,
//                         ),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Payment Address',
//                             style:
//                                 TextStyle(fontSize: 18, color: kColorPrimary),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Payment Address Country',
//                             style: TextStyle(fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         countryPaymentSelected == false
//                             ? InkWell(
//                           onTap: _openCountryPickerDialog,
//                           child: Container(
//                             height: screenSize.height * 0.06,
//                             decoration: BoxDecoration(
//                                 borderRadius: const BorderRadius.all(
//                                     Radius.circular(5)),
//                                 color: kColorWhite,
//                                 border: Border.all(
//                                     color: kColorFieldsBorders)),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10),
//                               child: Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: const [
//                                   Text(
//                                     'Select Country',
//                                     style: TextStyle(
//                                         color: kColorFieldsBorders),
//                                   ),
//                                   Icon(Icons.arrow_drop_down_sharp)
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                             : Container(
//                           height: screenSize.height * 0.068,
//                           decoration: BoxDecoration(
//                               borderRadius: const BorderRadius.all(
//                                   Radius.circular(5)),
//                               color: kColorWhite,
//                               border:
//                               Border.all(color: kColorFieldsBorders)),
//                           child: Center(
//                             child: ListTile(
//                               onTap: _openCountryPickerDialog,
//                               title: _buildDialogItem(
//                                   _selectedDialogCountry),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Full Name',
//                             style: TextStyle(fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           height: screenSize.height * 0.06,
//                           child: TextField(
//                             controller: nameController,
//                             textCapitalization: TextCapitalization.words,
//                             style: const TextStyle(color: kColorDarkGreyText),
//                             decoration: InputDecoration(
//                               // floatingLabelStyle:
//                               // const TextStyle(color: kColorPrimary),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(6.0),
//                                 borderSide: const BorderSide(
//                                   color: kColorFieldsBorders,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(6.0),
//                                   borderSide: const BorderSide(
//                                     color: kColorPrimary,
//                                   )),
//                               hintText: 'Enter Full Name',
//                               hintStyle:
//                                   const TextStyle(color: kColorFieldsBorders),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Address 1',
//                             style: TextStyle(fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         TextField(
//                           controller: address1Controller,
//                           textCapitalization: TextCapitalization.words,
//                           style: const TextStyle(color: kColorDarkGreyText),
//                           decoration: InputDecoration(
//                             // floatingLabelStyle:
//                             // const TextStyle(color: kColorPrimary),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(6.0),
//                               borderSide: const BorderSide(
//                                 color: kColorFieldsBorders,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(6.0),
//                                 borderSide: const BorderSide(
//                                   color: kColorPrimary,
//                                 )),
//                             hintText: 'Enter Address 1',
//                             hintStyle:
//                                 const TextStyle(color: kColorFieldsBorders),
//                           ),
//                         ),
//
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'Note : Address 1 should contains at least 25 characters.',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: kColorOrangeText,
//                                   ),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Address 2 ${widget.selectedCountryId != 226 ? '(Optional)' : ''}',
//                             style: const TextStyle(
//                                 fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         TextField(
//                           controller: address2Controller,
//                           textCapitalization: TextCapitalization.words,
//                           style: const TextStyle(color: kColorDarkGreyText),
//                           decoration: InputDecoration(
//                             // floatingLabelStyle:
//                             // const TextStyle(color: kColorPrimary),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(6.0),
//                               borderSide: const BorderSide(
//                                 color: kColorFieldsBorders,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(6.0),
//                                 borderSide: const BorderSide(
//                                   color: kColorPrimary,
//                                 )),
//                             hintText: 'Enter Address 2',
//                             hintStyle:
//                                 const TextStyle(color: kColorFieldsBorders),
//                           ),
//                         ),
//                         widget.selectedCountryId != 226
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId != 226
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'Note : Address 2 should contains at least 25 characters.',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: kColorOrangeText,
//                                   ),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Phone Number',
//                             style: TextStyle(fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             InkWell(
//                               child: Container(
//                                 width: screenSize.width * 0.25,
//                                 height: screenSize.height * 0.06,
//                                 padding:
//                                     const EdgeInsets.only(left: 10, right: 10),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: kColorFieldsBorders, width: 1),
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: kColorWhite,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       _chooseCountryCode == ''
//                                           ? 'CC'
//                                           : _chooseCountryCode,
//                                       style: const TextStyle(
//                                         color: kColorDarkGreyText,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     const Icon(
//                                       Icons.keyboard_arrow_down_outlined,
//                                       color: kColorDarkGreyText,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               onTap: () {
//                                 _countryCodePickerDialog(deliveryPhone: false);
//                               },
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Container(
//                               height: screenSize.height * 0.06,
//                               width: screenSize.width * 0.6,
//                               child: TextField(
//                                 controller: phoneNumberController,
//                                 keyboardType: TextInputType.number,
//                                 inputFormatters: <TextInputFormatter>[
//                                   FilteringTextInputFormatter.digitsOnly
//                                 ],
//                                 // readOnly: AppGlobal.phoneVerified == 'N'
//                                 //     ? true
//                                 //     : false,
//                                 onChanged: (value) {
//                                   if (AppGlobal.phoneNumber !=
//                                       _chooseCountryCode +
//                                           phoneNumberController.text.trim()) {
//                                     AppGlobal.phoneChangeVerify = false;
//                                   } else {
//                                     AppGlobal.phoneChangeVerify = true;
//                                   }
//                                   setState(() {});
//                                 },
//                                 style:
//                                     const TextStyle(color: kColorDarkGreyText),
//                                 decoration: InputDecoration(
//                                     // floatingLabelStyle:
//                                     // const TextStyle(color: kColorPrimary),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       borderSide: const BorderSide(
//                                         color: kColorFieldsBorders,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(6.0),
//                                         borderSide: const BorderSide(
//                                           color: kColorPrimary,
//                                         )),
//                                     hintText: 'Add number',
//                                     hintStyle: const TextStyle(
//                                         color: kColorFieldsBorders)),
//                               ),
//                             ),
//                           ],
//                         ),
//                         //ToDo: Verify the  number before adding
//                         // AppGlobal.phoneVerified == 'N' ||
//                         //         AppGlobal.phoneChangeVerify == false
//                         //     ? Column(
//                         //         children: [
//                         //           const SizedBox(
//                         //             height: 10,
//                         //           ),
//                         //           InkWell(
//                         //             onTap: () {
//                         //               // _loginBloc.add(ResendOTPSignUpUser(
//                         //               //   email: AppGlobal.emailAddress,
//                         //               // ));
//                         //               if (_chooseCountryCode.length > 1 &&
//                         //                   phoneNumberController.text.length >
//                         //                       7) {
//                         //                 Navigator.push(
//                         //                   context,
//                         //                   MaterialPageRoute(
//                         //                     builder: (context) =>
//                         //                         CodeVerificationScreen(
//                         //                       moduleName:
//                         //                           'phoneChangeEditProfile',
//                         //                       userEmail: _chooseCountryCode +
//                         //                           phoneNumberController.text,
//                         //                     ),
//                         //                   ),
//                         //                 );
//                         //               } else {
//                         //                 Fluttertoast.showToast(
//                         //                     msg:
//                         //                         'Please enter a valid phone number',
//                         //                     toastLength: Toast.LENGTH_SHORT,
//                         //                     gravity: ToastGravity.BOTTOM,
//                         //                     timeInSecForIosWeb: 1,
//                         //                     backgroundColor:
//                         //                         Colors.grey.shade400,
//                         //                     textColor: Colors.white,
//                         //                     fontSize: 12.0);
//                         //               }
//                         //             },
//                         //             child: Column(
//                         //               children: const [
//                         //                 Text.rich(
//                         //                   TextSpan(
//                         //                     children: [
//                         //                       TextSpan(
//                         //                         text:
//                         //                             'Note:Email not verified. To update profile you have to verify the email first. ',
//                         //                         style: TextStyle(
//                         //                             color: kColorFieldsBorders),
//                         //                       ),
//                         //                       TextSpan(
//                         //                         text: 'Verify email?',
//                         //                         style: TextStyle(
//                         //                             color: Colors.blue,
//                         //                             fontWeight:
//                         //                                 FontWeight.bold),
//                         //                       ),
//                         //                     ],
//                         //                   ),
//                         //                 ),
//                         //               ],
//                         //             ),
//                         //           ),
//                         //         ],
//                         //       )
//                         //     : SizedBox(),
//
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Zip Code',
//                             style: TextStyle(fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           height: screenSize.height * 0.06,
//                           child: TextField(
//                             controller: zipCodeController,
//                             textCapitalization: TextCapitalization.words,
//                             keyboardType: TextInputType.number,
//                             inputFormatters: <TextInputFormatter>[
//                               FilteringTextInputFormatter.digitsOnly
//                             ],
//                             style: const TextStyle(color: kColorDarkGreyText),
//                             decoration: InputDecoration(
//                               // floatingLabelStyle:
//                               // const TextStyle(color: kColorPrimary),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(6.0),
//                                 borderSide: const BorderSide(
//                                   color: kColorFieldsBorders,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(6.0),
//                                   borderSide: const BorderSide(
//                                     color: kColorPrimary,
//                                   )),
//                               hintText: 'Enter Zip Code',
//                               hintStyle:
//                                   const TextStyle(color: kColorFieldsBorders),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         widget.selectedCountryId == 226
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'State',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 226
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 226
//                             ? widget.allowedVendorStatesResponse!.states
//                                     .isNotEmpty
//                                 ? Container(
//                                     width: screenSize.width * 0.93,
//                                     padding: const EdgeInsets.only(
//                                         left: 16, right: 16),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       border: Border.all(
//                                         width: 1,
//                                         color:
//                                             kColorFieldsBorders, //                   <--- border width here
//                                       ),
//                                     ),
//                                     child: DropdownButton(
//                                       hint: Text(
//                                           selectedState == ''
//                                               ? 'Select'
//                                               : selectedState,
//                                           style: const TextStyle(
//                                             color: kColorDarkGreyText,
//                                           )),
//                                       isExpanded: true,
//                                       underline: const SizedBox(),
//                                       dropdownColor:
//                                           kColorWidgetBackgroundColor,
//                                       icon: const Icon(
//                                         Icons.keyboard_arrow_down_rounded,
//                                         color: kColorDarkGreyIcon,
//                                         size: 25,
//                                       ),
//                                       iconSize: 36,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                       onChanged: (valueItem) {},
//                                       items: widget
//                                           .allowedVendorStatesResponse!.states
//                                           .map((valueItem) {
//                                         return DropdownMenuItem(
//                                           child: Text(valueItem.State),
//                                           value: valueItem,
//                                           onTap: () {
//                                             setState(() {
//                                               selectedState = valueItem.State;
//
//                                               ///Remove after testing usps delivery address
//                                               // if (selectedState != '') {
//                                               //   uspsAddressVerifyModel =
//                                               //       UspsAddressVerifyModel(
//                                               //           address1:
//                                               //               address1Controller
//                                               //                   .text,
//                                               //           address2:
//                                               //               address2Controller
//                                               //                   .text,
//                                               //           state: selectedState,
//                                               //           zip: zipCodeController
//                                               //               .text);
//                                               //   _cartBloc.add(VerifyUspsAddress(
//                                               //       uspsAddressVerifyModel:
//                                               //           uspsAddressVerifyModel!));
//                                               // }
//                                             });
//                                           },
//                                         );
//                                       }).toList(),
//                                     ),
//                                   )
//                                 : Container(
//                                     height: screenSize.height * 0.06,
//                                     child: TextField(
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       onChanged: (value) {
//                                         selectedState = value;
//                                         //print(selectedState);
//                                       },
//                                       style: const TextStyle(
//                                           color: kColorDarkGreyText),
//                                       decoration: InputDecoration(
//                                         // floatingLabelStyle:
//                                         // const TextStyle(color: kColorPrimary),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(6.0),
//                                           borderSide: const BorderSide(
//                                             color: kColorFieldsBorders,
//                                           ),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(6.0),
//                                             borderSide: const BorderSide(
//                                               color: kColorPrimary,
//                                             )),
//                                         hintText: 'Enter State',
//                                         hintStyle: const TextStyle(
//                                             color: kColorFieldsBorders),
//                                       ),
//                                     ),
//                                   )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 226
//                             ? const SizedBox(
//                                 height: 25,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'City',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? pathaoCitiesResponse.cities.isNotEmpty
//                                 ? Container(
//                                     width: screenSize.width * 0.93,
//                                     padding: const EdgeInsets.only(
//                                         left: 16, right: 16),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       border: Border.all(
//                                         width: 1,
//                                         color:
//                                             kColorFieldsBorders, //                   <--- border width here
//                                       ),
//                                     ),
//                                     child: DropdownButton(
//                                       hint: Text(
//                                           selectedCity == ''
//                                               ? 'Select'
//                                               : selectedCity,
//                                           style: const TextStyle(
//                                             color: kColorDarkGreyText,
//                                           )),
//                                       isExpanded: true,
//                                       underline: const SizedBox(),
//                                       dropdownColor:
//                                           kColorWidgetBackgroundColor,
//                                       icon: const Icon(
//                                         Icons.keyboard_arrow_down_rounded,
//                                         color: kColorDarkGreyIcon,
//                                         size: 25,
//                                       ),
//                                       iconSize: 36,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                       onChanged: (valueItem) {},
//                                       items: pathaoCitiesResponse.cities
//                                           .map((valueItem) {
//                                         return DropdownMenuItem(
//                                           child: Text(valueItem.cityName),
//                                           value: valueItem,
//                                           onTap: () {
//                                             setState(() {
//                                               selectedCity = valueItem.cityName;
//                                               selectedCityId = valueItem.cityId;
//
//                                               selectedZone = '';
//                                               selectedZoneId = 0;
//                                               pathaoZoneModel = PathaoZoneModel(
//                                                   token:
//                                                       pathaoAccessTokenResponse!
//                                                           .token,
//                                                   cityId: selectedCityId
//                                                       .toString());
//                                               _cartBloc.add(GetPathaoZones(
//                                                   pathaoZoneModel:
//                                                       pathaoZoneModel!));
//
//                                               // paymentUserData!.cityID = valueItem.CityID;
//                                             });
//                                           },
//                                         );
//                                       }).toList(),
//                                     ),
//                                   )
//                                 : Container(
//                                     height: screenSize.height * 0.06,
//                                     child: TextField(
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       onChanged: (value) {
//                                         selectedCity = value;
//                                         //print(selectedState);
//                                       },
//                                       style: const TextStyle(
//                                           color: kColorDarkGreyText),
//                                       decoration: InputDecoration(
//                                         // floatingLabelStyle:
//                                         // const TextStyle(color: kColorPrimary),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(6.0),
//                                           borderSide: const BorderSide(
//                                             color: kColorFieldsBorders,
//                                           ),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(6.0),
//                                             borderSide: const BorderSide(
//                                               color: kColorPrimary,
//                                             )),
//                                         hintText: 'Enter City',
//                                         hintStyle: const TextStyle(
//                                             color: kColorFieldsBorders),
//                                       ),
//                                     ),
//                                   )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 25,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 226
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'City',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 226
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 226
//                             ? widget.allowedVendorCityResponse!.cities
//                                     .isNotEmpty
//                                 ? Container(
//                                     width: screenSize.width * 0.93,
//                                     padding: const EdgeInsets.only(
//                                         left: 16, right: 16),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       border: Border.all(
//                                         width: 1,
//                                         color:
//                                             kColorFieldsBorders, //                   <--- border width here
//                                       ),
//                                     ),
//                                     child: DropdownButton(
//                                       hint: Text(
//                                           selectedCity == ''
//                                               ? 'Select'
//                                               : selectedCity,
//                                           style: const TextStyle(
//                                             color: kColorDarkGreyText,
//                                           )),
//                                       isExpanded: true,
//                                       underline: const SizedBox(),
//                                       dropdownColor:
//                                           kColorWidgetBackgroundColor,
//                                       icon: const Icon(
//                                         Icons.keyboard_arrow_down_rounded,
//                                         color: kColorDarkGreyIcon,
//                                         size: 25,
//                                       ),
//                                       iconSize: 36,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                       onChanged: (valueItem) {},
//                                       items: widget
//                                           .allowedVendorCityResponse!.cities
//                                           .map((valueItem) {
//                                         return DropdownMenuItem(
//                                           child: Text(valueItem.City),
//                                           value: valueItem,
//                                           onTap: () {
//                                             setState(() {
//                                               selectedCity = valueItem.City;
//                                               selectedCityId = valueItem.CityID;
//                                               if (selectedCityId != 0) {
//                                                 if (selectedCity !=
//                                                     widget
//                                                         .cartDetailsResponse
//                                                         .productCartList[0]
//                                                         .City) {
//                                                   productsAndUserCitiesAreSame =
//                                                       false;
//                                                 }
//                                                 if (productsAndUserCitiesAreSame ==
//                                                     true) {
//                                                   checkDeliveryDriverModel =
//                                                       CheckDeliveryDriverModel(
//                                                           CityName:
//                                                               selectedCity);
//                                                   _cartBloc.add(
//                                                       CheckDriverAvailability(
//                                                           checkDeliveryDriverModel:
//                                                               checkDeliveryDriverModel!));
//                                                 }
//                                                 selectedZone = '';
//                                                 selectedZoneId = 0;
//                                                 pathaoZoneModel = PathaoZoneModel(
//                                                     token:
//                                                         pathaoAccessTokenResponse!
//                                                             .token,
//                                                     cityId: selectedCityId
//                                                         .toString());
//                                                 _cartBloc.add(GetPathaoZones(
//                                                     pathaoZoneModel:
//                                                         pathaoZoneModel!));
//                                               }
//                                               // paymentUserData!.cityID = valueItem.CityID;
//                                             });
//                                           },
//                                         );
//                                       }).toList(),
//                                     ),
//                                   )
//                                 : Container(
//                                     height: screenSize.height * 0.06,
//                                     child: TextField(
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       onChanged: (value) {
//                                         selectedCity = value;
//                                         //print(selectedState);
//                                       },
//                                       style: const TextStyle(
//                                           color: kColorDarkGreyText),
//                                       decoration: InputDecoration(
//                                         // floatingLabelStyle:
//                                         // const TextStyle(color: kColorPrimary),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(6.0),
//                                           borderSide: const BorderSide(
//                                             color: kColorFieldsBorders,
//                                           ),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(6.0),
//                                             borderSide: const BorderSide(
//                                               color: kColorPrimary,
//                                             )),
//                                         hintText: 'Enter City',
//                                         hintStyle: const TextStyle(
//                                             color: kColorFieldsBorders),
//                                       ),
//                                     ),
//                                   )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 226
//                             ? const SizedBox(
//                                 height: 25,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'Zone',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? pathaoZonesResponse.zones.isNotEmpty
//                                 ? Container(
//                                     width: screenSize.width * 0.93,
//                                     padding: const EdgeInsets.only(
//                                         left: 16, right: 16),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       border: Border.all(
//                                         width: 1,
//                                         color:
//                                             kColorFieldsBorders, //                   <--- border width here
//                                       ),
//                                     ),
//                                     child: DropdownButton(
//                                       hint: Text(
//                                           selectedZone == ''
//                                               ? 'Select'
//                                               : selectedZone,
//                                           style: const TextStyle(
//                                             color: kColorDarkGreyText,
//                                           )),
//                                       isExpanded: true,
//                                       underline: const SizedBox(),
//                                       dropdownColor:
//                                           kColorWidgetBackgroundColor,
//                                       icon: const Icon(
//                                         Icons.keyboard_arrow_down_rounded,
//                                         color: kColorDarkGreyIcon,
//                                         size: 25,
//                                       ),
//                                       iconSize: 36,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                       onChanged: (valueItem) {},
//                                       items: pathaoZonesResponse.zones
//                                           .map((valueItem) {
//                                         return DropdownMenuItem(
//                                           child: Text(valueItem.zoneName),
//                                           value: valueItem,
//                                           onTap: () {
//                                             setState(() {
//                                               selectedZone = valueItem.zoneName;
//                                               selectedZoneId = valueItem.zoneId;
//                                               if (selectedZoneId != 0) {
//                                                 selectedArea = '';
//                                                 selectedAreaId = 0;
//                                                 pathaoAreaModel = PathaoAreaModel(
//                                                     token:
//                                                         pathaoAccessTokenResponse!
//                                                             .token,
//                                                     zoneId: selectedZoneId
//                                                         .toString());
//                                                 _cartBloc.add(GetPathaoAreas(
//                                                     pathaoAreaModel:
//                                                         pathaoAreaModel!));
//                                               }
//                                               // paymentUserData!.cityID = valueItem.CityID;
//                                             });
//                                           },
//                                         );
//                                       }).toList(),
//                                     ),
//                                   )
//                                 : Container(
//                                     height: screenSize.height * 0.06,
//                                     child: TextField(
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       onChanged: (value) {
//                                         selectedZone = value;
//                                         //print(selectedState);
//                                       },
//                                       style: const TextStyle(
//                                           color: kColorDarkGreyText),
//                                       decoration: InputDecoration(
//                                         // floatingLabelStyle:
//                                         // const TextStyle(color: kColorPrimary),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(6.0),
//                                           borderSide: const BorderSide(
//                                             color: kColorFieldsBorders,
//                                           ),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(6.0),
//                                             borderSide: const BorderSide(
//                                               color: kColorPrimary,
//                                             )),
//                                         hintText: 'Enter Zone',
//                                         hintStyle: const TextStyle(
//                                             color: kColorFieldsBorders),
//                                       ),
//                                     ),
//                                   )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 25,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'Area',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? pathaoAreaResponse.areas.isNotEmpty
//                                 ? Container(
//                                     width: screenSize.width * 0.93,
//                                     padding: const EdgeInsets.only(
//                                         left: 16, right: 16),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       border: Border.all(
//                                         width: 1,
//                                         color:
//                                             kColorFieldsBorders, //                   <--- border width here
//                                       ),
//                                     ),
//                                     child: DropdownButton(
//                                       hint: Text(
//                                           selectedArea == ''
//                                               ? 'Select'
//                                               : selectedArea,
//                                           style: const TextStyle(
//                                             color: kColorDarkGreyText,
//                                           )),
//                                       isExpanded: true,
//                                       underline: const SizedBox(),
//                                       dropdownColor:
//                                           kColorWidgetBackgroundColor,
//                                       icon: const Icon(
//                                         Icons.keyboard_arrow_down_rounded,
//                                         color: kColorDarkGreyIcon,
//                                         size: 25,
//                                       ),
//                                       iconSize: 36,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                       onChanged: (valueItem) {},
//                                       items: pathaoAreaResponse.areas
//                                           .map((valueItem) {
//                                         return DropdownMenuItem(
//                                           child: Text(valueItem.areaName),
//                                           value: valueItem,
//                                           onTap: () {
//                                             setState(() {
//                                               selectedArea = valueItem.areaName;
//                                               selectedAreaId = valueItem.areaId;
//
//                                               // paymentUserData!.cityID = valueItem.CityID;
//                                             });
//                                           },
//                                         );
//                                       }).toList(),
//                                     ),
//                                   )
//                                 : Container(
//                                     height: screenSize.height * 0.06,
//                                     child: TextField(
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       onChanged: (value) {
//                                         selectedArea = value;
//                                         //print(selectedState);
//                                       },
//                                       style: const TextStyle(
//                                           color: kColorDarkGreyText),
//                                       decoration: InputDecoration(
//                                         // floatingLabelStyle:
//                                         // const TextStyle(color: kColorPrimary),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(6.0),
//                                           borderSide: const BorderSide(
//                                             color: kColorFieldsBorders,
//                                           ),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(6.0),
//                                             borderSide: const BorderSide(
//                                               color: kColorPrimary,
//                                             )),
//                                         hintText: 'Enter Area',
//                                         hintStyle: const TextStyle(
//                                             color: kColorFieldsBorders),
//                                       ),
//                                     ),
//                                   )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 25,
//                               )
//                             : const SizedBox(),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Desire Date',
//                             style: TextStyle(fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Stack(
//                           alignment: AlignmentDirectional.centerEnd,
//                           children: [
//                             Container(
//                               height: screenSize.height * 0.06,
//                               child: TextField(
//                                 controller: createdDateController,
//                                 style:
//                                     const TextStyle(color: kColorDarkGreyText),
//                                 readOnly: true,
//                                 decoration: InputDecoration(
//                                     // floatingLabelStyle:
//                                     // const TextStyle(color: kColorPrimary),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       borderSide: const BorderSide(
//                                         color: kColorFieldsBorders,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(6.0),
//                                         borderSide: const BorderSide(
//                                           color: kColorPrimary,
//                                         )),
//                                     hintText: 'dd/mm/yyyy',
//                                     hintStyle: const TextStyle(
//                                         color: kColorFieldsBorders)),
//                               ),
//                             ),
//                             InkWell(
//                                 onTap: () {
//                                   _pickDate();
//                                 },
//                                 child: Container(
//                                   height: 40,
//                                   width: 40,
//                                   child: const Padding(
//                                     padding: EdgeInsets.only(right: 10),
//                                     child: Icon(
//                                         MyFlutterApp.icon_calendar_outlined),
//                                   ),
//                                 ))
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 50,
//                         ),
//                         // const Align(
//                         //   alignment: Alignment.topLeft,
//                         //   child: Text(
//                         //     'Order Note (Optional)',
//                         //     style: TextStyle(fontSize: 14, color: Colors.black),
//                         //   ),
//                         // ),
//                         // Container(
//                         //   height: screenSize.height * 0.3,
//                         //   width: screenSize.width,
//                         //   decoration: const BoxDecoration(
//                         //     boxShadow: [],
//                         //     borderRadius: BorderRadius.all(Radius.circular(6)),
//                         //     color: kColorWhite,
//                         //   ),
//                         //   child: Padding(
//                         //     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         //     child: TextField(
//                         //       textCapitalization: TextCapitalization.sentences,
//                         //       keyboardType: TextInputType.text,
//                         //       controller: adminNoteController,
//                         //       //focusNode: fObservation,
//                         //       // maxLength: 200,
//                         //       style: const TextStyle(
//                         //         color: Colors.black,
//                         //       ),
//                         //       onChanged: (value) {
//                         //         setState(() {
//                         //           //charLength = value.length;
//                         //         });
//                         //         //print('$value,$charLength');
//                         //       },
//                         //       maxLines: 8,
//                         //       cursorColor: kColorPrimary,
//                         //       decoration: InputDecoration(
//                         //         floatingLabelBehavior:
//                         //             FloatingLabelBehavior.always,
//                         //         // hintText: getTranslated(context,
//                         //         //     'typeherestartdictation'),
//                         //         isDense: true,
//                         //         contentPadding:
//                         //             const EdgeInsets.fromLTRB(10, 20, 40, 0),
//                         //         hintStyle:
//                         //             TextStyle(color: Colors.grey.shade400),
//                         //         enabledBorder: const OutlineInputBorder(
//                         //           borderRadius:
//                         //               BorderRadius.all(Radius.circular(5.0)),
//                         //           borderSide: BorderSide(
//                         //               color: kColorFieldsBorders, width: 1),
//                         //         ),
//                         //         focusedBorder: const OutlineInputBorder(
//                         //           borderRadius:
//                         //               BorderRadius.all(Radius.circular(5.0)),
//                         //           borderSide: BorderSide(
//                         //               color: kColorFieldsBorders, width: 1),
//                         //         ),
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Delivery Address',
//                             style:
//                                 TextStyle(fontSize: 18, color: kColorPrimary),
//                           ),
//                         ),
//
//                         widget.selectedCountryId==selectedPaymentCountryID?Row(
//                           children: [
//                             Theme(
//                                 data: ThemeData(
//                                     unselectedWidgetColor: Colors.grey),
//                                 child: Checkbox(
//                                   value: deliveryAddressFlag,
//                                   onChanged: (state) {
//                                     if (deliveryAddressFlag == false) {
//                                       deliveryAddressFlag = true;
//                                       nameDeliveryController.text =
//                                           nameController.text;
//                                       address1DeliveryController.text =
//                                           address1Controller.text;
//                                       address2DeliveryController.text =
//                                           address2Controller.text;
//                                       zipCodeDeliveryController.text =
//                                           zipCodeController.text;
//                                       adminDeliveryNoteController.text =
//                                           adminNoteController.text;
//                                       selectedStateDelivery = selectedState;
//                                       selectedCityDelivery = selectedCity;
//                                       deliveryCityController.text =
//                                           selectedCity;
//                                       selectedCityIdDelivery = selectedCityId;
//                                       _chooseCountryCodeDelivery =
//                                           _chooseCountryCode;
//                                       phoneDeliveryNumberController.text =
//                                           phoneNumberController.text;
//                                       if (widget.selectedCountryId == 226) {
//                                         if (selectedStateDelivery != '') {
//                                           uspsAddressVerifyModel =
//                                               UspsAddressVerifyModel(
//                                                   address1:
//                                                       address1DeliveryController
//                                                           .text,
//                                                   address2:
//                                                       address2DeliveryController
//                                                           .text,
//                                                   state: selectedStateDelivery,
//                                                   zip: zipCodeDeliveryController
//                                                       .text);
//                                           _cartBloc.add(VerifyUspsAddress(
//                                               uspsAddressVerifyModel:
//                                                   uspsAddressVerifyModel!));
//                                         }
//                                       } else if (widget.selectedCountryId ==
//                                           16) {
//                                         selectedDeliveryCity = selectedCity;
//                                         selectedDeliveryCityId = selectedCityId;
//                                         selectedDeliveryZone = selectedZone;
//                                         selectedDeliveryZoneId = selectedZoneId;
//                                         selectedDeliveryArea = selectedArea;
//                                         selectedDeliveryAreaId = selectedAreaId;
//                                         if (selectedDeliveryZoneId != 0) {
//                                           selectedDeliveryArea = '';
//                                           selectedDeliveryAreaId = 0;
//                                           pathaoAreaModel = PathaoAreaModel(
//                                               token: pathaoAccessTokenResponse!
//                                                   .token,
//                                               zoneId: selectedDeliveryZoneId
//                                                   .toString());
//                                           _cartBloc.add(GetPathaoAreas(
//                                               pathaoAreaModel:
//                                                   pathaoAreaModel!));
//                                           pathaoPriceCalculationModel =
//                                               PathaoPriceCalculationModel(
//                                                   token:
//                                                       pathaoAccessTokenResponse!
//                                                           .token,
//
//                                                   recipientCity:
//                                                       selectedDeliveryCityId
//                                                           .toString(),
//                                                   recipientZone:
//                                                       selectedDeliveryZoneId
//                                                           .toString(), ProductIDs: []);
//                                           _cartBloc.add(PathaoPriceCalculation(
//                                               pathaoPriceCalculationModel:
//                                                   pathaoPriceCalculationModel!));
//                                         }
//                                       }
//                                     } else {
//                                       deliveryAddressFlag = false;
//                                       nameDeliveryController.text = '';
//                                       address1DeliveryController.text = '';
//                                       address2DeliveryController.text = '';
//                                       zipCodeDeliveryController.text = '';
//                                       adminDeliveryNoteController.text = '';
//                                       selectedStateDelivery = '';
//                                       selectedCityDelivery = '';
//                                       selectedCityIdDelivery = 0;
//                                       _chooseCountryCodeDelivery = '';
//                                       phoneDeliveryNumberController.text = '';
//                                       deliveryCityController.text = '';
//                                       if (widget.selectedCountryId == 16) {
//                                         selectedDeliveryCity = '';
//                                         selectedDeliveryCityId = 0;
//                                         selectedDeliveryZone = '';
//                                         selectedDeliveryZoneId = 0;
//                                         selectedDeliveryArea = '';
//                                         selectedDeliveryAreaId = 0;
//                                       }
//                                     }
//                                     setState(() {});
//                                   },
//                                   activeColor: kColorPrimary,
//                                   checkColor: Colors.white,
//                                   materialTapTargetSize:
//                                       MaterialTapTargetSize.padded,
//                                 )),
//                             const Text('Same as above')
//                           ],
//                         ):const SizedBox(),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Full Name (Delivery)',
//                             style: TextStyle(fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           height: screenSize.height * 0.06,
//                           child: TextField(
//                             controller: nameDeliveryController,
//                             textCapitalization: TextCapitalization.words,
//                             style: const TextStyle(color: kColorDarkGreyText),
//                             decoration: InputDecoration(
//                               // floatingLabelStyle:
//                               // const TextStyle(color: kColorPrimary),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(6.0),
//                                 borderSide: const BorderSide(
//                                   color: kColorFieldsBorders,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(6.0),
//                                   borderSide: const BorderSide(
//                                     color: kColorPrimary,
//                                   )),
//                               hintText: 'Enter Full Name',
//                               hintStyle:
//                                   const TextStyle(color: kColorFieldsBorders),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Delivery Address 1',
//                             style: TextStyle(fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         TextField(
//                           controller: address1DeliveryController,
//                           textCapitalization: TextCapitalization.words,
//                           style: const TextStyle(color: kColorDarkGreyText),
//                           decoration: InputDecoration(
//                             // floatingLabelStyle:
//                             // const TextStyle(color: kColorPrimary),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(6.0),
//                               borderSide: const BorderSide(
//                                 color: kColorFieldsBorders,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(6.0),
//                                 borderSide: const BorderSide(
//                                   color: kColorPrimary,
//                                 )),
//                             hintText: 'Enter Address 1',
//                             hintStyle:
//                                 const TextStyle(color: kColorFieldsBorders),
//                           ),
//                         ),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'Note : Address 1 should contains at least 25 characters.',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: kColorOrangeText,
//                                   ),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Delivery Address 2 ${widget.selectedCountryId == 226 ? '' : '(Optional)'}',
//                             style: const TextStyle(
//                                 fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         TextField(
//                           controller: address2DeliveryController,
//                           textCapitalization: TextCapitalization.words,
//                           style: const TextStyle(color: kColorDarkGreyText),
//                           decoration: InputDecoration(
//                             // floatingLabelStyle:
//                             // const TextStyle(color: kColorPrimary),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(6.0),
//                               borderSide: const BorderSide(
//                                 color: kColorFieldsBorders,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(6.0),
//                                 borderSide: const BorderSide(
//                                   color: kColorPrimary,
//                                 )),
//                             hintText: 'Enter Address 2',
//                             hintStyle:
//                                 const TextStyle(color: kColorFieldsBorders),
//                           ),
//                         ),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'Note : Address should contains at least 25 characters.',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: kColorOrangeText,
//                                   ),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Delivery Phone Number',
//                             style: TextStyle(fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             InkWell(
//                               child: Container(
//                                 width: screenSize.width * 0.25,
//                                 height: screenSize.height * 0.06,
//                                 padding:
//                                     const EdgeInsets.only(left: 10, right: 10),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: kColorFieldsBorders, width: 1),
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: kColorWhite,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       _chooseCountryCodeDelivery == ''
//                                           ? 'CC'
//                                           : _chooseCountryCodeDelivery,
//                                       style: const TextStyle(
//                                         color: kColorDarkGreyText,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     const Icon(
//                                       Icons.keyboard_arrow_down_outlined,
//                                       color: kColorDarkGreyText,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               onTap: () {
//                                 _countryCodePickerDialog(deliveryPhone: true);
//                               },
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Container(
//                               height: screenSize.height * 0.06,
//                               width: screenSize.width * 0.6,
//                               child: TextField(
//                                 controller: phoneDeliveryNumberController,
//                                 keyboardType: TextInputType.number,
//                                 inputFormatters: <TextInputFormatter>[
//                                   FilteringTextInputFormatter.digitsOnly
//                                 ],
//                                 // readOnly: AppGlobal.phoneVerified == 'N'
//                                 //     ? true
//                                 //     : false,
//                                 onChanged: (value) {
//                                   if (AppGlobal.phoneNumber !=
//                                       _chooseCountryCode +
//                                           phoneNumberController.text.trim()) {
//                                     AppGlobal.phoneChangeVerify = false;
//                                   } else {
//                                     AppGlobal.phoneChangeVerify = true;
//                                   }
//                                   setState(() {});
//                                 },
//                                 style:
//                                     const TextStyle(color: kColorDarkGreyText),
//                                 decoration: InputDecoration(
//                                     // floatingLabelStyle:
//                                     // const TextStyle(color: kColorPrimary),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       borderSide: const BorderSide(
//                                         color: kColorFieldsBorders,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(6.0),
//                                         borderSide: const BorderSide(
//                                           color: kColorPrimary,
//                                         )),
//                                     hintText: 'Add number',
//                                     hintStyle: const TextStyle(
//                                         color: kColorFieldsBorders)),
//                               ),
//                             ),
//                           ],
//                         ),
//                         //ToDo: Verify the  number before adding
//                         // AppGlobal.phoneVerified == 'N' ||
//                         //         AppGlobal.phoneChangeVerify == false
//                         //     ? Column(
//                         //         children: [
//                         //           const SizedBox(
//                         //             height: 10,
//                         //           ),
//                         //           InkWell(
//                         //             onTap: () {
//                         //               // _loginBloc.add(ResendOTPSignUpUser(
//                         //               //   email: AppGlobal.emailAddress,
//                         //               // ));
//                         //               if (_chooseCountryCode.length > 1 &&
//                         //                   phoneNumberController.text.length >
//                         //                       7) {
//                         //                 Navigator.push(
//                         //                   context,
//                         //                   MaterialPageRoute(
//                         //                     builder: (context) =>
//                         //                         CodeVerificationScreen(
//                         //                       moduleName:
//                         //                           'phoneChangeEditProfile',
//                         //                       userEmail: _chooseCountryCode +
//                         //                           phoneNumberController.text,
//                         //                     ),
//                         //                   ),
//                         //                 );
//                         //               } else {
//                         //                 Fluttertoast.showToast(
//                         //                     msg:
//                         //                         'Please enter a valid phone number',
//                         //                     toastLength: Toast.LENGTH_SHORT,
//                         //                     gravity: ToastGravity.BOTTOM,
//                         //                     timeInSecForIosWeb: 1,
//                         //                     backgroundColor:
//                         //                         Colors.grey.shade400,
//                         //                     textColor: Colors.white,
//                         //                     fontSize: 12.0);
//                         //               }
//                         //             },
//                         //             child: Column(
//                         //               children: const [
//                         //                 Text.rich(
//                         //                   TextSpan(
//                         //                     children: [
//                         //                       TextSpan(
//                         //                         text:
//                         //                             'Note:Email not verified. To update profile you have to verify the email first. ',
//                         //                         style: TextStyle(
//                         //                             color: kColorFieldsBorders),
//                         //                       ),
//                         //                       TextSpan(
//                         //                         text: 'Verify email?',
//                         //                         style: TextStyle(
//                         //                             color: Colors.blue,
//                         //                             fontWeight:
//                         //                                 FontWeight.bold),
//                         //                       ),
//                         //                     ],
//                         //                   ),
//                         //                 ),
//                         //               ],
//                         //             ),
//                         //           ),
//                         //         ],
//                         //       )
//                         //     : SizedBox(),
//
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Delivery Zip Code',
//                             style: TextStyle(fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           height: screenSize.height * 0.06,
//                           child: TextField(
//                             controller: zipCodeDeliveryController,
//                             textCapitalization: TextCapitalization.words,
//                             keyboardType: TextInputType.number,
//                             inputFormatters: <TextInputFormatter>[
//                               FilteringTextInputFormatter.digitsOnly
//                             ],
//                             style: const TextStyle(color: kColorDarkGreyText),
//                             decoration: InputDecoration(
//                               // floatingLabelStyle:
//                               // const TextStyle(color: kColorPrimary),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(6.0),
//                                 borderSide: const BorderSide(
//                                   color: kColorFieldsBorders,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(6.0),
//                                   borderSide: const BorderSide(
//                                     color: kColorPrimary,
//                                   )),
//                               hintText: 'Enter Zip Code',
//                               hintStyle:
//                                   const TextStyle(color: kColorFieldsBorders),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         widget.selectedCountryId == 226
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'Delivery State',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 226
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 226
//                             ? widget.allowedVendorStatesResponse!.states
//                                     .isNotEmpty
//                                 ? Container(
//                                     width: screenSize.width * 0.93,
//                                     padding: const EdgeInsets.only(
//                                         left: 16, right: 16),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       border: Border.all(
//                                         width: 1,
//                                         color:
//                                             kColorFieldsBorders, //                   <--- border width here
//                                       ),
//                                     ),
//                                     child: DropdownButton(
//                                       hint: Text(
//                                           selectedStateDelivery == ''
//                                               ? 'Select'
//                                               : selectedStateDelivery,
//                                           style: const TextStyle(
//                                             color: kColorDarkGreyText,
//                                           )),
//                                       isExpanded: true,
//                                       underline: const SizedBox(),
//                                       dropdownColor:
//                                           kColorWidgetBackgroundColor,
//                                       icon: const Icon(
//                                         Icons.keyboard_arrow_down_rounded,
//                                         color: kColorDarkGreyIcon,
//                                         size: 25,
//                                       ),
//                                       iconSize: 36,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                       onChanged: (valueItem) {},
//                                       items: widget
//                                           .allowedVendorStatesResponse!.states
//                                           .map((valueItem) {
//                                         return DropdownMenuItem(
//                                           child: Text(valueItem.State),
//                                           value: valueItem,
//                                           onTap: () {
//                                             setState(() {
//                                               selectedStateDelivery =
//                                                   valueItem.State;
//                                               if (selectedStateDelivery != '') {
//                                                 uspsAddressVerifyModel =
//                                                     UspsAddressVerifyModel(
//                                                         address1:
//                                                             address1DeliveryController
//                                                                 .text,
//                                                         address2:
//                                                             address2DeliveryController
//                                                                 .text,
//                                                         state:
//                                                             selectedStateDelivery,
//                                                         zip:
//                                                             zipCodeDeliveryController
//                                                                 .text);
//                                                 _cartBloc.add(VerifyUspsAddress(
//                                                     uspsAddressVerifyModel:
//                                                         uspsAddressVerifyModel!));
//                                               }
//                                             });
//                                           },
//                                         );
//                                       }).toList(),
//                                     ),
//                                   )
//                                 : Container(
//                                     height: screenSize.height * 0.06,
//                                     child: TextField(
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       onChanged: (value) {
//                                         selectedState = value;
//                                         //print(selectedState);
//                                       },
//                                       style: const TextStyle(
//                                           color: kColorDarkGreyText),
//                                       decoration: InputDecoration(
//                                         // floatingLabelStyle:
//                                         // const TextStyle(color: kColorPrimary),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(6.0),
//                                           borderSide: const BorderSide(
//                                             color: kColorFieldsBorders,
//                                           ),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(6.0),
//                                             borderSide: const BorderSide(
//                                               color: kColorPrimary,
//                                             )),
//                                         hintText: 'Enter State',
//                                         hintStyle: const TextStyle(
//                                             color: kColorFieldsBorders),
//                                       ),
//                                     ),
//                                   )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 226
//                             ? const SizedBox(
//                                 height: 25,
//                               )
//                             : const SizedBox(),
//                         // const Align(
//                         //   alignment: Alignment.topLeft,
//                         //   child: Text(
//                         //     'Delivery State',
//                         //     style: TextStyle(fontSize: 14, color: Colors.black),
//                         //   ),
//                         // ),
//                         // const SizedBox(
//                         //   height: 5,
//                         // ),
//                         // widget.allowedVendorStatesResponse!.states.isNotEmpty
//                         //     ? Container(
//                         //         width: screenSize.width * 0.93,
//                         //         padding:
//                         //             const EdgeInsets.only(left: 16, right: 16),
//                         //         decoration: BoxDecoration(
//                         //           borderRadius: BorderRadius.circular(6.0),
//                         //           border: Border.all(
//                         //             width: 1,
//                         //             color:
//                         //                 kColorFieldsBorders, //                   <--- border width here
//                         //           ),
//                         //         ),
//                         //         child: DropdownButton(
//                         //           hint: Text(
//                         //               selectedStateDelivery == ''
//                         //                   ? 'Select'
//                         //                   : selectedStateDelivery,
//                         //               style: const TextStyle(
//                         //                 color: kColorDarkGreyText,
//                         //               )),
//                         //           isExpanded: true,
//                         //           underline: const SizedBox(),
//                         //           dropdownColor: kColorWidgetBackgroundColor,
//                         //           icon: const Icon(
//                         //             Icons.keyboard_arrow_down_rounded,
//                         //             color: kColorDarkGreyIcon,
//                         //             size: 25,
//                         //           ),
//                         //           iconSize: 36,
//                         //           style: const TextStyle(
//                         //             fontSize: 16,
//                         //             color: Colors.black,
//                         //           ),
//                         //           onChanged: (valueItem) {},
//                         //           items: widget
//                         //               .allowedVendorStatesResponse!.states
//                         //               .map((valueItem) {
//                         //             return DropdownMenuItem(
//                         //               child: Text(valueItem.State),
//                         //               value: valueItem,
//                         //               onTap: () {
//                         //                 setState(() {
//                         //                   selectedStateDelivery =
//                         //                       valueItem.State;
//                         //                 });
//                         //               },
//                         //             );
//                         //           }).toList(),
//                         //         ),
//                         //       )
//                         //     : Container(
//                         //         height: screenSize.height * 0.06,
//                         //         child: TextField(
//                         //           textCapitalization: TextCapitalization.words,
//                         //           onChanged: (value) {
//                         //             selectedStateDelivery = value;
//                         //             //print(selectedState);
//                         //           },
//                         //           style: const TextStyle(
//                         //               color: kColorDarkGreyText),
//                         //           decoration: InputDecoration(
//                         //             // floatingLabelStyle:
//                         //             // const TextStyle(color: kColorPrimary),
//                         //             enabledBorder: OutlineInputBorder(
//                         //               borderRadius: BorderRadius.circular(6.0),
//                         //               borderSide: const BorderSide(
//                         //                 color: kColorFieldsBorders,
//                         //               ),
//                         //             ),
//                         //             focusedBorder: OutlineInputBorder(
//                         //                 borderRadius:
//                         //                     BorderRadius.circular(6.0),
//                         //                 borderSide: const BorderSide(
//                         //                   color: kColorPrimary,
//                         //                 )),
//                         //             hintText: 'Enter State',
//                         //             hintStyle: const TextStyle(
//                         //                 color: kColorFieldsBorders),
//                         //           ),
//                         //         ),
//                         //       ),
//                         // const SizedBox(
//                         //   height: 25,
//                         // ),
//                         widget.selectedCountryId == 16
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'Delivery City',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? pathaoCitiesResponse.cities.isNotEmpty
//                                 ? Container(
//                                     width: screenSize.width * 0.93,
//                                     padding: const EdgeInsets.only(
//                                         left: 16, right: 16),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       border: Border.all(
//                                         width: 1,
//                                         color:
//                                             kColorFieldsBorders, //                   <--- border width here
//                                       ),
//                                     ),
//                                     child: DropdownButton(
//                                       hint: Text(
//                                           selectedDeliveryCity == ''
//                                               ? 'Select'
//                                               : selectedDeliveryCity,
//                                           style: const TextStyle(
//                                             color: kColorDarkGreyText,
//                                           )),
//                                       isExpanded: true,
//                                       underline: const SizedBox(),
//                                       dropdownColor:
//                                           kColorWidgetBackgroundColor,
//                                       icon: const Icon(
//                                         Icons.keyboard_arrow_down_rounded,
//                                         color: kColorDarkGreyIcon,
//                                         size: 25,
//                                       ),
//                                       iconSize: 36,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                       onChanged: (valueItem) {},
//                                       items: pathaoCitiesResponse.cities
//                                           .map((valueItem) {
//                                         return DropdownMenuItem(
//                                           child: Text(valueItem.cityName),
//                                           value: valueItem,
//                                           onTap: () {
//                                             setState(() {
//                                               selectedDeliveryCity =
//                                                   valueItem.cityName;
//                                               selectedDeliveryCityId =
//                                                   valueItem.cityId;
//                                               if (selectedDeliveryCityId != 0) {
//                                                 if (selectedDeliveryCity !=
//                                                     widget
//                                                         .cartDetailsResponse
//                                                         .productCartList[0]
//                                                         .City) {
//                                                   productsAndUserCitiesAreSame =
//                                                       false;
//                                                 }
//                                                 if (productsAndUserCitiesAreSame ==
//                                                     true) {
//                                                   checkDeliveryDriverModel =
//                                                       CheckDeliveryDriverModel(
//                                                           CityName:
//                                                               selectedDeliveryCity);
//                                                   _cartBloc.add(
//                                                       CheckDriverAvailability(
//                                                           checkDeliveryDriverModel:
//                                                               checkDeliveryDriverModel!));
//                                                 }
//                                                 selectedDeliveryZone = '';
//                                                 selectedDeliveryZoneId = 0;
//                                                 pathaoZoneModel = PathaoZoneModel(
//                                                     token:
//                                                         pathaoAccessTokenResponse!
//                                                             .token,
//                                                     cityId:
//                                                         selectedDeliveryCityId
//                                                             .toString());
//                                                 _cartBloc.add(GetPathaoZones(
//                                                     pathaoZoneModel:
//                                                         pathaoZoneModel!));
//                                               }
//                                               // paymentUserData!.cityID = valueItem.CityID;
//                                             });
//                                           },
//                                         );
//                                       }).toList(),
//                                     ),
//                                   )
//                                 : Container(
//                                     height: screenSize.height * 0.06,
//                                     child: TextField(
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       onChanged: (value) {
//                                         selectedDeliveryCity = value;
//                                         //print(selectedState);
//                                       },
//                                       style: const TextStyle(
//                                           color: kColorDarkGreyText),
//                                       decoration: InputDecoration(
//                                         // floatingLabelStyle:
//                                         // const TextStyle(color: kColorPrimary),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(6.0),
//                                           borderSide: const BorderSide(
//                                             color: kColorFieldsBorders,
//                                           ),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(6.0),
//                                             borderSide: const BorderSide(
//                                               color: kColorPrimary,
//                                             )),
//                                         hintText: 'Enter City',
//                                         hintStyle: const TextStyle(
//                                             color: kColorFieldsBorders),
//                                       ),
//                                     ),
//                                   )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 25,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'Delivery Zone',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? pathaoZonesResponse.zones.isNotEmpty
//                                 ? Container(
//                                     width: screenSize.width * 0.93,
//                                     padding: const EdgeInsets.only(
//                                         left: 16, right: 16),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       border: Border.all(
//                                         width: 1,
//                                         color:
//                                             kColorFieldsBorders, //                   <--- border width here
//                                       ),
//                                     ),
//                                     child: DropdownButton(
//                                       hint: Text(
//                                           selectedDeliveryZone == ''
//                                               ? 'Select'
//                                               : selectedDeliveryZone,
//                                           style: const TextStyle(
//                                             color: kColorDarkGreyText,
//                                           )),
//                                       isExpanded: true,
//                                       underline: const SizedBox(),
//                                       dropdownColor:
//                                           kColorWidgetBackgroundColor,
//                                       icon: const Icon(
//                                         Icons.keyboard_arrow_down_rounded,
//                                         color: kColorDarkGreyIcon,
//                                         size: 25,
//                                       ),
//                                       iconSize: 36,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                       onChanged: (valueItem) {},
//                                       items: pathaoZonesResponse.zones
//                                           .map((valueItem) {
//                                         return DropdownMenuItem(
//                                           child: Text(valueItem.zoneName),
//                                           value: valueItem,
//                                           onTap: () {
//                                             setState(() {
//                                               selectedDeliveryZone =
//                                                   valueItem.zoneName;
//                                               selectedDeliveryZoneId =
//                                                   valueItem.zoneId;
//                                               if (selectedDeliveryZoneId != 0) {
//                                                 selectedDeliveryArea = '';
//                                                 selectedDeliveryAreaId = 0;
//                                                 pathaoAreaModel = PathaoAreaModel(
//                                                     token:
//                                                         pathaoAccessTokenResponse!
//                                                             .token,
//                                                     zoneId:
//                                                         selectedDeliveryZoneId
//                                                             .toString());
//                                                 _cartBloc.add(GetPathaoAreas(
//                                                     pathaoAreaModel:
//                                                         pathaoAreaModel!));
//                                                 pathaoPriceCalculationModel =
//                                                     PathaoPriceCalculationModel(
//                                                         token:
//                                                             pathaoAccessTokenResponse!
//                                                                 .token,
//
//                                                         recipientCity:
//                                                             selectedDeliveryCityId
//                                                                 .toString(),
//                                                         recipientZone:
//                                                             selectedDeliveryZoneId
//                                                                 .toString(), ProductIDs: []);
//                                                 _cartBloc.add(PathaoPriceCalculation(
//                                                     pathaoPriceCalculationModel:
//                                                         pathaoPriceCalculationModel!));
//                                               }
//                                               // paymentUserData!.cityID = valueItem.CityID;
//                                             });
//                                           },
//                                         );
//                                       }).toList(),
//                                     ),
//                                   )
//                                 : Container(
//                                     height: screenSize.height * 0.06,
//                                     child: TextField(
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       onChanged: (value) {
//                                         selectedDeliveryZone = value;
//                                         //print(selectedState);
//                                       },
//                                       style: const TextStyle(
//                                           color: kColorDarkGreyText),
//                                       decoration: InputDecoration(
//                                         // floatingLabelStyle:
//                                         // const TextStyle(color: kColorPrimary),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(6.0),
//                                           borderSide: const BorderSide(
//                                             color: kColorFieldsBorders,
//                                           ),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(6.0),
//                                             borderSide: const BorderSide(
//                                               color: kColorPrimary,
//                                             )),
//                                         hintText: 'Enter Zone',
//                                         hintStyle: const TextStyle(
//                                             color: kColorFieldsBorders),
//                                       ),
//                                     ),
//                                   )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 25,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'Delivery Area',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                 ),
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 5,
//                               )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? pathaoAreaResponse.areas.isNotEmpty
//                                 ? Container(
//                                     width: screenSize.width * 0.93,
//                                     padding: const EdgeInsets.only(
//                                         left: 16, right: 16),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       border: Border.all(
//                                         width: 1,
//                                         color:
//                                             kColorFieldsBorders, //                   <--- border width here
//                                       ),
//                                     ),
//                                     child: DropdownButton(
//                                       hint: Text(
//                                           selectedDeliveryArea == ''
//                                               ? 'Select'
//                                               : selectedDeliveryArea,
//                                           style: const TextStyle(
//                                             color: kColorDarkGreyText,
//                                           )),
//                                       isExpanded: true,
//                                       underline: const SizedBox(),
//                                       dropdownColor:
//                                           kColorWidgetBackgroundColor,
//                                       icon: const Icon(
//                                         Icons.keyboard_arrow_down_rounded,
//                                         color: kColorDarkGreyIcon,
//                                         size: 25,
//                                       ),
//                                       iconSize: 36,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                       onChanged: (valueItem) {},
//                                       items: pathaoAreaResponse.areas
//                                           .map((valueItem) {
//                                         return DropdownMenuItem(
//                                           child: Text(valueItem.areaName),
//                                           value: valueItem,
//                                           onTap: () {
//                                             setState(() {
//                                               selectedDeliveryArea =
//                                                   valueItem.areaName;
//                                               selectedDeliveryAreaId =
//                                                   valueItem.areaId;
//
//                                               // paymentUserData!.cityID = valueItem.CityID;
//                                             });
//                                           },
//                                         );
//                                       }).toList(),
//                                     ),
//                                   )
//                                 : Container(
//                                     height: screenSize.height * 0.06,
//                                     child: TextField(
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       onChanged: (value) {
//                                         selectedDeliveryArea = value;
//                                         //print(selectedState);
//                                       },
//                                       style: const TextStyle(
//                                           color: kColorDarkGreyText),
//                                       decoration: InputDecoration(
//                                         // floatingLabelStyle:
//                                         // const TextStyle(color: kColorPrimary),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(6.0),
//                                           borderSide: const BorderSide(
//                                             color: kColorFieldsBorders,
//                                           ),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(6.0),
//                                             borderSide: const BorderSide(
//                                               color: kColorPrimary,
//                                             )),
//                                         hintText: 'Enter Area',
//                                         hintStyle: const TextStyle(
//                                             color: kColorFieldsBorders),
//                                       ),
//                                     ),
//                                   )
//                             : const SizedBox(),
//                         widget.selectedCountryId == 16
//                             ? const SizedBox(
//                                 height: 25,
//                               )
//                             : const SizedBox(),
//                         const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Delivery Order Note (Optional)',
//                             style: TextStyle(fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                         Container(
//                           height: screenSize.height * 0.3,
//                           width: screenSize.width,
//                           decoration: const BoxDecoration(
//                             boxShadow: [],
//                             borderRadius: BorderRadius.all(Radius.circular(6)),
//                             color: kColorWhite,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: TextField(
//                               textCapitalization: TextCapitalization.sentences,
//                               keyboardType: TextInputType.text,
//                               controller: adminDeliveryNoteController,
//                               //focusNode: fObservation,
//                               // maxLength: 200,
//                               style: const TextStyle(
//                                 color: Colors.black,
//                               ),
//                               onChanged: (value) {
//                                 setState(() {
//                                   //charLength = value.length;
//                                 });
//                                 //print('$value,$charLength');
//                               },
//                               maxLines: 8,
//                               cursorColor: kColorPrimary,
//                               decoration: InputDecoration(
//                                 floatingLabelBehavior:
//                                     FloatingLabelBehavior.always,
//                                 // hintText: getTranslated(context,
//                                 //     'typeherestartdictation'),
//                                 isDense: true,
//                                 contentPadding:
//                                     const EdgeInsets.fromLTRB(10, 20, 40, 0),
//                                 hintStyle:
//                                     TextStyle(color: Colors.grey.shade400),
//                                 enabledBorder: const OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5.0)),
//                                   borderSide: BorderSide(
//                                       color: kColorFieldsBorders, width: 1),
//                                 ),
//                                 focusedBorder: const OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5.0)),
//                                   borderSide: BorderSide(
//                                       color: kColorFieldsBorders, width: 1),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         getShippingDetailsResponse != null
//                             ? getShippingDetailsResponse!.banglaBazarPickup ==
//                                     true
//                                 ? const SizedBox(
//                                     height: 25,
//                                   )
//                                 : const SizedBox()
//                             : const SizedBox(),
//                         getShippingDetailsResponse != null
//                             ? getShippingDetailsResponse!.banglaBazarPickup ==
//                                     true
//                                 ? const Align(
//                                     alignment: Alignment.topLeft,
//                                     child: Text(
//                                       'Bangla Bazar Delivery',
//                                       style: TextStyle(
//                                           fontSize: 14, color: Colors.black),
//                                     ),
//                                   )
//                                 : const SizedBox()
//                             : const SizedBox(),
//                         getShippingDetailsResponse != null
//                             ? getShippingDetailsResponse!.banglaBazarPickup ==
//                                     true
//                                 ? const SizedBox(
//                                     height: 10,
//                                   )
//                                 : const SizedBox()
//                             : const SizedBox(),
//                         getShippingDetailsResponse != null
//                             ? getShippingDetailsResponse!.banglaBazarPickup ==
//                                     true
//                                 ? Row(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               InkWell(
//                                                 child: Container(
//                                                   width: 20,
//                                                   height: 20,
//                                                   decoration:
//                                                       const BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     color: kColorDarkGreyIcon,
//                                                   ),
//                                                   child: Center(
//                                                       child: Container(
//                                                     width: 18,
//                                                     height: 18,
//                                                     decoration:
//                                                         const BoxDecoration(
//                                                       shape: BoxShape.circle,
//                                                       color: kColorWhite,
//                                                     ),
//                                                     child: Center(
//                                                         child: Container(
//                                                       width: 13,
//                                                       height: 13,
//                                                       decoration: BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color:
//                                                             banglaBazarPickup ==
//                                                                     true
//                                                                 ? kColorPrimary
//                                                                 : kColorWhite,
//                                                       ),
//                                                     )),
//                                                   )),
//                                                 ),
//                                                 onTap: () {
//                                                   if (banglaBazarPickup ==
//                                                       false) {
//                                                     setState(() {
//                                                       banglaBazarPickup = true;
//                                                       pickUpAvailable = false;
//                                                     });
//                                                   }
//                                                 },
//                                               ),
//                                               const SizedBox(
//                                                 width: 5,
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           const Text(
//                                             'Yes',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 14),
//                                           )
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         width: 75,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               InkWell(
//                                                 child: Container(
//                                                   width: 20,
//                                                   height: 20,
//                                                   decoration:
//                                                       const BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     color: kColorDarkGreyIcon,
//                                                   ),
//                                                   child: Center(
//                                                       child: Container(
//                                                     width: 18,
//                                                     height: 18,
//                                                     decoration:
//                                                         const BoxDecoration(
//                                                       shape: BoxShape.circle,
//                                                       color: kColorWhite,
//                                                     ),
//                                                     child: Center(
//                                                         child: Container(
//                                                       width: 13,
//                                                       height: 13,
//                                                       decoration: BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color:
//                                                             banglaBazarPickup ==
//                                                                     false
//                                                                 ? kColorPrimary
//                                                                 : kColorWhite,
//                                                       ),
//                                                     )),
//                                                   )),
//                                                 ),
//                                                 onTap: () {
//                                                   if (banglaBazarPickup ==
//                                                       true) {
//                                                     setState(() {
//                                                       banglaBazarPickup = false;
//                                                     });
//                                                   }
//                                                 },
//                                               ),
//                                               const SizedBox(
//                                                 width: 5,
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           const Text(
//                                             'No',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 14),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   )
//                                 : const SizedBox()
//                             : const SizedBox(),
//                         getShippingDetailsResponse != null
//                             ? getShippingDetailsResponse!.banglaBazarPickup ==
//                                     true
//                                 ? const SizedBox(
//                                     height: 25,
//                                   )
//                                 : const SizedBox()
//                             : const SizedBox(),
//
//                         getShippingDetailsResponse != null
//                             ? getShippingDetailsResponse!.pickUpByUser == true
//                                 ? selectedCityDelivery ==
//                                         widget.cartDetailsResponse
//                                             .productCartList[0].City
//                                     ? const Align(
//                                         alignment: Alignment.topLeft,
//                                         child: Text(
//                                           'Pick up',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.black),
//                                         ),
//                                       )
//                                     : const SizedBox()
//                                 : const SizedBox()
//                             : const SizedBox(),
//                         getShippingDetailsResponse != null
//                             ? getShippingDetailsResponse!.pickUpByUser == true
//                                 ? const SizedBox(
//                                     height: 10,
//                                   )
//                                 : const SizedBox()
//                             : const SizedBox(),
//                         getShippingDetailsResponse != null
//                             ? getShippingDetailsResponse!.pickUpByUser == true
//                                 ? selectedCityDelivery ==
//                                         widget.cartDetailsResponse
//                                             .productCartList[0].City
//                                     ? Row(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   InkWell(
//                                                     child: Container(
//                                                       width: 20,
//                                                       height: 20,
//                                                       decoration:
//                                                           const BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color:
//                                                             kColorDarkGreyIcon,
//                                                       ),
//                                                       child: Center(
//                                                           child: Container(
//                                                         width: 18,
//                                                         height: 18,
//                                                         decoration:
//                                                             const BoxDecoration(
//                                                           shape:
//                                                               BoxShape.circle,
//                                                           color: kColorWhite,
//                                                         ),
//                                                         child: Center(
//                                                             child: Container(
//                                                           width: 13,
//                                                           height: 13,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             shape:
//                                                                 BoxShape.circle,
//                                                             color: pickUpAvailable ==
//                                                                     true
//                                                                 ? kColorPrimary
//                                                                 : kColorWhite,
//                                                           ),
//                                                         )),
//                                                       )),
//                                                     ),
//                                                     onTap: () {
//                                                       if (pickUpAvailable ==
//                                                           false) {
//                                                         setState(() {
//                                                           pickUpAvailable =
//                                                               true;
//                                                           banglaBazarPickup =
//                                                               false;
//                                                         });
//                                                       }
//                                                     },
//                                                   ),
//                                                   const SizedBox(
//                                                     width: 5,
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(
//                                                 width: 10,
//                                               ),
//                                               const Text(
//                                                 'Yes',
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 14),
//                                               )
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             width: 75,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   InkWell(
//                                                     child: Container(
//                                                       width: 20,
//                                                       height: 20,
//                                                       decoration:
//                                                           const BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color:
//                                                             kColorDarkGreyIcon,
//                                                       ),
//                                                       child: Center(
//                                                           child: Container(
//                                                         width: 18,
//                                                         height: 18,
//                                                         decoration:
//                                                             const BoxDecoration(
//                                                           shape:
//                                                               BoxShape.circle,
//                                                           color: kColorWhite,
//                                                         ),
//                                                         child: Center(
//                                                             child: Container(
//                                                           width: 13,
//                                                           height: 13,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             shape:
//                                                                 BoxShape.circle,
//                                                             color: pickUpAvailable ==
//                                                                     false
//                                                                 ? kColorPrimary
//                                                                 : kColorWhite,
//                                                           ),
//                                                         )),
//                                                       )),
//                                                     ),
//                                                     onTap: () {
//                                                       if (pickUpAvailable ==
//                                                           true) {
//                                                         setState(() {
//                                                           pickUpAvailable =
//                                                               false;
//                                                           banglaBazarPickup =
//                                                               true;
//                                                         });
//                                                       }
//                                                     },
//                                                   ),
//                                                   const SizedBox(
//                                                     width: 5,
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(
//                                                 width: 10,
//                                               ),
//                                               const Text(
//                                                 'No',
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 14),
//                                               )
//                                             ],
//                                           ),
//                                         ],
//                                       )
//                                     : const SizedBox()
//                                 : const SizedBox()
//                             : const SizedBox(),
//                         getShippingDetailsResponse != null
//                             ? getShippingDetailsResponse!.pickUpByUser == true
//                                 ? const SizedBox(
//                                     height: 25,
//                                   )
//                                 : const SizedBox()
//                             : const SizedBox(),
//                         SizedBox(
//                           height: screenSize.height * 0.01,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Container(
//                                 height: screenSize.height * 0.065,
//                                 width: screenSize.width * 0.43,
//                                 padding:
//                                     const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(6),
//                                   border:
//                                       Border.all(color: kColorFieldsBorders),
//                                   color: kColorWhite,
//                                 ),
//                                 child: const Center(
//                                   child: Text(
//                                     'Previous',
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                         color: kColorDarkGreyText,
//                                         fontSize: 16),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 if (widget.selectedCountryId == 226) {
//                                   if (verifyUspsAddress == true) {
//                                     if (nameController.text != '') {
//                                       if (address1Controller.text != '') {
//                                         if (address2Controller.text != '') {
//                                           if (_chooseCountryCode != '') {
//                                             if (phoneNumberController
//                                                     .text.length ==
//                                                 10) {
//                                               if (zipCodeController.text !=
//                                                   '') {
//                                                 if (selectedCity != '') {
//                                                   if (createdDateController
//                                                           .text !=
//                                                       '') {
//                                                     if (nameDeliveryController
//                                                             .text !=
//                                                         '') {
//                                                       if (address1DeliveryController
//                                                               .text !=
//                                                           '') {
//                                                         if (address2DeliveryController
//                                                                 .text !=
//                                                             '') {
//                                                           if (phoneDeliveryNumberController
//                                                                       .text !=
//                                                                   '' &&
//                                                               _chooseCountryCodeDelivery !=
//                                                                   '') {
//                                                             if (zipCodeDeliveryController
//                                                                     .text !=
//                                                                 '') {
//                                                               if (selectedCityDelivery !=
//                                                                   '') {
//                                                                 if (selectedCityDelivery !=
//                                                                     widget
//                                                                         .cartDetailsResponse
//                                                                         .productCartList[
//                                                                             0]
//                                                                         .City) {
//                                                                   pickUpAvailable =
//                                                                       false;
//                                                                 }
//
//                                                                 if (checkDeliveryDriverResponse !=
//                                                                     null) {
//                                                                   if (checkDeliveryDriverResponse!
//                                                                           .deliveryDriverStatus ==
//                                                                       false) {
//                                                                     productsAndUserCitiesAreSame =
//                                                                         false;
//                                                                   } else if (checkDeliveryDriverResponse!
//                                                                           .deliveryDriverStatus ==
//                                                                       true) {
//                                                                     productsAndUserCitiesAreSame =
//                                                                         true;
//                                                                   }
//                                                                 }
//                                                                 print(
//                                                                     '???????12');
//                                                                 if (selectedCity !=
//                                                                     widget
//                                                                         .cartDetailsResponse
//                                                                         .productCartList[
//                                                                             0]
//                                                                         .City) {
//                                                                   print(
//                                                                       '???????34');
//                                                                   productsAndUserCitiesAreSame =
//                                                                       false;
//                                                                 }
//                                                                 if (productsAndUserCitiesAreSame ==
//                                                                     true) {
//                                                                   checkDeliveryDriverModel =
//                                                                       CheckDeliveryDriverModel(
//                                                                           CityName:
//                                                                               selectedCity);
//                                                                   _cartBloc.add(
//                                                                       CheckDriverAvailability(
//                                                                           checkDeliveryDriverModel:
//                                                                               checkDeliveryDriverModel!));
//                                                                 } else {
//                                                                   if (widget
//                                                                           .selectedCountryId ==
//                                                                       226) {
//                                                                     uspsRateCalculationModel = UspsRateCalculationModel(
//                                                                         originationZip: int.parse(widget
//                                                                             .cartDetailsResponse
//                                                                             .productCartList[
//                                                                                 0]
//                                                                             .VendorStoreZip!),
//                                                                         destinationZip:
//                                                                             int.parse(zipCodeDeliveryController
//                                                                                 .text),
//                                                                         pounds: double.parse(widget.cartDetailsResponse.productCartList[0].Weight)
//                                                                             .ceil(),
//                                                                         ounces:
//                                                                             1,
//                                                                         height: double.parse(widget.cartDetailsResponse.productCartList[0].Height)
//                                                                             .ceil(),
//                                                                         width: double.parse(widget.cartDetailsResponse.productCartList[0].Width)
//                                                                             .ceil(),
//                                                                         length:
//                                                                             double.parse(widget.cartDetailsResponse.productCartList[0].Length).ceil());
//                                                                     _cartBloc.add(UspsCalculateRate(
//                                                                         uspsRateCalculationModel:
//                                                                             uspsRateCalculationModel!));
//                                                                   }
//                                                                 }
//
//                                                                 ///
//
//                                                               } else {
//                                                                 Fluttertoast.showToast(
//                                                                     msg:
//                                                                         'Please enter delivery City',
//                                                                     toastLength:
//                                                                         Toast
//                                                                             .LENGTH_SHORT,
//                                                                     gravity: ToastGravity
//                                                                         .BOTTOM,
//                                                                     timeInSecForIosWeb:
//                                                                         1,
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .grey
//                                                                             .shade400,
//                                                                     textColor:
//                                                                         Colors
//                                                                             .white,
//                                                                     fontSize:
//                                                                         12.0);
//                                                               }
//                                                             } else {
//                                                               Fluttertoast.showToast(
//                                                                   msg:
//                                                                       'Please enter delivery zip code',
//                                                                   toastLength: Toast
//                                                                       .LENGTH_SHORT,
//                                                                   gravity:
//                                                                       ToastGravity
//                                                                           .BOTTOM,
//                                                                   timeInSecForIosWeb:
//                                                                       1,
//                                                                   backgroundColor:
//                                                                       Colors
//                                                                           .grey
//                                                                           .shade400,
//                                                                   textColor:
//                                                                       Colors
//                                                                           .white,
//                                                                   fontSize:
//                                                                       12.0);
//                                                             }
//                                                           } else {
//                                                             Fluttertoast.showToast(
//                                                                 msg:
//                                                                     'Please enter correct delivery phone number',
//                                                                 toastLength: Toast
//                                                                     .LENGTH_SHORT,
//                                                                 gravity:
//                                                                     ToastGravity
//                                                                         .BOTTOM,
//                                                                 timeInSecForIosWeb:
//                                                                     1,
//                                                                 backgroundColor:
//                                                                     Colors.grey
//                                                                         .shade400,
//                                                                 textColor:
//                                                                     Colors
//                                                                         .white,
//                                                                 fontSize: 12.0);
//                                                           }
//                                                         } else {
//                                                           Fluttertoast.showToast(
//                                                               msg:
//                                                                   'Please enter delivery address2',
//                                                               toastLength: Toast
//                                                                   .LENGTH_SHORT,
//                                                               gravity:
//                                                                   ToastGravity
//                                                                       .BOTTOM,
//                                                               timeInSecForIosWeb:
//                                                                   1,
//                                                               backgroundColor:
//                                                                   Colors.grey
//                                                                       .shade400,
//                                                               textColor:
//                                                                   Colors.white,
//                                                               fontSize: 12.0);
//                                                         }
//                                                       } else {
//                                                         Fluttertoast.showToast(
//                                                             msg:
//                                                                 'Please enter delivery address1',
//                                                             toastLength: Toast
//                                                                 .LENGTH_SHORT,
//                                                             gravity:
//                                                                 ToastGravity
//                                                                     .BOTTOM,
//                                                             timeInSecForIosWeb:
//                                                                 1,
//                                                             backgroundColor:
//                                                                 Colors.grey
//                                                                     .shade400,
//                                                             textColor:
//                                                                 Colors.white,
//                                                             fontSize: 12.0);
//                                                       }
//                                                     } else {
//                                                       Fluttertoast.showToast(
//                                                           msg:
//                                                               'Please enter Name of person to deliver',
//                                                           toastLength: Toast
//                                                               .LENGTH_SHORT,
//                                                           gravity: ToastGravity
//                                                               .BOTTOM,
//                                                           timeInSecForIosWeb: 1,
//                                                           backgroundColor:
//                                                               Colors.grey
//                                                                   .shade400,
//                                                           textColor:
//                                                               Colors.white,
//                                                           fontSize: 12.0);
//                                                     }
//                                                   } else {
//                                                     Fluttertoast.showToast(
//                                                         msg:
//                                                             'Please enter a Desire Date',
//                                                         toastLength:
//                                                             Toast.LENGTH_SHORT,
//                                                         gravity:
//                                                             ToastGravity.BOTTOM,
//                                                         timeInSecForIosWeb: 1,
//                                                         backgroundColor: Colors
//                                                             .grey.shade400,
//                                                         textColor: Colors.white,
//                                                         fontSize: 12.0);
//                                                   }
//                                                 } else {
//                                                   Fluttertoast.showToast(
//                                                       msg:
//                                                           'Please select a City',
//                                                       toastLength:
//                                                           Toast.LENGTH_SHORT,
//                                                       gravity:
//                                                           ToastGravity.BOTTOM,
//                                                       timeInSecForIosWeb: 1,
//                                                       backgroundColor:
//                                                           Colors.grey.shade400,
//                                                       textColor: Colors.white,
//                                                       fontSize: 12.0);
//                                                 }
//                                               } else {
//                                                 Fluttertoast.showToast(
//                                                     msg:
//                                                         'Please enter Zip Code',
//                                                     toastLength:
//                                                         Toast.LENGTH_SHORT,
//                                                     gravity:
//                                                         ToastGravity.BOTTOM,
//                                                     timeInSecForIosWeb: 1,
//                                                     backgroundColor:
//                                                         Colors.grey.shade400,
//                                                     textColor: Colors.white,
//                                                     fontSize: 12.0);
//                                               }
//                                             } else {
//                                               widget.selectedCountryId == 16
//                                                   ? Fluttertoast.showToast(
//                                                       msg:
//                                                           'Please enter valid phone number contains 16 numbers',
//                                                       toastLength:
//                                                           Toast.LENGTH_SHORT,
//                                                       gravity:
//                                                           ToastGravity.BOTTOM,
//                                                       timeInSecForIosWeb: 1,
//                                                       backgroundColor:
//                                                           Colors.grey.shade400,
//                                                       textColor: Colors.white,
//                                                       fontSize: 12.0)
//                                                   : Fluttertoast.showToast(
//                                                       msg:
//                                                           'Please enter phone number',
//                                                       toastLength:
//                                                           Toast.LENGTH_SHORT,
//                                                       gravity:
//                                                           ToastGravity.BOTTOM,
//                                                       timeInSecForIosWeb: 1,
//                                                       backgroundColor:
//                                                           Colors.grey.shade400,
//                                                       textColor: Colors.white,
//                                                       fontSize: 12.0);
//                                             }
//                                           } else {
//                                             Fluttertoast.showToast(
//                                                 msg:
//                                                     'Please select Phone Number Country Code',
//                                                 toastLength: Toast.LENGTH_SHORT,
//                                                 gravity: ToastGravity.BOTTOM,
//                                                 timeInSecForIosWeb: 1,
//                                                 backgroundColor:
//                                                     Colors.grey.shade400,
//                                                 textColor: Colors.white,
//                                                 fontSize: 12.0);
//                                           }
//                                         } else {
//                                           Fluttertoast.showToast(
//                                               msg: 'Please enter Address 2',
//                                               toastLength: Toast.LENGTH_SHORT,
//                                               gravity: ToastGravity.BOTTOM,
//                                               timeInSecForIosWeb: 1,
//                                               backgroundColor:
//                                                   Colors.grey.shade400,
//                                               textColor: Colors.white,
//                                               fontSize: 12.0);
//                                         }
//                                       } else {
//                                         Fluttertoast.showToast(
//                                             msg: 'Please enter Address 1',
//                                             toastLength: Toast.LENGTH_SHORT,
//                                             gravity: ToastGravity.BOTTOM,
//                                             timeInSecForIosWeb: 1,
//                                             backgroundColor:
//                                                 Colors.grey.shade400,
//                                             textColor: Colors.white,
//                                             fontSize: 12.0);
//                                       }
//                                     } else {
//                                       Fluttertoast.showToast(
//                                           msg: 'Please enter full name',
//                                           toastLength: Toast.LENGTH_SHORT,
//                                           gravity: ToastGravity.BOTTOM,
//                                           timeInSecForIosWeb: 1,
//                                           backgroundColor: Colors.grey.shade400,
//                                           textColor: Colors.white,
//                                           fontSize: 12.0);
//                                     }
//                                   } else {
//                                     Fluttertoast.showToast(
//                                         msg:
//                                             'Delivery addresses and zip code you entered is wrong.',
//                                         toastLength: Toast.LENGTH_SHORT,
//                                         gravity: ToastGravity.BOTTOM,
//                                         timeInSecForIosWeb: 1,
//                                         backgroundColor: Colors.grey.shade400,
//                                         textColor: Colors.white,
//                                         fontSize: 12.0);
//                                   }
//                                 } else {
//                                   /// For pathao and bangladaesh
//                                   if (nameController.text != '') {
//                                     if (address1Controller.text.length > 25) {
//                                       if (_chooseCountryCode != '') {
//                                         if (phoneNumberController.text.length ==
//                                             11) {
//                                           if (zipCodeController.text != '') {
//                                             if (selectedCity != '') {
//                                               if (createdDateController.text !=
//                                                   '') {
//                                                 if (nameDeliveryController
//                                                         .text !=
//                                                     '') {
//                                                   if (address1DeliveryController
//                                                           .text.length >
//                                                       25) {
//                                                     if (phoneDeliveryNumberController
//                                                                 .text !=
//                                                             '' &&
//                                                         _chooseCountryCodeDelivery !=
//                                                             '') {
//                                                       if (zipCodeDeliveryController
//                                                               .text !=
//                                                           '') {
//                                                         if (selectedDeliveryCity !=
//                                                             '') {
//                                                           if (selectedDeliveryZone !=
//                                                               '') {
//                                                             if (selectedDeliveryArea !=
//                                                                 '') {
//                                                               if (selectedDeliveryCity !=
//                                                                   widget
//                                                                       .cartDetailsResponse
//                                                                       .productCartList[
//                                                                           0]
//                                                                       .City) {
//                                                                 pickUpAvailable =
//                                                                     false;
//                                                               }
//                                                               paymentUserData = PaymentUserData(
//                                                                   name: nameController
//                                                                       .text,
//                                                                   address1:
//                                                                       address1Controller
//                                                                           .text,
//                                                                   address2:
//                                                                       address2Controller
//                                                                           .text,
//                                                                   phoneCode:
//                                                                       _chooseCountryCode,
//                                                                   phoneNumber:
//                                                                       phoneNumberController
//                                                                           .text,
//                                                                   country: widget.selectedCountryId == 16
//                                                                       ? 'Bangladesh'
//                                                                       : 'USA',
//                                                                   zipCode: zipCodeController
//                                                                       .text,
//                                                                   state:
//                                                                       selectedState,
//                                                                   city:
//                                                                       selectedCity,
//                                                                   createdAtDate:
//                                                                       createdDateController
//                                                                           .text,
//                                                                   adminNote:
//                                                                       adminNoteController
//                                                                           .text,
//                                                                   cityID:
//                                                                       selectedCityId,
//                                                                   countryID: widget
//                                                                       .selectedCountryId,
//                                                                   banglaBazarDelivery:
//                                                                       banglaBazarPickup,
//                                                                   pickUp:
//                                                                       pickUpAvailable,
//                                                                   address1Delivery:
//                                                                       address1DeliveryController
//                                                                           .text,
//                                                                   address2Delivery:
//                                                                       address2DeliveryController
//                                                                           .text,
//                                                                   adminNoteDelivery:
//                                                                       adminDeliveryNoteController
//                                                                           .text,
//                                                                   phoneNumberDelivery:
//                                                                       phoneDeliveryNumberController
//                                                                           .text,
//                                                                   nameDelivery:
//                                                                       nameDeliveryController
//                                                                           .text,
//                                                                   zipCodeDelivery:
//                                                                       zipCodeDeliveryController
//                                                                           .text,
//                                                                   stateDelivery:
//                                                                       selectedStateDelivery,
//                                                                   phoneCodeDelivery:
//                                                                       _chooseCountryCodeDelivery,
//                                                                   cityDelivery:
//                                                                       selectedDeliveryCity);
//
//                                                               print(
//                                                                   pathaoPriceCalculationResponse!);
//
//                                                               ///
//                                                               // widget
//                                                               //     .cartDetailsResponse
//                                                               //     .cartTotalPrice = widget
//                                                               //         .cartDetailsResponse
//                                                               //         .cartTotalPrice +
//                                                               //     pathaoPriceCalculationResponse!
//                                                               //         .data
//                                                               //         .price;
//
//                                                               if (checkDeliveryDriverResponse !=
//                                                                   null) {
//                                                                 if (checkDeliveryDriverResponse!
//                                                                         .deliveryDriverStatus ==
//                                                                     false) {
//                                                                   productsAndUserCitiesAreSame =
//                                                                       false;
//                                                                 } else if (checkDeliveryDriverResponse!
//                                                                         .deliveryDriverStatus ==
//                                                                     true) {
//                                                                   productsAndUserCitiesAreSame =
//                                                                       true;
//                                                                 }
//                                                               }
//
//                                                               Navigator.push(
//                                                                 context,
//                                                                 MaterialPageRoute(
//                                                                   builder:
//                                                                       (context) =>
//                                                                           CheckoutPaymentScreen(
//                                                                     cartDetailsResponse:
//                                                                         widget
//                                                                             .cartDetailsResponse,
//                                                                     paymentUserData:
//                                                                         paymentUserData!,
//                                                                     selectedZoneId:
//                                                                         selectedDeliveryZoneId,
//                                                                     selectedCountryId:
//                                                                         widget
//                                                                             .selectedCountryId,
//                                                                     selectedAreaId:
//                                                                         selectedDeliveryAreaId,
//                                                                     selectedCityId:
//                                                                         selectedDeliveryCityId,
//                                                                     productsAndUserCitiesAreSame:
//                                                                         productsAndUserCitiesAreSame,
//                                                                     creditCardPayment:
//                                                                         widget
//                                                                             .creditCardPayment,
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                             } else {
//                                                               Fluttertoast.showToast(
//                                                                   msg:
//                                                                       'Please enter delivery area',
//                                                                   toastLength: Toast
//                                                                       .LENGTH_SHORT,
//                                                                   gravity:
//                                                                       ToastGravity
//                                                                           .BOTTOM,
//                                                                   timeInSecForIosWeb:
//                                                                       1,
//                                                                   backgroundColor:
//                                                                       Colors
//                                                                           .grey
//                                                                           .shade400,
//                                                                   textColor:
//                                                                       Colors
//                                                                           .white,
//                                                                   fontSize:
//                                                                       12.0);
//                                                             }
//                                                           } else {
//                                                             Fluttertoast.showToast(
//                                                                 msg:
//                                                                     'Please enter delivery zone',
//                                                                 toastLength: Toast
//                                                                     .LENGTH_SHORT,
//                                                                 gravity:
//                                                                     ToastGravity
//                                                                         .BOTTOM,
//                                                                 timeInSecForIosWeb:
//                                                                     1,
//                                                                 backgroundColor:
//                                                                     Colors.grey
//                                                                         .shade400,
//                                                                 textColor:
//                                                                     Colors
//                                                                         .white,
//                                                                 fontSize: 12.0);
//                                                           }
//                                                         } else {
//                                                           Fluttertoast.showToast(
//                                                               msg:
//                                                                   'Please enter delivery City',
//                                                               toastLength: Toast
//                                                                   .LENGTH_SHORT,
//                                                               gravity:
//                                                                   ToastGravity
//                                                                       .BOTTOM,
//                                                               timeInSecForIosWeb:
//                                                                   1,
//                                                               backgroundColor:
//                                                                   Colors.grey
//                                                                       .shade400,
//                                                               textColor:
//                                                                   Colors.white,
//                                                               fontSize: 12.0);
//                                                         }
//                                                       } else {
//                                                         Fluttertoast.showToast(
//                                                             msg:
//                                                                 'Please enter delivery zip code',
//                                                             toastLength: Toast
//                                                                 .LENGTH_SHORT,
//                                                             gravity:
//                                                                 ToastGravity
//                                                                     .BOTTOM,
//                                                             timeInSecForIosWeb:
//                                                                 1,
//                                                             backgroundColor:
//                                                                 Colors.grey
//                                                                     .shade400,
//                                                             textColor:
//                                                                 Colors.white,
//                                                             fontSize: 12.0);
//                                                       }
//                                                     } else {
//                                                       Fluttertoast.showToast(
//                                                           msg:
//                                                               'Please enter correct delivery phone number',
//                                                           toastLength: Toast
//                                                               .LENGTH_SHORT,
//                                                           gravity: ToastGravity
//                                                               .BOTTOM,
//                                                           timeInSecForIosWeb: 1,
//                                                           backgroundColor:
//                                                               Colors.grey
//                                                                   .shade400,
//                                                           textColor:
//                                                               Colors.white,
//                                                           fontSize: 12.0);
//                                                     }
//                                                   } else {
//                                                     Fluttertoast.showToast(
//                                                         msg:
//                                                             'Please enter delivery address 1 of length minimum 25 characters',
//                                                         toastLength:
//                                                             Toast.LENGTH_SHORT,
//                                                         gravity:
//                                                             ToastGravity.BOTTOM,
//                                                         timeInSecForIosWeb: 1,
//                                                         backgroundColor: Colors
//                                                             .grey.shade400,
//                                                         textColor: Colors.white,
//                                                         fontSize: 12.0);
//                                                   }
//                                                 } else {
//                                                   Fluttertoast.showToast(
//                                                       msg:
//                                                           'Please enter Name of person to deliver',
//                                                       toastLength:
//                                                           Toast.LENGTH_SHORT,
//                                                       gravity:
//                                                           ToastGravity.BOTTOM,
//                                                       timeInSecForIosWeb: 1,
//                                                       backgroundColor:
//                                                           Colors.grey.shade400,
//                                                       textColor: Colors.white,
//                                                       fontSize: 12.0);
//                                                 }
//                                               } else {
//                                                 Fluttertoast.showToast(
//                                                     msg:
//                                                         'Please enter a Desire Date',
//                                                     toastLength:
//                                                         Toast.LENGTH_SHORT,
//                                                     gravity:
//                                                         ToastGravity.BOTTOM,
//                                                     timeInSecForIosWeb: 1,
//                                                     backgroundColor:
//                                                         Colors.grey.shade400,
//                                                     textColor: Colors.white,
//                                                     fontSize: 12.0);
//                                               }
//                                             } else {
//                                               Fluttertoast.showToast(
//                                                   msg: 'Please select a City',
//                                                   toastLength:
//                                                       Toast.LENGTH_SHORT,
//                                                   gravity: ToastGravity.BOTTOM,
//                                                   timeInSecForIosWeb: 1,
//                                                   backgroundColor:
//                                                       Colors.grey.shade400,
//                                                   textColor: Colors.white,
//                                                   fontSize: 12.0);
//                                             }
//                                           } else {
//                                             Fluttertoast.showToast(
//                                                 msg: 'Please enter Zip Code',
//                                                 toastLength: Toast.LENGTH_SHORT,
//                                                 gravity: ToastGravity.BOTTOM,
//                                                 timeInSecForIosWeb: 1,
//                                                 backgroundColor:
//                                                     Colors.grey.shade400,
//                                                 textColor: Colors.white,
//                                                 fontSize: 12.0);
//                                           }
//                                         } else {
//                                           widget.selectedCountryId == 16
//                                               ? Fluttertoast.showToast(
//                                                   msg:
//                                                       'Please enter valid phone number contains 16 numbers',
//                                                   toastLength:
//                                                       Toast.LENGTH_SHORT,
//                                                   gravity: ToastGravity.BOTTOM,
//                                                   timeInSecForIosWeb: 1,
//                                                   backgroundColor:
//                                                       Colors.grey.shade400,
//                                                   textColor: Colors.white,
//                                                   fontSize: 12.0)
//                                               : Fluttertoast.showToast(
//                                                   msg:
//                                                       'Please enter phone number',
//                                                   toastLength:
//                                                       Toast.LENGTH_SHORT,
//                                                   gravity: ToastGravity.BOTTOM,
//                                                   timeInSecForIosWeb: 1,
//                                                   backgroundColor:
//                                                       Colors.grey.shade400,
//                                                   textColor: Colors.white,
//                                                   fontSize: 12.0);
//                                         }
//                                       } else {
//                                         Fluttertoast.showToast(
//                                             msg:
//                                                 'Please select Phone Number Country Code',
//                                             toastLength: Toast.LENGTH_SHORT,
//                                             gravity: ToastGravity.BOTTOM,
//                                             timeInSecForIosWeb: 1,
//                                             backgroundColor:
//                                                 Colors.grey.shade400,
//                                             textColor: Colors.white,
//                                             fontSize: 12.0);
//                                       }
//                                     } else {
//                                       Fluttertoast.showToast(
//                                           msg:
//                                               'Please enter Address 1 of length minimum 25 characters',
//                                           toastLength: Toast.LENGTH_SHORT,
//                                           gravity: ToastGravity.BOTTOM,
//                                           timeInSecForIosWeb: 1,
//                                           backgroundColor: Colors.grey.shade400,
//                                           textColor: Colors.white,
//                                           fontSize: 12.0);
//                                     }
//                                   } else {
//                                     Fluttertoast.showToast(
//                                         msg: 'Please enter full name',
//                                         toastLength: Toast.LENGTH_SHORT,
//                                         gravity: ToastGravity.BOTTOM,
//                                         timeInSecForIosWeb: 1,
//                                         backgroundColor: Colors.grey.shade400,
//                                         textColor: Colors.white,
//                                         fontSize: 12.0);
//                                   }
//                                 }
//                               },
//                               child: Container(
//                                 height: screenSize.height * 0.065,
//                                 width: screenSize.width * 0.43,
//                                 padding:
//                                     const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(6),
//                                   color: kColorPrimary,
//                                 ),
//                                 child: const Center(
//                                   child: Text(
//                                     'Next',
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                         color: kColorWhite, fontSize: 16),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: screenSize.height * 0.2,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 ///This is appbar
//                 Column(
//                   children: [
//                     Container(
//                       color: kColorWhite,
//                       width: screenSize.width,
//                       height: screenSize.height * 0.042,
//                     ),
//                     Container(
//                         color: kColorWhite,
//                         width: screenSize.width,
//                         height: screenSize.height * 0.09,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Image.asset(
//                                 'assets/images/BanglaBazarLogo.png',
//                                 width: screenSize.width * 0.50,
//                               ),
//                             ],
//                           ),
//                         )),
//                   ],
//                 ),
//               ],
//             )),
//       );
//     });
//   }
//
//   late File _image;
//   final picker = ImagePicker();
//   late String _imagePath;
//
//   Future getImage(final pickedFileSelected) async {
//     final pickedFile = await pickedFileSelected;
//     // _userEditRequestModel.profilePic = pickedFile;
//
//     if (pickedFile != null) {
//       _image = File(pickedFile.path);
//       File rotatedImage =
//           await FlutterExifRotation.rotateImage(path: _image.path);
//
//       _image = rotatedImage;
//
//       // _loginBloc.add(UploadProfilePic(
//       //   userid: AppGlobal.userID.toString(),
//       //   selectedImage: _image,
//       // ));
//
//       print('Image Path: $_image');
//     } else {
//       print('No image selected.');
//     }
//   }
//
//   _pickDate() async {
//     DateTime? date = await showDatePicker(
//       context: context,
//       initialDate: pickedDate,
//       firstDate: DateTime(DateTime.now().year - 100),
//       lastDate: DateTime(DateTime.now().year + 100),
//     );
//
//     if (date != null) {
//       pickedDate = date;
//
//       print('picked Date' + pickedDate.toString());
//       createdDateController.text =
//           DateFormat('yyyy-MM-dd').format(pickedDate).toString();
//       setState(() {});
//     }
//   }
//
//   void cameraBottomNavigationSheet() {
//     showModalBottomSheet(
//         elevation: 5,
//         context: context,
//         backgroundColor: kColorWidgetBackgroundColor,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
//         ),
//         builder: (context) {
//           var screenSize = MediaQuery.of(context).size;
//           return Container(
//             height: screenSize.height * 0.30,
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       IconButton(
//                           icon: const Icon(
//                             Icons.arrow_back_ios_rounded,
//                             color: Colors.black,
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           }),
//                       const Text(
//                         'Add Profile Pic',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: screenSize.height * 0.03,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       children: [
//                         BottomSheetFilterByWidget(
//                           icon: Icons.add_a_photo,
//                           buttonLabel: 'Take picture',
//                           onPressed: () {
//                             Navigator.pop(context);
//                             getImage(
//                                 picker.pickImage(source: ImageSource.camera));
//                           },
//                         ),
//                         BottomSheetFilterByWidget(
//                           icon: Icons.add_photo_alternate,
//                           buttonLabel: 'Browse gallery',
//                           onPressed: () {
//                             getImage(
//                                 picker.pickImage(source: ImageSource.gallery));
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   Widget _buildDialogItem(country) => Row(
//         children: <Widget>[
//           CountryPickerUtils.getDefaultFlagImage(country),
//           const SizedBox(width: 8.0),
//           Text("+${country.phoneCode}"),
//           const SizedBox(width: 8.0),
//           Flexible(child: Text(country.name))
//         ],
//       );
//
//   void _openCountryPickerDialog() => showDialog(
//         context: context,
//         builder: (context) => Theme(
//           data: Theme.of(context).copyWith(primaryColor: Colors.pink),
//           child: CountryPickerDialog(
//             titlePadding: const EdgeInsets.all(8.0),
//             searchCursorColor: Colors.pinkAccent,
//             searchInputDecoration: const InputDecoration(hintText: 'Search...'),
//             isSearchable: true,
//             title: const Text('Select your country'),
//             onValuePicked: (country) {
//               setState(() => _selectedDialogCountry = country);
//
//               for (int i = 0;
//                   i < widget.allowedCountriesResponse.countries.length;
//                   i++) {
//                 if (widget.allowedCountriesResponse.countries[i].ISO2 ==
//                     _selectedDialogCountry.isoCode) {
//                   if (selectedPaymentCountryID !=
//                       widget.allowedCountriesResponse.countries[i].CountryID) {
//                     selectedCity = '';
//                     selectedState = '';
//                     selectedCityDelivery = '';
//                     selectedStateDelivery = '';
//                     // widget.allowedVendorStatesResponse!.states.clear();
//                     // widget.allowedVendorCityResponse!.cities.clear();
//                   }
//                   selectedPaymentCountryID =
//                       widget.allowedCountriesResponse.countries[i].CountryID;
//                   countryPaymentSelected=true;
//
//                   _cartBloc.add(GetVendorAllowedStates(
//                       id: widget
//                           .allowedCountriesResponse.countries[i].CountryID));
//                   _cartBloc.add(GetVendorAllowedCities(
//                       id: widget
//                           .allowedCountriesResponse.countries[i].CountryID));
//                   break;
//                 }
//               }
//             },
//
//             itemFilter: (c) =>
//                 widget.allowedCountriesISO2List.contains(c.isoCode),
//             itemBuilder: _buildDialogItem,
//             // priorityList: [
//             //   CountryPickerUtils.getCountryByIsoCode('TR'),
//             //   CountryPickerUtils.getCountryByIsoCode('US'),
//             // ],
//           ),
//         ),
//       );
//   void _countryCodePickerDialog({required bool deliveryPhone}) => showDialog(
//       context: context,
//       builder: (context) => Theme(
//             data: Theme.of(context).copyWith(primaryColor: Colors.pink),
//             child: CountryPickerDialog(
//               titlePadding: const EdgeInsets.all(8.0),
//               searchCursorColor: Colors.pinkAccent,
//               searchInputDecoration:
//                   const InputDecoration(hintText: 'Search...'),
//               isSearchable: true,
//               title: const Text('Select your phone code'),
//               onValuePicked: (country) {
//                 if (deliveryPhone == false) {
//                   _chooseCountryCode = '+' + country.phoneCode;
//                 } else {
//                   _chooseCountryCodeDelivery = '+' + country.phoneCode;
//                 }
//                 setState(() {});
//               },
//
//               itemFilter: (c) =>
//                   widget.allowedCountriesISO2List.contains(c.isoCode),
//               itemBuilder: _buildDialogItem,
//               // priorityList: [
//               //   CountryPickerUtils.getCountryByIsoCode('TR'),
//               //   CountryPickerUtils.getCountryByIsoCode('US'),
//               // ],
//             ),
//           ));
// }

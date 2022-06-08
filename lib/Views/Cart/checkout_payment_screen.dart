import 'dart:convert';

import 'package:bangla_bazar/ModelClasses/BangladeshPaymentUserData.dart';
import 'package:bangla_bazar/ModelClasses/add_user_payment_model.dart';
import 'package:bangla_bazar/ModelClasses/add_user_payment_response.dart';
import 'package:bangla_bazar/ModelClasses/auth_net_payment_model.dart';
import 'package:bangla_bazar/ModelClasses/auth_net_payment_response.dart';
import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_price_calculation_response.dart';
import 'package:bangla_bazar/ModelClasses/ssl_commerz_init_response.dart';
import 'package:bangla_bazar/ModelClasses/stripe_response.dart';
import 'package:bangla_bazar/ModelClasses/stripe_trans_init_model.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/Cart/CartBloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CheckoutPaymentScreen extends StatefulWidget {
  CartDetailsResponse cartDetailsResponse;
  // PaymentUserData paymentUserData;
  int selectedCountryId;
  // int selectedCityId;
  // int selectedZoneId;
  // int selectedAreaId;
  bool productsAndUserCitiesAreSame;
  bool creditCardPayment;
  BangladeshPaymentUserData? bangladeshPaymentUserData;
  PathaoPriceCalculationResponse? pathaoPriceCalculationResponse;

  CheckoutPaymentScreen(
      {Key? key,
      required this.cartDetailsResponse,
      //required this.paymentUserData,
      required this.selectedCountryId,
      // required this.selectedCityId,
      // required this.selectedZoneId,
      // required this.selectedAreaId,
      required this.productsAndUserCitiesAreSame,
      required this.creditCardPayment,required this.bangladeshPaymentUserData,required this.pathaoPriceCalculationResponse,})
      : super(key: key);
  @override
  _CheckoutPaymentScreenState createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  late CartBloc _cartBloc;
  TextEditingController cardNumberController = TextEditingController();

  TextEditingController cvvCardController = TextEditingController();
  TextEditingController createdDateController = TextEditingController();

  late DateTime pickedDate;

  bool rememberMe = false;
 // int paymentMethod = 0;

  //TransInitModel? transInitModel;
  SSLCommerzInitResponse? sslCommerzInitResponse;
  AddUserPaymentModel? addUserPaymentModel;
  AddUserPaymentResponse? addUserPaymentResponse;
  AuthorizedNetPaymentModel? authorizedNetPaymentModel;
  AuthorizedNetPaymentResponse? authorizedNetPaymentResponse;

  StripeTransInitModel? stripeTransInitModel;

  // cash_delivery.CashOnDeliveryInit? cashOnDeliveryInit;
  // CashOnDeliveryInitResponse? cashOnDeliveryInitResponse;

  String deliveryStatus = '';
  StripInitResponse? stripInitResponse;

  Map<String, dynamic>? paymentIntentData;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();

    _cartBloc = BlocProvider.of<CartBloc>(context);

    ///ToDo: Change Pakistan to Bangladesh while deploying
    // if (widget.paymentUserData.country == 'Bangladesh' &&
    //     widget.creditCardPayment == true) {
    //   paymentMethod = 2;
    // } else if (widget.creditCardPayment == false) {
    //   paymentMethod = 3;
    // } else {
    //   paymentMethod = 1;
    // }

    ///ToDo: Only for testing Authorized.net payment method

    // paymentMethod = 1;

    ///Remove this after implement new SSL Api
    // if (paymentMethod == 2 || (paymentMethod == 3)) {
    //   addUserPaymentModel = AddUserPaymentModel(
    //       Name: widget.paymentUserData.name,
    //       CardNumber: cardNumberController.text,
    //       ExpirationDate: createdDateController.text,
    //       Address1: widget.paymentUserData.address1,
    //       Address2: widget.paymentUserData.address2,
    //       City: widget.paymentUserData.city,
    //       State: widget.paymentUserData.state != null
    //           ? widget.paymentUserData.state!
    //           : '',
    //       ZipCode: widget.paymentUserData.zipCode,
    //       CountryID: widget.paymentUserData.countryID.toString(),
    //       PaymentAccount: '1111',
    //       PaymentRouting: '9838',
    //       GatewayID: '4',
    //       DefaultPayment: 'Y',
    //       PhoneNumber: widget.paymentUserData.phoneNumber,
    //       DefaultAddress: 'Y',
    //       UserNote: widget.paymentUserData.adminNote);
    //   _cartBloc.add(AddUserPayment(addUserPaymentModel: addUserPaymentModel!));
    // }

    if (widget.bangladeshPaymentUserData!.countryID == 16 &&
        widget.productsAndUserCitiesAreSame == true) {
      deliveryStatus = 'dd';
    } else if (widget.bangladeshPaymentUserData!.countryID == 16 &&
        widget.productsAndUserCitiesAreSame == false) {
      deliveryStatus = 'pathao';
    } else if (widget.bangladeshPaymentUserData!.countryID == 226 &&
        widget.productsAndUserCitiesAreSame == true) {
      deliveryStatus = 'dd';
    } else if (widget.bangladeshPaymentUserData!.countryID == 226 &&
        widget.productsAndUserCitiesAreSame == false) {
      deliveryStatus = 'usps';
    }
    initializePaymentProcess();

  }
  void initializePaymentProcess() {
    pickedDate = DateTime.now();

    _cartBloc = BlocProvider.of<CartBloc>(context);

    ///ToDo: Change Pakistan to Bangladesh while deploying
    // if (widget.bangladeshPaymentUserData!.country == 'Bangladesh' &&
    //     widget.creditCardPayment == true) {
    //   ///SSLCommerce
    //   paymentMethod = 2;
    // } else if (widget.creditCardPayment == false) {
    //   ///Cash on delivery
    //   paymentMethod = 3;
    // } else {
    //   ///Authorized.Net
    //   paymentMethod = 1;
    // }

    stripeTransInitModel = StripeTransInitModel(
        SessionID: AppGlobal.token,
        GatewayID: '4',
        GetawayConfirmation: 'Yes',
        Name: widget.bangladeshPaymentUserData!.name!,
        CardNumber: widget.bangladeshPaymentUserData!.cardNumber!,
        ExpirationDate: null,
        Address1: widget.bangladeshPaymentUserData!.address1!,
        Address2: widget.bangladeshPaymentUserData!.address2!,
        City: widget.bangladeshPaymentUserData!.city!,
        State: widget.bangladeshPaymentUserData!.state,
        ZipCode: widget.bangladeshPaymentUserData!.zipCode,
        CountryID: widget.bangladeshPaymentUserData!.countryID.toString(),
        Country: widget.bangladeshPaymentUserData!.country,
        PaymentAccount: "NULL",
        PaymentRouting: "NULL",
        DefaultPayment: "N",
        currency:
        widget.cartDetailsResponse.productCartList[0].Currency == 'BDT' ? 'BDT' : '\$',
        shippingMethod: 'NO',
        productName: widget.cartDetailsResponse.productCartList[0].Title!,
        productCategory: widget.cartDetailsResponse.productCartList[0].Title!,
        productProfile: 'general',
        cusEmail: AppGlobal.emailAddress != '' ? AppGlobal.emailAddress : '',
        cusPhone: widget.bangladeshPaymentUserData!.phoneNumberDelivery,
        ItemsPrice:
        widget.cartDetailsResponse.cartTotalPrice.toStringAsFixed(2),
        ShippingHandling:
        widget.bangladeshPaymentUserData!.shippingPrice.toStringAsFixed(2),
        TotalBeforeTax: (widget.cartDetailsResponse.cartTotalPrice +
            widget.bangladeshPaymentUserData!.shippingPrice)
            .toStringAsFixed(2),
        EstimatedTax: widget.cartDetailsResponse.totalTax.toStringAsFixed(2),
        OrderTotal: (widget.cartDetailsResponse.cartTotalPrice +
            widget.bangladeshPaymentUserData!.shippingPrice +
            widget.cartDetailsResponse.totalTax)
            .toStringAsFixed(2),
        DeliveryName: widget.bangladeshPaymentUserData!.nameDelivery,
        DeliveryPhoneNumber:
        widget.bangladeshPaymentUserData!.phoneNumberDelivery,
        DeliveryAddress1: widget.bangladeshPaymentUserData!.address1Delivery,
        DeliveryAddress2: widget.bangladeshPaymentUserData!.address2Delivery,
        DeliveryState: '',
        DeliveryCity: widget.bangladeshPaymentUserData!.cityDelivery,
        DeliveryCityID:
        widget.bangladeshPaymentUserData!.cityDeliveryID.toString(),
        DeliveryZoneID:
        widget.bangladeshPaymentUserData!.zoneDeliveryID.toString(),
        cusCountry: widget.bangladeshPaymentUserData!.selectedDeliveryCountry
            .toString(),
        DeliveryAreaID:
        widget.bangladeshPaymentUserData!.areaDeliveryID.toString(),
        DeliveryZipCode: widget.bangladeshPaymentUserData!.zipCodeDelivery,
        DesireDeliveryDate:
        widget.bangladeshPaymentUserData!.createdAtDate ?? '',
        DeliveryUserNote:
        widget.bangladeshPaymentUserData!.adminNoteDelivery ?? '',
        DeliveryZone: widget.bangladeshPaymentUserData!.zoneDelivery,
        DeliveryArea: widget.bangladeshPaymentUserData!.areaDelivery,
        AddressLabel: widget.bangladeshPaymentUserData!.nickNameDelivery,
        saveAddress: widget.bangladeshPaymentUserData!.savePaymentAddress,
        homeAddress: widget.bangladeshPaymentUserData!.saveDeliveryAddress,
        ProcessStatus: 'Processing',
        ShippingLabel: null,
        DeliveryStatus: deliveryStatus,
        Note: widget.bangladeshPaymentUserData!.adminNoteDelivery??'',
        DeliveryConfirmationPic: null,
        PaymentStatus: 'Pending',
        VendorPaymentStatus: 'N',
        TrackingNumber: null,
        AllowStorePickup: widget.bangladeshPaymentUserData!.pickUp == true ? 'Y' : 'N',
        DefaultAddress: "N",
        AllowAdminPickup: widget.bangladeshPaymentUserData!.pickUp == true ?"N":"Y",
        PaymentType: 'card',
        productDetail: [
          ProductDetail(
              ProductID: widget
                  .cartDetailsResponse.productCartList[0].ProductID
                  .toString(),
              VendorStoreID: widget.cartDetailsResponse.productCartList[0]
                  .productCombinations[0].VendorStoreID
                  .toString(),
              itemsPrice: widget.cartDetailsResponse.productCartList[0]
                  .calculateTotalProductPrice
                  .toString(),
              Quantity: widget
                  .cartDetailsResponse.productCartList[0].TotalQuantity
                  .toString(),
              itemsShippingHandling: (double.parse(widget.pathaoPriceCalculationResponse!
                  .saveResponse[0].data.price.toString())+double.parse(widget.pathaoPriceCalculationResponse!
                  .saveResponse[0].data.additionalCharge.toString())).toString(),
              itemsBeforeTax: (widget.cartDetailsResponse.productCartList[0]
                  .calculateTotalProductPrice!+double.parse(widget.pathaoPriceCalculationResponse!
                  .saveResponse[0].data.price.toString())+double.parse(widget.pathaoPriceCalculationResponse!
                  .saveResponse[0].data.additionalCharge.toString())).toString(),
              itemsEstimatedTax: widget.cartDetailsResponse.productCartList[0]
                  .perProductTax.toString(),
              itemsTotal: (widget.cartDetailsResponse.productCartList[0]
                  .calculateTotalProductPrice!+widget.cartDetailsResponse.productCartList[0]
                  .perProductTax!+double.parse(widget.pathaoPriceCalculationResponse!
                  .saveResponse[0].data.price.toString())+double.parse(widget.pathaoPriceCalculationResponse!
                  .saveResponse[0].data.additionalCharge.toString())).toString(),

              productVariantCombinationDetail: [
                ProductVariantCombinationDetail(
                    ProductVariantCombinationID: widget
                        .cartDetailsResponse
                        .productCartList[0]
                        .productCombinations[0]
                        .ProductVariantCombinationID
                        .toString())
              ], ShippingByVendor: widget.cartDetailsResponse.productCartList[0].ShippingByVendor!,
            ShippingByAdmin: widget.cartDetailsResponse.productCartList[0].ShippingByAdmin!,)
        ],
      );
      for (int j = 1;
      j <
          widget.cartDetailsResponse.productCartList[0]
              .productCombinations.length;
      j++) {

        stripeTransInitModel!.productDetail[0].productVariantCombinationDetail
            .add(ProductVariantCombinationDetail(
            ProductVariantCombinationID: widget
                .cartDetailsResponse
                .productCartList[0]
                .productCombinations[j]
                .ProductVariantCombinationID
                .toString()));
      }
      for (int i = 1;
      i < widget.cartDetailsResponse.productCartList.length;
      i++) {
        stripeTransInitModel!.productDetail.add(
            ProductDetail(
                ProductID: widget
                    .cartDetailsResponse.productCartList[i].ProductID
                    .toString(),
                VendorStoreID: widget.cartDetailsResponse.productCartList[i]
                    .productCombinations[0].VendorStoreID
                    .toString(),
                itemsPrice: widget.cartDetailsResponse.productCartList[i]
                    .calculateTotalProductPrice
                    .toString(),
                Quantity: widget
                    .cartDetailsResponse.productCartList[i].TotalQuantity
                    .toString(),
                itemsShippingHandling: (double.parse(widget.pathaoPriceCalculationResponse!
                    .saveResponse[i].data.price.toString())+double.parse(widget.pathaoPriceCalculationResponse!
                    .saveResponse[i].data.additionalCharge.toString())).toString(),
                itemsBeforeTax: (widget.cartDetailsResponse.productCartList[i]
                    .calculateTotalProductPrice!+double.parse(widget.pathaoPriceCalculationResponse!
                    .saveResponse[i].data.price.toString())+double.parse(widget.pathaoPriceCalculationResponse!
                    .saveResponse[i].data.additionalCharge.toString())).toString()
                ,
                itemsEstimatedTax: widget.cartDetailsResponse.productCartList[i]
                    .perProductTax.toString(),
                itemsTotal: (widget.cartDetailsResponse.productCartList[i]
                    .calculateTotalProductPrice!+widget.cartDetailsResponse.productCartList[i]
                    .perProductTax!+double.parse(widget.pathaoPriceCalculationResponse!
                    .saveResponse[i].data.price.toString())+double.parse(widget.pathaoPriceCalculationResponse!
                    .saveResponse[i].data.additionalCharge.toString())).toString(),
                ShippingByVendor: widget.cartDetailsResponse.productCartList[i].ShippingByVendor!,
                ShippingByAdmin: widget.cartDetailsResponse.productCartList[i].ShippingByAdmin!,

                productVariantCombinationDetail: [

                ])

        );
        for (int j = 0;
        j <
            widget.cartDetailsResponse.productCartList[i]
                .productCombinations.length;
        j++) {
          stripeTransInitModel!
              .productDetail[i].productVariantCombinationDetail
              .add(ProductVariantCombinationDetail(
              ProductVariantCombinationID: widget
                  .cartDetailsResponse
                  .productCartList[i]
                  .productCombinations[j]
                  .ProductVariantCombinationID
                  .toString()));
        }
      }


    _cartBloc.add(TransectionInitStripe(
        stripeTransInitModel: stripeTransInitModel!));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<CartBloc, CartState>(listener: (context, state) async {
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
      }
      else if (state is TransectionInitStripeState) {
        stripInitResponse=state.stripInitResponse;
        await makePayment();
      }
    else if (state is AuthNetTransectionInitializedState) {
        authorizedNetPaymentResponse = state.authorizedNetPaymentResponse;
        // if (authorizedNetPaymentResponse!.data.responseCode == '1') {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => OrderPlaced(
        //               orderNumber: authorizedNetPaymentResponse!.OrderNumber,
        //               cartDetailsResponse: widget.cartDetailsResponse,
        //               paymentStatus: 'Paid',
        //               paymentUserData: widget.paymentUserData,
        //               selectedCountryId: widget.selectedCountryId,
        //               productsAndUserCitiesAreSame:
        //                   widget.productsAndUserCitiesAreSame,
        //               paymentTypeCOD: null,
        //             )),
        //   );
        // }
        // else if (authorizedNetPaymentResponse!.data.responseCode == '252') {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => OrderPlaced(
        //               orderNumber: authorizedNetPaymentResponse!.OrderNumber,
        //               cartDetailsResponse: widget.cartDetailsResponse,
        //               paymentStatus: 'Pending',
        //               paymentUserData: widget.paymentUserData,
        //               selectedCountryId: widget.selectedCountryId,
        //               productsAndUserCitiesAreSame:
        //                   widget.productsAndUserCitiesAreSame,
        //               paymentTypeCOD: null,
        //             )),
        //   );
        // }
        // else if (authorizedNetPaymentResponse!.data.responseCode == '253') {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => OrderPlaced(
        //               orderNumber: authorizedNetPaymentResponse!.OrderNumber,
        //               cartDetailsResponse: widget.cartDetailsResponse,
        //               paymentStatus: 'Pending',
        //               paymentUserData: widget.paymentUserData,
        //               selectedCountryId: widget.selectedCountryId,
        //               productsAndUserCitiesAreSame:
        //                   widget.productsAndUserCitiesAreSame,
        //               paymentTypeCOD: null,
        //             )),
        //   );
        // }
        // else {
        //   _cartBloc.add(UpdatePaymentStatus(
        //       id: authorizedNetPaymentResponse!.OrderNumber, status: 'failed'));
        // }
      }
      // else if (state is AddUserPaymentState) {
      //   addUserPaymentResponse = state.addUserPaymentResponse;
      //   if (paymentMethod == 2) {
      //     // transInitModel = TransInitModel(
      //     //     UserPaymentID: addUserPaymentResponse!.UserPaymentID.toString(),
      //     //     SessionID: AppGlobal.token,
      //     //     GatewayID: '4',
      //     //     GetawayConfirmation: 'YES',
      //     //     Name: nameOnCardController.text,
      //     //     CardNumber: cardNumberController.text,
      //     //     ExpirationDate: '',
      //     //     Address1: widget.paymentUserData.address1,
      //     //     Address2: widget.paymentUserData.address2,
      //     //     City: widget.paymentUserData.city,
      //     //     State: widget.paymentUserData.state!,
      //     //     ZipCode: widget.paymentUserData.zipCode,
      //     //     CountryID: widget.paymentUserData.countryID.toString(),
      //     //     PaymentAccount: '1111',
      //     //     PaymentRouting: '9838',
      //     //     DefaultPayment: 'N',
      //     //     totalAmount: widget.cartDetailsResponse.cartTotalPrice,
      //     //     currency: 'BDT',
      //     //     shippingMethod: 'NO',
      //     //     productName: 'Computer.',
      //     //     productCategory: 'Electronic',
      //     //     productProfile: 'general',
      //     //     cusEmail: AppGlobal.emailAddress,
      //     //     cusPhone: widget.paymentUserData.phoneNumber,
      //     //     cusFax: '01711111111',
      //     //     ItemsPrice:
      //     //         widget.cartDetailsResponse.cartTotalPrice.toStringAsFixed(2),
      //     //     ShippingHandling: '1.2',
      //     //     TotalBeforeTax: '4.2',
      //     //     EstimatedTax: '2.1',
      //     //     OrderTotal:
      //     //         widget.cartDetailsResponse.cartTotalPrice.toStringAsFixed(2),
      //     //     DeliveryState: widget.paymentUserData.stateDelivery!,
      //     //     DeliveryZipCode: widget.paymentUserData.zipCodeDelivery,
      //     //     DeliveryAddress1: widget.paymentUserData.address1Delivery,
      //     //     DesireDeliveryDate: widget.paymentUserData.createdAtDate,
      //     //     DeliveryPhoneNumber: widget.paymentUserData.phoneNumberDelivery,
      //     //     UserAddressID: addUserPaymentResponse!.UserAddressID,
      //     //     DeliveryAddress2: widget.paymentUserData.address2Delivery,
      //     //     DeliveryCity: widget.paymentUserData.cityDelivery,
      //     //     DeliveryUserNote: widget.paymentUserData.adminNoteDelivery,
      //     //     DeliveryName: widget.paymentUserData.nameDelivery,
      //     //     DeliveryAreaID: widget.selectedAreaId.toString(),
      //     //     DeliveryZoneID: widget.selectedZoneId.toString(),
      //     //     DeliveryCityID: widget.selectedCityId.toString());
      //     // _cartBloc
      //     //     .add(TransectionInitSSLCommerce(transInitModel: transInitModel!));
      //   }
      //   else if (paymentMethod == 1) {
      //     // authorizedNetPaymentModel = AuthorizedNetPaymentModel(
      //     //     UserPaymentID: addUserPaymentResponse!.UserPaymentID.toString(),
      //     //     SessionID: AppGlobal.token,
      //     //     GatewayID: '5',
      //     //     GetawayConfirmation: 'YES',
      //     //     CardNumber: cardNumberController.text,
      //     //     cvv: cvvCardController.text,
      //     //     ExpirationDate: createdDateController.text,
      //     //     totalAmount:
      //     //         widget.cartDetailsResponse.cartTotalPrice.toStringAsFixed(2),
      //     //     Name: nameOnCardController.text,
      //     //     CompanyName: widget.paymentUserData.name,
      //     //     Address1: widget.paymentUserData.address1,
      //     //     Address2: widget.paymentUserData.address2,
      //     //     City: widget.paymentUserData.city,
      //     //     State: widget.paymentUserData.state!,
      //     //     ZipCode: widget.paymentUserData.zipCode,
      //     //     Country: widget.paymentUserData.country,
      //     //     CountryID: 226.toString(),
      //     //     OrderDate: '',
      //     //     productName: 'Computer',
      //     //     ItemsPrice:
      //     //         widget.cartDetailsResponse.cartTotalPrice.toStringAsFixed(2),
      //     //     ShippingHandling: '1.20',
      //     //     TotalBeforeTax: '4.20',
      //     //     EstimatedTax: '2.10',
      //     //     OrderTotal:
      //     //         widget.cartDetailsResponse.cartTotalPrice.toStringAsFixed(2),
      //     //     currency: '\$',
      //     //     PaymentAccount: '1111',
      //     //     PaymentRouting: '9838',
      //     //     DefaultPayment: rememberMe ? 'Y' : 'N',
      //     //     DeliveryState: widget.paymentUserData.stateDelivery!,
      //     //     DeliveryZipCode: widget.paymentUserData.zipCodeDelivery,
      //     //     DeliveryAddress1: widget.paymentUserData.address1Delivery,
      //     //     DesireDeliveryDate: widget.paymentUserData.createdAtDate,
      //     //     DeliveryPhoneNumber: widget.paymentUserData.phoneNumberDelivery,
      //     //     UserAddressID: addUserPaymentResponse!.UserAddressID,
      //     //     DeliveryAddress2: widget.paymentUserData.address2Delivery,
      //     //     DeliveryCity: widget.paymentUserData.cityDelivery,
      //     //     DeliveryUserNote: widget.paymentUserData.adminNoteDelivery,
      //     //     DeliveryName: widget.paymentUserData.nameDelivery,
      //     //     cusCountry: widget.selectedCountryId.toString(),
      //     //     DeliveryAreaID: '',
      //     //     DeliveryZoneID: '');
      //     _cartBloc.add(AuthNetTransectionInit(
      //         transInitModel: authorizedNetPaymentModel!));
      //
      //     if (AppGlobal.defaultPayment == 'Y') {
      //       if (AppGlobal.cardNumber != '') {
      //         cardNumberController.text = AppGlobal.address1;
      //       }
      //       if (AppGlobal.expiryDate != '') {
      //         createdDateController.text = AppGlobal.address2;
      //       }
      //     }
      //   }
      //   else if (paymentMethod == 3) {
      //     ///Apply cash on delivery here
      //     print('Apply cash on delivery here');
      //     // cashOnDeliveryInit = cash_delivery.CashOnDeliveryInit(
      //     //   UserPaymentID: addUserPaymentResponse!.UserPaymentID.toString(),
      //     //   SessionID: AppGlobal.token,
      //     //   GatewayID:
      //     //       widget.paymentUserData.country == 'Bangladesh' ? '4' : '5',
      //     //   GetawayConfirmation: 'YES',
      //     //   Name: nameOnCardController.text,
      //     //   Address1: widget.paymentUserData.address1,
      //     //   Address2: widget.paymentUserData.address2,
      //     //   City: widget.paymentUserData.city,
      //     //   State: widget.paymentUserData.state!,
      //     //   ZipCode: widget.paymentUserData.zipCode,
      //     //   CountryID:
      //     //       widget.paymentUserData.country == 'Bangladesh' ? '16' : '226',
      //     //   PaymentAccount: '1111',
      //     //   PaymentRouting: '9838',
      //     //   DefaultPayment: 'N',
      //     //   totalAmount: widget.cartDetailsResponse.cartTotalPrice,
      //     //   currency:
      //     //       widget.paymentUserData.country == 'Bangladesh' ? 'BDT' : '\$',
      //     //   shippingMethod: 'NO',
      //     //   productName: 'Computer.',
      //     //   productCategory: 'Electronic',
      //     //   productProfile: 'general',
      //     //   cusEmail: AppGlobal.emailAddress,
      //     //   cusFax: '01711111111',
      //     //   ItemsPrice:
      //     //       widget.cartDetailsResponse.cartTotalPrice.toStringAsFixed(2),
      //     //   ShippingHandling: '1.2',
      //     //   TotalBeforeTax: '4.2',
      //     //   EstimatedTax: '2.1',
      //     //   OrderTotal:
      //     //       widget.cartDetailsResponse.cartTotalPrice.toStringAsFixed(2),
      //     //   DeliveryState: widget.paymentUserData.stateDelivery!,
      //     //   DeliveryZipCode: widget.paymentUserData.zipCodeDelivery,
      //     //   DeliveryAddress1: widget.paymentUserData.address1Delivery,
      //     //   DesireDeliveryDate: widget.paymentUserData.createdAtDate,
      //     //   DeliveryPhoneNumber: widget.paymentUserData.phoneNumberDelivery,
      //     //   UserAddressID: addUserPaymentResponse!.UserAddressID,
      //     //   DeliveryAddress2: widget.paymentUserData.address2Delivery,
      //     //   DeliveryCity: widget.paymentUserData.cityDelivery,
      //     //   DeliveryUserNote: widget.paymentUserData.adminNoteDelivery,
      //     //   DeliveryName: widget.paymentUserData.nameDelivery,
      //     //   DeliveryAreaID: widget.paymentUserData.country == 'Bangladesh'
      //     //       ? widget.selectedAreaId.toString()
      //     //       : '',
      //     //   DeliveryZoneID: widget.paymentUserData.country == 'Bangladesh'
      //     //       ? widget.selectedZoneId.toString()
      //     //       : '',
      //     //   cusCountry: widget.selectedCountryId.toString(),
      //     //   DeliveryCountry: widget.paymentUserData.country,
      //     //   cusPhone: widget.paymentUserData.phoneNumberDelivery,
      //     // );
      //     //
      //     // _cartBloc.add(
      //     //     CashOnDeliveryInitEvent(cashOnDeliveryInit: cashOnDeliveryInit!));
      //   }
      // }
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
                                  child: Icon(
                                Icons.done,
                                color: kColorWhite,
                                size: 18,
                              )),
                            ),
                            Container(
                              height: 1,
                              width: screenSize.width * 0.26,
                              color: kColorFieldsBorders,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kColorPrimary,
                                // border: Border.all(
                                //     color: kColorFieldsBorders, width: 1),
                                // image: DecorationImage(
                                //   image: Image.asset("assets/icons/eyeicon.png",),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: const Center(
                                child: Text(
                                  '2',
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
                              'Payment',
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
                          ],
                        ),
                        SizedBox(
                                height: screenSize.height * 0.1,
                              )
                            ,
                        Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ///

                                  Container(
                                    height: screenSize.height * 0.14,
                                    width: screenSize.width * 0.43,
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          width: 2,
                                          color:  kColorFieldsBorders),
                                      color: kColorWhite,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/Stripe Logo.png',
                                          scale: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ,
                        const SizedBox(
                          height: 35,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Card Number',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: screenSize.height * 0.06,
                          child: TextField(
                            controller: cardNumberController,
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
                              hintText: 'Enter Card Number',
                              hintStyle:
                                  const TextStyle(color: kColorFieldsBorders),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Expiry Date',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.centerEnd,
                                  children: [
                                    Container(
                                      height: screenSize.height * 0.06,
                                      width: screenSize.width * 0.5,
                                      child: TextField(
                                        controller: createdDateController,
                                        style: const TextStyle(
                                            color: kColorDarkGreyText),
                                        readOnly: true,
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
                                            hintText: 'MM/yy',
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
                                              MyFlutterApp
                                                  .icon_calendar_outlined,
                                              color: kColorFieldsBorders,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'CVV',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: screenSize.height * 0.06,
                                  width: screenSize.width * 0.35,
                                  child: TextField(
                                    controller: cvvCardController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
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
                                      hintText: '123',
                                      hintStyle: const TextStyle(
                                          color: kColorFieldsBorders),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenSize.height * 0.15,
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

                                  if (cardNumberController.text != '') {
                                    if (createdDateController.text != '') {
                                      if (cvvCardController.text != '') {
                                        _cartBloc.add(AddUserPayment(
                                            addUserPaymentModel:
                                                addUserPaymentModel!));
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Please enter card CVV code',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                Colors.grey.shade400,
                                            textColor: Colors.white,
                                            fontSize: 12.0);
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Please select card expiry date',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey.shade400,
                                          textColor: Colors.white,
                                          fontSize: 12.0);
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Please enter card number',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey.shade400,
                                        textColor: Colors.white,
                                        fontSize: 12.0);
                                  }

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
                        )),
                  ],
                ),
              ],
            )),
      );
    });
  }

  Future<void> makePayment() async {
    try {

      paymentIntentData =
      await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'US',
              merchantDisplayName: 'ANNIE')).then((value){
      });


      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: true,
          )).then((newValue){


        print('payment intent'+paymentIntentData!['id'].toString());
        print('payment intent'+paymentIntentData!['client_secret'].toString());
        print('payment intent'+paymentIntentData!['amount'].toString());
        print('payment intent'+paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;

      }).onError((error, stackTrace){
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });


    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer your token',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100 ;
    return a.toString();
  }



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
          DateFormat('MM/yy').format(pickedDate).toString();
      setState(() {});
    }
  }
}

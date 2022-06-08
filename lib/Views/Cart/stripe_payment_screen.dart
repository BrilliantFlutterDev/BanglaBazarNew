import 'package:bangla_bazar/ModelClasses/BangladeshPaymentUserData.dart';
import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_price_calculation_response.dart';
import 'package:bangla_bazar/ModelClasses/stripe_payment_validate_model.dart';
import 'package:bangla_bazar/ModelClasses/stripe_payment_validate_response.dart';
import 'package:bangla_bazar/ModelClasses/stripe_response.dart';
import 'package:bangla_bazar/ModelClasses/stripe_trans_init_model.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/Cart/CartBloc/cart_bloc.dart';
import 'package:bangla_bazar/Views/Cart/bangladesh_order_placed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentScreen extends StatefulWidget {
  CartDetailsResponse cartDetailsResponse;

  bool productsAndUserCitiesAreSame;
  bool creditCardPayment;

  PathaoPriceCalculationResponse? pathaoPriceCalculationResponse;
  BangladeshPaymentUserData? bangladeshPaymentUserData;
  StripePaymentScreen(
      {Key? key,
      required this.cartDetailsResponse,
      required this.productsAndUserCitiesAreSame,
      required this.creditCardPayment,
      required this.pathaoPriceCalculationResponse,
      required this.bangladeshPaymentUserData})
      : super(key: key);

  @override
  _StripePaymentScreenState createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  StripeTransInitModel? stripeTransInitModel;
  StripInitResponse? stripInitResponse;
  late CartBloc _cartBloc;
  String deliveryStatus = '';
  Map<String, dynamic>? paymentIntentData;
  StripePaymentValidateModel? stripePaymentValidateModel;
  StripePaymentValidateResponse? stripePaymentValidateResponse;
  @override
  void initState() {
    super.initState();
    _cartBloc = BlocProvider.of<CartBloc>(context);
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
    ///
    initializePaymentProcess();

    // print(
    //     '>>>>>>>Prices: ${(widget.cartDetailsResponse.cartTotalPrice + widget.bangladeshPaymentUserData!.shippingPrice + widget.cartDetailsResponse.totalTax)} <<<<<<<<');
  }
  void initializePaymentProcess() {

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

  initializePayment() async {
    await makePayment();
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
        initializePayment();
      }
      else if (state is TransectionInitStripeValidateState) {
        stripePaymentValidateResponse=state.stripePaymentValidateResponse;
        if(stripePaymentValidateResponse!.status==true){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BangladeshOrderPlaced(
                  orderNumber: stripInitResponse!.OrderNumber,
                  cartDetailsResponse:
                  widget.cartDetailsResponse,
                  paymentStatus: 'Paid',
                  bangladeshPaymentUserData:
                  widget.bangladeshPaymentUserData,
                  selectedCountryId:
                  226,
                  productsAndUserCitiesAreSame:
                  widget.productsAndUserCitiesAreSame,
                  paymentTypeCOD: 'card',
                  pathaoPriceCalculationResponse: widget
                      .pathaoPriceCalculationResponse,
                )),
          );
        }
        print('>>>>>>>>>>>Order Placed');
      }

    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Stripe Payment'),
            backgroundColor: kColorPrimary,
          ),
          body: Center(
            child: InkWell(
              onTap: () async {
                await makePayment();
                print('>>>>>>>>>>Make Payment hit');
              },
              child: Container(
                height: 50,
                width: 200,
                color: kColorPrimary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.refresh,
                      color: kColorWhite,
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Retry Payment',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });}

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent(
          (stripInitResponse!.OrderTotal)
              .toStringAsFixed(0),
          stripInitResponse!.Currency.toUpperCase()); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      print('payment intent121: ' + paymentIntentData!['id'].toString());
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'Bangla Bazar'))
          .then((value) {});

      ///now finally display payment sheet

      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],

        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent: ' + paymentIntentData!['id'].toString());
        print('payment intent: ' +
            paymentIntentData!['client_secret'].toString());
        print('payment intent: ' + paymentIntentData!['amount'].toString());
        print(
            'payment intent: ' + paymentIntentData!['card_number'].toString());
        print('payment intent: ' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        stripePaymentValidateModel=StripePaymentValidateModel(OrderNumber: stripInitResponse!.OrderNumber, PaymentSuccessResponse: paymentIntentData!.toString());
        _cartBloc.add(TransectionInitStripeValidate(
            stripePaymentValidateModel: stripePaymentValidateModel!));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KxsHCDLQAZcqA2uj3iM8rRnPzpRMZTyaA6LPpxCgt9NcYS4k05ZJMhhZiXEaBdjNvyWFYdFKvCj6QNRe94u4VuF00iMCiuBma',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent response ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}

// class StripePaymentScreen extends StatelessWidget {
//   const StripePaymentScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final PaymentController controller = Get.put(PaymentController());
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           InkWell(
//             onTap: () {
//               print('>>>>>>>>>>>>>make payment button');
//               controller.makePayment(amount: '50', currency: 'USD');
//             },
//             child: Center(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 10,
//                       offset: Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     'Make Payment',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

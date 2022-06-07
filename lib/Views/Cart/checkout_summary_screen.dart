import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginBloc/login_bloc.dart';
import 'package:bangla_bazar/Widgets/selected_products_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../ModelClasses/BangladeshPaymentUserData.dart';
import '../../ModelClasses/pathao_price_calculation_response.dart';
import 'bangladesh_checkout_payment_screen.dart';

class CheckoutSummaryScreen extends StatefulWidget {
  CartDetailsResponse cartDetailsResponse;
  BangladeshPaymentUserData? bangladeshPaymentUserData;

  bool productsAndUserCitiesAreSame;
  bool creditCardPayment;

  PathaoPriceCalculationResponse? pathaoPriceCalculationResponse;
  CheckoutSummaryScreen({
    Key? key,
    required this.cartDetailsResponse,
    required this.bangladeshPaymentUserData,
    required this.productsAndUserCitiesAreSame,
    required this.creditCardPayment,
    required this.pathaoPriceCalculationResponse,
  }) : super(key: key);
  @override
  _CheckoutSummaryScreenState createState() => _CheckoutSummaryScreenState();
}

class _CheckoutSummaryScreenState extends State<CheckoutSummaryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
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
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: WillPopScope(
          onWillPop: _onBackPressed,
          child: Scaffold(
              backgroundColor: kColorWhite,
              extendBody: true,
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  ///This is the body
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            // color: Colors.yellow,
                            width: screenSize.width,
                            height: screenSize.height * 0.16,
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
                                        color: kColorFieldsBorders,
                                        fontSize: 16),
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Container(
                                //height: 1,
                                width: screenSize.width * 0.19,
                                //color: kColorDarkGreyText,
                              ),
                              const Text(
                                'Summary',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
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
                          const SizedBox(
                            height: 35,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Shipping Address',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.bangladeshPaymentUserData!
                                        .nameDelivery,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: kColorDarkGreyText),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    widget.bangladeshPaymentUserData!
                                        .address1Delivery,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: kColorFieldsBorders),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    widget.bangladeshPaymentUserData!
                                        .phoneNumberDelivery,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: kColorFieldsBorders),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  _onBackPressed();
                                },
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kColorWidgetBackgroundColor,
                                      // border: Border.all(
                                      //     color: kColorDarkGreyText, width: 3),
                                      // image: DecorationImage(
                                      //   image: Image.asset("assets/icons/eyeicon.png",),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    child: const Icon(
                                      MyFlutterApp.icon_edit_outline,
                                      color: kColorDarkGreyText,
                                      size: 15,
                                    )),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 35,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Payment Method',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  widget.creditCardPayment != false
                                      ? Image.asset(
                                          'assets/images/ssl_commerz.png',
                                          scale: 3,
                                        )
                                      : const SizedBox(),
                                  widget.creditCardPayment != false
                                      ? const SizedBox(
                                          width: 10,
                                        )
                                      : const SizedBox(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      widget.creditCardPayment != false
                                          ? const Text(
                                              'Pay by Card',
                                              style: TextStyle(fontSize: 14),
                                            )
                                          : const Text(
                                              'Cash on Delivery',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                      // widget.bangladeshPaymentUserData!
                                      //             .cardNumber !=
                                      //         null
                                      //     ? Text(
                                      //         widget.bangladeshPaymentUserData!
                                      //             .cardNumber!,
                                      //         style: const TextStyle(
                                      //             fontSize: 10,
                                      //             color: kColorFieldsBorders),
                                      //       )
                                      //     : const SizedBox(),
                                    ],
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  _onBackPressed();
                                },
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kColorWidgetBackgroundColor,
                                      // border: Border.all(
                                      //     color: kColorDarkGreyText, width: 3),
                                      // image: DecorationImage(
                                      //   image: Image.asset("assets/icons/eyeicon.png",),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    child: const Icon(
                                      MyFlutterApp.icon_edit_outline,
                                      color: kColorDarkGreyText,
                                      size: 15,
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Items ( ${widget.cartDetailsResponse.productCartList.length} )',
                                style: const TextStyle(fontSize: 18),
                              ),
                              InkWell(
                                onTap: () {
                                  _onBackPressed();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kColorWidgetBackgroundColor,
                                      // border: Border.all(
                                      //     color: kColorDarkGreyText, width: 3),
                                      // image: DecorationImage(
                                      //   image: Image.asset("assets/icons/eyeicon.png",),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    child: const Icon(
                                      MyFlutterApp.icon_edit_outline,
                                      color: kColorDarkGreyText,
                                      size: 15,
                                    )),
                              )
                            ],
                          ),

                          Container(
                            width: screenSize.width,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget
                                    .cartDetailsResponse.productCartList.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: SelectedProductsInfoWidget(
                                      screenSize: screenSize,
                                      productCartList: widget
                                          .cartDetailsResponse
                                          .productCartList[index],
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Order Summary',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Subtotal',
                                style: TextStyle(
                                    fontSize: 16, color: kColorFieldsBorders),
                              ),
                              Text(
                                '${widget.cartDetailsResponse.productCartList.isNotEmpty ? widget.cartDetailsResponse.productCartList[0].Currency : '\$'} ${widget.cartDetailsResponse.cartTotalPrice}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Discount',
                                style: TextStyle(
                                    fontSize: 16, color: kColorFieldsBorders),
                              ),
                              Text(
                                '${widget.cartDetailsResponse.productCartList.isNotEmpty ? widget.cartDetailsResponse.productCartList[0].Currency : '\$'} 0',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Shipping',
                                style: TextStyle(
                                    fontSize: 16, color: kColorFieldsBorders),
                              ),
                              Text(
                                '${widget.cartDetailsResponse.productCartList.isNotEmpty ? widget.cartDetailsResponse.productCartList[0].Currency : '\$'} ${widget.bangladeshPaymentUserData!.shippingPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tax',
                                style: TextStyle(
                                    fontSize: 16, color: kColorFieldsBorders),
                              ),
                              Text(
                                '${widget.cartDetailsResponse.productCartList.isNotEmpty ? widget.cartDetailsResponse.productCartList[0].Currency : '\$'} ${widget.cartDetailsResponse.totalTax.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1,
                            width: screenSize.width,
                            color: kColorFieldsBorders,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Price',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${widget.cartDetailsResponse.productCartList.isNotEmpty ? widget.cartDetailsResponse.productCartList[0].Currency : '\$'} ${(widget.cartDetailsResponse.cartTotalPrice + widget.bangladeshPaymentUserData!.shippingPrice + widget.cartDetailsResponse.totalTax).toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 18, color: kColorPrimary),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 50,
                          ),
                          // SizedBox(
                          //   height: screenSize.height * 0.01,
                          // ),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BangladeshCheckoutPaymentScreen(
                                        cartDetailsResponse:
                                            widget.cartDetailsResponse,
                                        bangladeshPaymentUserData:
                                            widget.bangladeshPaymentUserData!,
                                        productsAndUserCitiesAreSame:
                                            widget.productsAndUserCitiesAreSame,
                                        creditCardPayment:
                                            widget.creditCardPayment,
                                        pathaoPriceCalculationResponse: widget
                                            .pathaoPriceCalculationResponse,
                                      ),
                                    ),
                                  );
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
        ),
      );
    });
  }

  Future<bool> _onBackPressed() {
    Navigator.pop(context);
    Navigator.pop(context);
    return Future.value(false);
  }
}

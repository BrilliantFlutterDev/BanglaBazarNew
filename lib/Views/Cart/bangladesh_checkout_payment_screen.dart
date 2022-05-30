import 'package:bangla_bazar/ModelClasses/BangladeshPaymentUserData.dart';
import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/ModelClasses/cod_init_model.dart' as cod_model;
import 'package:bangla_bazar/ModelClasses/cod_init_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_price_calculation_response.dart';
import 'package:bangla_bazar/ModelClasses/ssl_commerz_init_response.dart';
import 'package:bangla_bazar/ModelClasses/sslcommerce_init_model.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/Cart/CartBloc/cart_bloc.dart';
import 'package:bangla_bazar/Views/Cart/bangladesh_order_placed.dart';
import 'package:bangla_bazar/Views/Cart/ssl_payment_webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class BangladeshCheckoutPaymentScreen extends StatefulWidget {
  CartDetailsResponse cartDetailsResponse;
  BangladeshPaymentUserData? bangladeshPaymentUserData;

  bool productsAndUserCitiesAreSame;
  bool creditCardPayment;

  PathaoPriceCalculationResponse? pathaoPriceCalculationResponse;
  BangladeshCheckoutPaymentScreen({
    Key? key,
    required this.cartDetailsResponse,
    required this.bangladeshPaymentUserData,
    required this.productsAndUserCitiesAreSame,
    required this.creditCardPayment,
    required this.pathaoPriceCalculationResponse,
  }) : super(key: key);
  @override
  _BangladeshCheckoutPaymentScreenState createState() =>
      _BangladeshCheckoutPaymentScreenState();
}

class _BangladeshCheckoutPaymentScreenState
    extends State<BangladeshCheckoutPaymentScreen> {
  late CartBloc _cartBloc;
  TextEditingController cardNumberController = TextEditingController();

  TextEditingController nameOnCardController = TextEditingController();
  TextEditingController cvvCardController = TextEditingController();
  TextEditingController createdDateController = TextEditingController();

  late DateTime pickedDate;

  bool rememberMe = false;
  int paymentMethod = 0;

  SSLCommerceTransInitModel? sslCommerceTransInitModel;
  SSLCommerzInitResponse? sslCommerzInitResponse;

  cod_model.CODInitModel? codInitModel;
  CODInitResponse? cashOnDeliveryInitResponse;

  String deliveryStatus = '';

  @override
  void initState() {
    super.initState();

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
    if (widget.bangladeshPaymentUserData!.country == 'Bangladesh' &&
        widget.creditCardPayment == true) {
      ///SSLCommerce
      paymentMethod = 2;
    } else if (widget.creditCardPayment == false) {
      ///Cash on delivery
      paymentMethod = 3;
    } else {
      ///Authorized.Net
      paymentMethod = 1;
    }

    if (paymentMethod == 2) {
      sslCommerceTransInitModel = SSLCommerceTransInitModel(
        SessionID: AppGlobal.token,
        GatewayID: '4',
        GetawayConfirmation: 'Yes',
        Name: widget.bangladeshPaymentUserData!.name,
        CardNumber: widget.bangladeshPaymentUserData!.cardNumber,
        ExpirationDate: null,
        Address1: widget.bangladeshPaymentUserData!.address1,
        Address2: widget.bangladeshPaymentUserData!.address2,
        City: widget.bangladeshPaymentUserData!.city,
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
              ], ShippingByVendor: 'Y', ShippingByAdmin: 'N')
        ],
      );
      for (int j = 1;
      j <
          widget.cartDetailsResponse.productCartList[0]
              .productCombinations.length;
      j++) {

        sslCommerceTransInitModel!.productDetail[0].productVariantCombinationDetail
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
        sslCommerceTransInitModel!.productDetail.add(
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
                ShippingByVendor: 'Y',
                ShippingByAdmin: 'N',

                productVariantCombinationDetail: [

                ])

        );
        for (int j = 0;
        j <
            widget.cartDetailsResponse.productCartList[i]
                .productCombinations.length;
        j++) {
          sslCommerceTransInitModel!
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
      _cartBloc.add(TransectionInitSSLCommerce(
          transInitModel: sslCommerceTransInitModel!));
    }
    else if (paymentMethod == 3) {
      print('Delivery Stats:  $deliveryStatus');
      codInitModel = cod_model.CODInitModel(
          SessionID: AppGlobal.token,
          GatewayID: '4',
          GetawayConfirmation: 'Yes',
          DefaultPayment: "Y",
          totalAmount: (widget.cartDetailsResponse.cartTotalPrice +
                  widget.bangladeshPaymentUserData!.shippingPrice)
              .toStringAsFixed(2),
          currency:
          widget.cartDetailsResponse.productCartList[0].Currency == 'BDT' ? 'BDT' : '\$',
          ItemsPrice:
              widget.cartDetailsResponse.cartTotalPrice.toStringAsFixed(2),
          ShippingHandling: widget.bangladeshPaymentUserData!.shippingPrice
              .toStringAsFixed(2),
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
          cusCountry:
              widget.bangladeshPaymentUserData!.selectedDeliveryCountry.toString(),
          DeliveryZoneID: widget.bangladeshPaymentUserData!.zoneDeliveryID.toString(),
          DeliveryCountry: widget.bangladeshPaymentUserData!.selectedDeliveryCountry.toString(),
          DeliveryAreaID: widget.bangladeshPaymentUserData!.areaDeliveryID.toString(),
          DeliveryCityID: widget.bangladeshPaymentUserData!.cityDeliveryID.toString(),
          DeliveryZipCode: widget.bangladeshPaymentUserData!.zipCodeDelivery,
          DesireDeliveryDate: widget.bangladeshPaymentUserData!.createdAtDate ?? '',
          DeliveryUserNote: widget.bangladeshPaymentUserData!.adminNoteDelivery ?? '',
          AddressLabel: widget.bangladeshPaymentUserData!.nickNameDelivery,
          DeliveryZone: widget.bangladeshPaymentUserData!.zoneDelivery,
          DeliveryArea: widget.bangladeshPaymentUserData!.areaDelivery,
          DefaultAddress: "NO",
          homeAddress: widget.bangladeshPaymentUserData!.saveDeliveryAddress,
          AllowStorePickup: widget.bangladeshPaymentUserData!.pickUp == true ? 'Y' : 'N',
          AllowAdminPickup: widget.bangladeshPaymentUserData!.pickUp == true ?"N":"Y",
          PaymentType: 'cod',
          ProcessStatus: 'Processing',
          VendorPaymentStatus:'N',
          DeliveryStatus:deliveryStatus,
          productDetail:[ cod_model.ProductDetail(
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
                cod_model.ProductVariantCombinationDetail(
                    ProductVariantCombinationID: widget
                        .cartDetailsResponse
                        .productCartList[0]
                        .productCombinations[0]
                        .ProductVariantCombinationID
                        .toString())
              ])
          ],
      );
      for (int j = 1;
      j <
          widget.cartDetailsResponse.productCartList[0]
              .productCombinations.length;
      j++) {

        codInitModel!.productDetail[0].productVariantCombinationDetail
            .add(cod_model.ProductVariantCombinationDetail(
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
        codInitModel!.productDetail.add(
            cod_model.ProductDetail(
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

                productVariantCombinationDetail: [

                ])

        );
        for (int j = 0;
        j <
            widget.cartDetailsResponse.productCartList[i]
                .productCombinations.length;
        j++) {
          codInitModel!.productDetail[0].productVariantCombinationDetail
              .add(cod_model.ProductVariantCombinationDetail(
              ProductVariantCombinationID: widget
                  .cartDetailsResponse
                  .productCartList[i]
                  .productCombinations[j]
                  .ProductVariantCombinationID
                  .toString()));
        }
      }
      _cartBloc.add(CashOnDeliveryInitEvent(cashOnDeliveryInit: codInitModel!));
    }
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
      } else if (state is CashOnDeliveryInitState) {
        cashOnDeliveryInitResponse = state.cashOnDeliveryInitResponse;

        ///Call Add process Api here for cash on delivery
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BangladeshOrderPlaced(
                    orderNumber: cashOnDeliveryInitResponse!.OrderNumber,
                    cartDetailsResponse: widget.cartDetailsResponse,
                    paymentStatus: 'Pending',
                    bangladeshPaymentUserData: widget.bangladeshPaymentUserData,
                    selectedCountryId: widget
                        .bangladeshPaymentUserData!.selectedPaymentCountry,
                    productsAndUserCitiesAreSame:
                        widget.productsAndUserCitiesAreSame,
                    paymentTypeCOD: 'cod',
                    pathaoPriceCalculationResponse:
                        widget.pathaoPriceCalculationResponse,
                  )),
        );
      } else if (state is TransectionInitializedState) {
        sslCommerzInitResponse = state.sslCommerzInitResponse;

        if (sslCommerzInitResponse!.status == false) {
          Navigator.pop(context);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SSLPaymentWebView(
                      linkUrl: sslCommerzInitResponse!.URLLINK,
                      orderNumber: sslCommerzInitResponse!.OrderNumber,
                      cartDetailsResponse: widget.cartDetailsResponse,
                      bangladeshPaymentUserData:
                          widget.bangladeshPaymentUserData,
                      selectedCountryId:
                          widget.bangladeshPaymentUserData!.countryID,
                      productsAndUserCitiesAreSame:
                          widget.productsAndUserCitiesAreSame,
                      pathaoPriceCalculationResponse:
                          widget.pathaoPriceCalculationResponse,
                    )),
          );
        }
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
                                  '3',
                                  style: TextStyle(
                                      color: kColorWhite, fontSize: 16),
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
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenSize.height * 0.30,
                        ),
                        const Center(
                          child: Text(
                            'Please Retry',
                            style: TextStyle(
                                color: kColorFieldsBorders, fontSize: 18),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              initializePaymentProcess();
                            },
                            child: const Icon(
                              Icons.refresh,
                              color: kColorPrimary,
                              size: 50,
                            )),
                        SizedBox(
                          height: screenSize.height * 0.27,
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
                                Navigator.pop(context);
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
                                      pathaoPriceCalculationResponse:
                                          widget.pathaoPriceCalculationResponse,
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
                                    'Retry',
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

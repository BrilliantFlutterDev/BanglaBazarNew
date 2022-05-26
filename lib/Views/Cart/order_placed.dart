import 'package:bangla_bazar/ModelClasses/BangladeshPaymentUserData.dart';
import 'package:bangla_bazar/ModelClasses/add_process_order_model.dart';
import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/ModelClasses/payment_user_data.dart';
import 'package:bangla_bazar/ModelClasses/ssl_get_detail_model.dart';
import 'package:bangla_bazar/ModelClasses/transection_details_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/Cart/CartBloc/cart_bloc.dart';
import 'package:bangla_bazar/Views/MyOrders/my_orders_screen.dart';
import 'package:bangla_bazar/Views/main_home_page.dart';
import 'package:bangla_bazar/Widgets/my_cart_product_widget.dart';
import 'package:bangla_bazar/Widgets/selected_products_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderPlaced extends StatefulWidget {
  final String orderNumber;
  final String paymentStatus;
  CartDetailsResponse cartDetailsResponse;
  PaymentUserData? paymentUserData;
  BangladeshPaymentUserData? bangladeshPaymentUserData;
  bool productsAndUserCitiesAreSame;
  int selectedCountryId;
  String? paymentTypeCOD;
  OrderPlaced(
      {Key? key,
      required this.orderNumber,
      required this.cartDetailsResponse,
      required this.paymentStatus,
      this.paymentUserData,
      this.bangladeshPaymentUserData,
      required this.selectedCountryId,
      required this.productsAndUserCitiesAreSame,
      this.paymentTypeCOD})
      : super(key: key);
  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  late CartBloc _cartBloc;
  SSLGetDetailsModel? sslGetDetailsModel;
  TransectionDetailsResponse? transectionDetailsResponse;
  late AddProcessOrderModel addProcessOrderModel;
  String deliveryStatus = '';

  @override
  void initState() {
    super.initState();

    _cartBloc = BlocProvider.of<CartBloc>(context);
    sslGetDetailsModel = SSLGetDetailsModel(OrderNumber: widget.orderNumber);

    //addProcessOrderModel.productDetail=ProductDetail() as List<ProductDetail>?;
    _cartBloc
        .add(GetTransectionDetails(sslGetDetailsModel: sslGetDetailsModel!));

    if (widget.selectedCountryId == 16 &&
        widget.productsAndUserCitiesAreSame == true) {
      deliveryStatus = 'dd';
    } else if (widget.selectedCountryId == 16 &&
        widget.productsAndUserCitiesAreSame == false) {
      deliveryStatus = 'pathao';
    } else if (widget.selectedCountryId == 226 &&
        widget.productsAndUserCitiesAreSame == true) {
      deliveryStatus = 'dd';
    } else if (widget.selectedCountryId == 226 &&
        widget.productsAndUserCitiesAreSame == false) {
      deliveryStatus = 'usps';
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
      } else if (state is OrderPlacedSuccessfullyState) {
      } else if (state is GetTransectionDetailsState) {
        transectionDetailsResponse = state.transectionDetailsResponse;
        print('>>>>>>>>>>>>>>1221');
        // addProcessOrderModel = AddProcessOrderModel(
        //     UserID: AppGlobal.userID.toString(),
        //     PaymentStatus: widget.paymentStatus,
        //     ProcessPaymentID: transectionDetailsResponse!
        //         .transcationDetail.ProcessPaymentID
        //         .toString(),
        //     OrderNumber: widget.orderNumber,
        //     OrderDate: transectionDetailsResponse!.transcationDetail.OrderDate,
        //     ItemsPrice: widget.cartDetailsResponse.cartTotalPrice.toString(),
        //     ItemsShippingHandling:
        //         transectionDetailsResponse!.transcationDetail.ShippingHandling,
        //     ItemsBeforeTax:
        //         transectionDetailsResponse!.transcationDetail.TotalBeforeTax,
        //     ItemsEstimatedTax:
        //         transectionDetailsResponse!.transcationDetail.EstimatedTax,
        //     ItemsTotal:
        //         transectionDetailsResponse!.transcationDetail.OrderTotal,
        //     // DeliveryDriverID: 'NULL',
        //     CourierID: '1',
        //     TrackingNumber: null,
        //     ShippingLabel: null,
        //     ShippingDate: null,
        //     DeliveryDate: null,
        //     ReadyPickupForUser: null,
        //     ReadyPickupForAdmin: null,
        //     DeliveryConfirmationPic: null,
        //     AllowStorePickup:
        //         widget.paymentUserData!.pickUp == true ? 'Y' : 'N',
        //     AllowAdminPickup:
        //         widget.paymentUserData!.banglaBazarDelivery == true ? 'Y' : 'N',
        //     ProcessStatus: 'Processing',
        //     VendorPaymentStatus: 'N',
        //     Note: 'first order',
        //     DeliveryStatus: deliveryStatus,
        //     PaymentType: widget.paymentTypeCOD,
        //     productDetail: [
        //       ProductDetail(
        //           ProductID: widget
        //               .cartDetailsResponse.productCartList[0].ProductID
        //               .toString(),
        //           VendorStoreID: widget.cartDetailsResponse.productCartList[0]
        //               .productCombinations[0].VendorStoreID
        //               .toString(),
        //           ItemsPrice: widget.cartDetailsResponse.productCartList[0]
        //               .calculateTotalProductPrice
        //               .toString(),
        //           Quantity: widget
        //               .cartDetailsResponse.productCartList[0].TotalQuantity
        //               .toString(),
        //           productVariantCombinationDetail: [
        //             ProductVariantCombinationDetail(
        //                 ProductVariantCombinationID: widget
        //                     .cartDetailsResponse
        //                     .productCartList[0]
        //                     .productCombinations[0]
        //                     .ProductVariantCombinationID
        //                     .toString())
        //           ])
        //     ]);
        for (int j = 1;
            j <
                widget.cartDetailsResponse.productCartList[0]
                    .productCombinations.length;
            j++) {
          addProcessOrderModel.productDetail[0].productVariantCombinationDetail
              .add(ProductVariantCombinationDetail(
                  ProductVariantCombinationID: widget
                      .cartDetailsResponse
                      .productCartList[0]
                      .productCombinations[j]
                      .ProductVariantCombinationID
                      .toString()));
        }
        // addProcessOrderModel.UserID = AppGlobal.userID.toString();
        // addProcessOrderModel.ProcessPaymentID = transectionDetailsResponse!
        //     .transcationDetail.ProcessPaymentID
        //     .toString();
        // addProcessOrderModel.OrderNumber = widget.orderNumber;
        // addProcessOrderModel.OrderDate =
        //     transectionDetailsResponse!.transcationDetail.OrderDate;
        // addProcessOrderModel.ItemsPrice =
        //     widget.cartDetailsResponse.cartTotalPrice.toString();
        // addProcessOrderModel.ItemsShippingHandling =
        //     transectionDetailsResponse!.transcationDetail.ShippingHandling;
        // addProcessOrderModel.ItemsBeforeTax =
        //     transectionDetailsResponse!.transcationDetail.TotalBeforeTax;
        // addProcessOrderModel.ItemsEstimatedTax =
        //     transectionDetailsResponse!.transcationDetail.EstimatedTax;
        // addProcessOrderModel.ItemsTotal =
        //     transectionDetailsResponse!.transcationDetail.OrderTotal;
        // addProcessOrderModel.DeliveryDriverID = '92';
        // addProcessOrderModel.CourierID = '1';
        // addProcessOrderModel.TrackingNumber = '09007801';
        // addProcessOrderModel.ShippingLabel = 'NO Label';
        // addProcessOrderModel.ShippingDate = '2022-01-05 11:01:18';
        // addProcessOrderModel.DeliveryDate = '2022-01-05 11:01:18';
        // addProcessOrderModel.ReadyPickupForUser = 'Y';
        // addProcessOrderModel.ReadyPickupForAdmin = 'Y';
        // addProcessOrderModel.DeliveryConfirmationPic = 'general';
        // addProcessOrderModel.AllowStorePickup = 'Y';
        // addProcessOrderModel.ProcessStatus = 'Order Received';
        // addProcessOrderModel.VendorPaymentStatus = 'Y';
        // addProcessOrderModel.Note = 'first order';

        for (int i = 1;
            i < widget.cartDetailsResponse.productCartList.length;
            i++) {
          // addProcessOrderModel.productDetail!.add(
          //   ProductDetail(
          //       ProductID: widget
          //           .cartDetailsResponse.productCartList[i].ProductID
          //           .toString(),
          //       VendorStoreID: widget.cartDetailsResponse.productCartList[i]
          //           .productCombinations[0].VendorStoreID
          //           .toString(),
          //       Quantity: widget
          //           .cartDetailsResponse.productCartList[i].TotalQuantity
          //           .toString(),
          //       ItemsPrice: widget.cartDetailsResponse.productCartList[i]
          //           .calculateTotalProductPrice
          //           .toString(),
          //       productVariantCombinationDetail: []),
          // );
          for (int j = 0;
              j <
                  widget.cartDetailsResponse.productCartList[i]
                      .productCombinations.length;
              j++) {
            addProcessOrderModel
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
        _cartBloc
            .add(AddProcessOrder(addProcessOrderModel: addProcessOrderModel));
        //print(addProcessOrderModel.toJson());
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          // color: Colors.yellow,
                          width: screenSize.width,
                          height: screenSize.height * 0.16,
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          child: const Icon(Icons.done,
                              size: 45, color: kColorPrimary),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: kColorPrimary, width: 3),
                              shape: BoxShape.circle,
                              color: kColorWhite),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Thank you for your Order',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Order Number: ${widget.orderNumber}',
                          style: const TextStyle(
                              color: kColorDarkGreyText, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Thank you for placing your order! Your order is now complete and we already started processing it.',
                          style: TextStyle(
                              color: kColorFieldsBorders, fontSize: 14),
                          textAlign: TextAlign.center,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyOrders(
                                            previousPasge: 'usersOrders',
                                          )),
                                );
                              },
                              child: Container(
                                height: screenSize.height * 0.05,
                                width: screenSize.width * 0.43,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: kColorFieldsBorders),
                                  color: kColorWhite,
                                ),
                                child: const Center(
                                  child: Text(
                                    'View Order',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: kColorDarkGreyText,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                height: screenSize.height * 0.05,
                                width: screenSize.width * 0.43,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kColorPrimary,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Continue Shopping',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: kColorWhite, fontSize: 12),
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
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false);
    print('back button pressed');
    return Future.value(false);
  }
}

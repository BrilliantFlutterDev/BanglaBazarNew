import 'package:bangla_bazar/ModelClasses/get_order_details_response.dart';
import 'package:bangla_bazar/ModelClasses/order_return_model.dart';
import 'package:bangla_bazar/ModelClasses/user_refund_form_model.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/MyOrders/MyOrdersBloc/myorder_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:g_json/g_json.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  final String previousPage;
  final String orderNumber;
  const OrderDetails({
    Key? key,
    required this.previousPage,
    required this.orderNumber,
  }) : super(key: key);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late MyOrdersBloc _myOrdersBloc;
  GetOrderDetailsResponse? getOrderDetailsResponse;
  bool customerBoughtWrongItem = false;
  bool customerChangeMind = false;
  bool purchaseArrivedLate = false;
  bool damageProduct = false;
  String returnReason = '';
  OrderReturnModel? orderReturnModel;
  dynamic historyModel;
  List<String> historyList = [];

  bool showOrderReturnCheckbox = false;

  UserRefundFormModel? userRefundFormModel;

  TextEditingController reasonController = TextEditingController();

  void changeOrderStatusReturnBottomSheet() {
    showModalBottomSheet(
        elevation: 5,
        context: context,
        backgroundColor: kColorWhite,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          var screenSize = MediaQuery.of(context).size;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: const [
                      Icon(
                        MyFlutterApp.return_d,
                        color: kColorBlueText,
                        size: 65,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Order Return',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Kindly select the valid reason for return the order',
                        style:
                            TextStyle(color: kColorFieldsBorders, fontSize: 14),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'The customer bought the wrong item',
                      style: TextStyle(fontSize: 16),
                    ),
                    InkWell(
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kColorDarkGreyIcon,
                        ),
                        child: Center(
                            child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: kColorWhite,
                          ),
                          child: Center(
                              child: Container(
                            width: 13,
                            height: 13,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: customerBoughtWrongItem == true
                                  ? kColorPrimary
                                  : kColorWhite,
                            ),
                          )),
                        )),
                      ),
                      onTap: () {
                        if (customerBoughtWrongItem == false) {
                          customerBoughtWrongItem = true;
                          customerChangeMind = false;
                          damageProduct = false;
                          purchaseArrivedLate = false;
                          returnReason = 'The customer bought the wrong item';
                          Navigator.pop(context);
                          changeOrderStatusReturnBottomSheet();
                        } else {
                          customerBoughtWrongItem = false;
                          returnReason = '';
                          Navigator.pop(context);
                          changeOrderStatusReturnBottomSheet();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.75,
                      child: const Text(
                        'The customer changed their mind once they received it',
                        maxLines: 2,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kColorDarkGreyIcon,
                        ),
                        child: Center(
                            child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: kColorWhite,
                          ),
                          child: Center(
                              child: Container(
                            width: 13,
                            height: 13,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: customerChangeMind == true
                                  ? kColorPrimary
                                  : kColorWhite,
                            ),
                          )),
                        )),
                      ),
                      onTap: () {
                        if (customerChangeMind == false) {
                          customerChangeMind = true;
                          customerBoughtWrongItem = false;
                          damageProduct = false;
                          purchaseArrivedLate = false;
                          returnReason =
                              'The customer changed their mind once they received it';
                          Navigator.pop(context);
                          changeOrderStatusReturnBottomSheet();
                        } else {
                          customerChangeMind = false;
                          returnReason = '';
                          Navigator.pop(context);
                          changeOrderStatusReturnBottomSheet();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.75,
                      child: const Text(
                        'Purchase arrived too late or the customer doesn\'t need it anymore',
                        maxLines: 2,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kColorDarkGreyIcon,
                        ),
                        child: Center(
                            child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: kColorWhite,
                          ),
                          child: Center(
                              child: Container(
                            width: 13,
                            height: 13,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: purchaseArrivedLate == true
                                  ? kColorPrimary
                                  : kColorWhite,
                            ),
                          )),
                        )),
                      ),
                      onTap: () {
                        if (purchaseArrivedLate == false) {
                          purchaseArrivedLate = true;
                          customerBoughtWrongItem = false;
                          customerChangeMind = false;
                          damageProduct = false;
                          returnReason =
                              'Purchase arrived too late or the customer doesn\'t need it anymore';
                          Navigator.pop(context);
                          changeOrderStatusReturnBottomSheet();
                        } else {
                          purchaseArrivedLate = false;
                          returnReason = '';
                          Navigator.pop(context);
                          changeOrderStatusReturnBottomSheet();
                        }
                      },
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
                      'The product was damaged or defective',
                      style: TextStyle(fontSize: 16),
                    ),
                    InkWell(
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kColorDarkGreyIcon,
                        ),
                        child: Center(
                            child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: kColorWhite,
                          ),
                          child: Center(
                              child: Container(
                            width: 13,
                            height: 13,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: damageProduct == true
                                  ? kColorPrimary
                                  : kColorWhite,
                            ),
                          )),
                        )),
                      ),
                      onTap: () {
                        if (damageProduct == false) {
                          damageProduct = true;
                          customerBoughtWrongItem = false;
                          customerChangeMind = false;
                          purchaseArrivedLate = false;
                          returnReason = 'The product was damaged or defective';
                          Navigator.pop(context);
                          changeOrderStatusReturnBottomSheet();
                        } else {
                          damageProduct = false;
                          returnReason = '';
                          Navigator.pop(context);
                          changeOrderStatusReturnBottomSheet();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        customerBoughtWrongItem = false;
                        customerChangeMind = false;
                        damageProduct = false;
                        purchaseArrivedLate = false;
                        returnReason = '';
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: screenSize.height * 0.05,
                        width: screenSize.width * 0.38,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kColorFieldsBorders),
                          color: kColorWhite,
                        ),
                        child: const Center(
                          child: Text(
                            'No',
                            maxLines: 1,
                            style: TextStyle(
                                color: kColorDarkGreyText, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (returnReason != '') {
                          orderReturnModel = OrderReturnModel(
                              OrderNumber: getOrderDetailsResponse!
                                  .orderDetails.OrderNumber,
                              DeliveryDriverID:
                                  AppGlobal.deliveryDriverID.toString(),
                              ReturnReason: returnReason);
                          _myOrdersBloc.add(
                              ReturnOrder(orderReturnModel: orderReturnModel!));
                        }
                      },
                      child: Container(
                        height: screenSize.height * 0.05,
                        width: screenSize.width * 0.38,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kColorPrimary,
                        ),
                        child: const Center(
                          child: Text(
                            'Submit',
                            maxLines: 1,
                            style: TextStyle(color: kColorWhite, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();

    _myOrdersBloc = BlocProvider.of<MyOrdersBloc>(context);
    _myOrdersBloc.add(GetOrderDetails(orderNumber: widget.orderNumber));
  }

  late String? orderPlacedDate;
  late String? assignedDate;
  late String? pickedDate;
  late String? onTheWayDate;
  late String? deliveredDate;
  late String? orderPlacedTime;
  late String? assignedTime;
  late String? pickedTime;
  late String? onTheWayTime;
  late String? deliveredTime;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<MyOrdersBloc, MyOrdersState>(
        listener: (context, state) {
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
      } else if (state is OrderStatusChangeState) {
        Fluttertoast.showToast(
            msg: state.orderStatusChangeResponse.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
      } else if (state is UserOrderReturnState) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: 'Your request for order return is submitted successfully.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
      } else if (state is GetOrderDetailsState) {
        getOrderDetailsResponse = state.getOrderDetailsResponse;
        print('>>>>>>>>>>>Order Details State');
        if (getOrderDetailsResponse!.orderDetails.StatusHistory != '') {
          historyModel =
              JSON.parse(getOrderDetailsResponse!.orderDetails.StatusHistory!);

          if (historyModel[0].toString() != 'null') {
            assignedDate = historyModel[0].toString();
            assignedDate = assignedDate!.replaceAll("\"", "");

            assignedDate = DateFormat('dd MMM yyyy  hh:mm a')
                .format(DateTime.parse(assignedDate!))
                .toString();
          }
          if (historyModel[1].toString() != 'null') {
            pickedDate = historyModel[1].toString();
            pickedDate = pickedDate!.replaceAll("\"", "");

            pickedDate = DateFormat('dd MMM yyyy  hh:mm a')
                .format(DateTime.parse(pickedDate!))
                .toString();
          }
          if (historyModel[2].toString() != 'null') {
            onTheWayDate = historyModel[2].toString();
            onTheWayDate = onTheWayDate!.replaceAll("\"", "");

            onTheWayDate = DateFormat('dd MMM yyyy  hh:mm a')
                .format(DateTime.parse(onTheWayDate!))
                .toString();
          }
          if (historyModel[3].toString() != 'null') {
            deliveredDate = historyModel[3].toString();
            deliveredDate = deliveredDate!.replaceAll("\"", "");

            deliveredDate = DateFormat('dd MMM yyyy  hh:mm a')
                .format(DateTime.parse(deliveredDate!))
                .toString();
          }
        }
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
            backgroundColor: kColorWhite,
            // extendBody: true,
            // resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                ///This is the body
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: getOrderDetailsResponse != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // color: Colors.yellow,
                                width: screenSize.width,
                                height: screenSize.height * 0.15,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order No: ${getOrderDetailsResponse!.orderDetails.OrderNumber}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: kColorBlueText),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Placed Date:  ${getOrderDetailsResponse!.orderDetails.OrderDate}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: kColorDarkGreyText),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: screenSize.height * 0.03,
                                    // width: screenSize.width * 0.8,
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(75),
                                      color: kColorWidgetBackgroundColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        getOrderDetailsResponse!
                                            .orderDetails.PaymentStatus,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 1,
                                width: screenSize.width,
                                color: kColorFieldsBorders,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Shipping Address',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getOrderDetailsResponse!
                                        .orderShippingDetail!.DeliveryName,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: kColorDarkGreyText),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    '${getOrderDetailsResponse!.orderShippingDetail!.DeliveryAddress1},  ${getOrderDetailsResponse!.orderShippingDetail!.DeliveryCity},  ${getOrderDetailsResponse!.orderShippingDetail!.DeliveryState},  ${getOrderDetailsResponse!.orderShippingDetail!.DeliveryCountry}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: kColorFieldsBorders),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    'Ph No: ${getOrderDetailsResponse!.orderShippingDetail!.DeliveryPhoneNumber}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: kColorFieldsBorders),
                                  ),
                                  // const SizedBox(
                                  //   height: 7,
                                  // ),
                                  // const Text(
                                  //   'ronaldnelson@gmail.com',
                                  //   style: TextStyle(
                                  //       fontSize: 12,
                                  //       color: kColorFieldsBorders),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              widget.previousPage == 'UserMyOrders'
                                  ? getOrderDetailsResponse!
                                              .getStorePickupDetails !=
                                          null
                                      ? const SizedBox(
                                          height: 20,
                                        )
                                      : const SizedBox()
                                  : const SizedBox(),
                              widget.previousPage == 'UserMyOrders'
                                  ? getOrderDetailsResponse!
                                              .orderDetails.AllowStorePickup ==
                                          'Y'
                                      ? getOrderDetailsResponse!
                                                  .getStorePickupDetails !=
                                              null
                                          ? const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Store Pickup Address',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                              ),
                                            )
                                          : const SizedBox()
                                      : const SizedBox()
                                  : const SizedBox(),
                              widget.previousPage == 'UserMyOrders'
                                  ? getOrderDetailsResponse!
                                              .orderDetails.AllowStorePickup ==
                                          'Y'
                                      ? getOrderDetailsResponse!
                                                  .getStorePickupDetails !=
                                              null
                                          ? const SizedBox(
                                              height: 20,
                                            )
                                          : const SizedBox()
                                      : const SizedBox()
                                  : const SizedBox(),
                              widget.previousPage == 'UserMyOrders'
                                  ? getOrderDetailsResponse!
                                              .orderDetails.AllowStorePickup ==
                                          'Y'
                                      ? getOrderDetailsResponse!
                                                  .getStorePickupDetails !=
                                              null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  getOrderDetailsResponse!
                                                      .getStorePickupDetails!
                                                      .StoreName,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          kColorDarkGreyText),
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Text(
                                                  '${getOrderDetailsResponse!.getStorePickupDetails!.Address1},  ${getOrderDetailsResponse!.getStorePickupDetails!.City},  ${getOrderDetailsResponse!.getStorePickupDetails!.State}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          kColorFieldsBorders),
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Text(
                                                  getOrderDetailsResponse!
                                                              .getStorePickupDetails!
                                                              .StorePhone !=
                                                          'null'
                                                      ? getOrderDetailsResponse!
                                                          .getStorePickupDetails!
                                                          .StorePhone
                                                      : 'Phone number not available',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          kColorFieldsBorders),
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Text(
                                                  getOrderDetailsResponse!
                                                      .getStorePickupDetails!
                                                      .StoreEmail,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          kColorFieldsBorders),
                                                ),
                                              ],
                                            )
                                          : const SizedBox()
                                      : const SizedBox()
                                  : const SizedBox(),
                              widget.previousPage == 'UserMyOrders'
                                  ? getOrderDetailsResponse!
                                              .orderDetails.AllowStorePickup ==
                                          'Y'
                                      ? getOrderDetailsResponse!
                                                  .getStorePickupDetails !=
                                              null
                                          ? const SizedBox(
                                              height: 20,
                                            )
                                          : const SizedBox()
                                      : const SizedBox()
                                  : const SizedBox(),

                              ///Place Tracking Project here
                              getOrderDetailsResponse!
                                          .orderDetails.AllowStorePickup ==
                                      'N'
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              getOrderDetailsResponse!
                                                          .orderDetails
                                                          .StatusHistory !=
                                                      ''
                                                  ? historyModel[0]
                                                              .toString() !=
                                                          'null'
                                                      ? Text(
                                                          assignedDate!,
                                                          style: const TextStyle(
                                                              color:
                                                                  kColorDarkGreyIcon,
                                                              fontSize: 11),
                                                        )
                                                      : const Text(
                                                          '         ----           ',
                                                          style: TextStyle(
                                                              color:
                                                                  kColorWhite,
                                                              fontSize: 11),
                                                        )
                                                  : const Text(
                                                      '         ----           ',
                                                      style: TextStyle(
                                                          color: kColorWhite,
                                                          fontSize: 11),
                                                    ),
                                              // historyModel[0].toString() != 'null'
                                              //     ? Text(
                                              //         '11:30 PM',
                                              //         style: TextStyle(
                                              //             color: kColorDarkGreyIcon,
                                              //             fontSize: 12),
                                              //       )
                                              //     : SizedBox(),
                                              SizedBox(
                                                height:
                                                    screenSize.height * 0.11,
                                              ),
                                              getOrderDetailsResponse!
                                                          .orderDetails
                                                          .StatusHistory !=
                                                      ''
                                                  ? historyModel[1]
                                                              .toString() !=
                                                          'null'
                                                      ? Text(
                                                          pickedDate!,
                                                          style: const TextStyle(
                                                              color:
                                                                  kColorDarkGreyIcon,
                                                              fontSize: 11),
                                                        )
                                                      : const Text(
                                                          '         ----           ',
                                                          style: TextStyle(
                                                              color:
                                                                  kColorWhite,
                                                              fontSize: 11),
                                                        )
                                                  : const Text(
                                                      '         ----           ',
                                                      style: TextStyle(
                                                          color: kColorWhite,
                                                          fontSize: 11),
                                                    ),
                                              // Text(
                                              //   '11:30 PM',
                                              //   style: TextStyle(
                                              //       color: kColorDarkGreyIcon,
                                              //       fontSize: 12),
                                              // ),
                                              SizedBox(
                                                height:
                                                    screenSize.height * 0.13,
                                              ),
                                              getOrderDetailsResponse!
                                                          .orderDetails
                                                          .StatusHistory !=
                                                      ''
                                                  ? historyModel[2]
                                                              .toString() !=
                                                          'null'
                                                      ? Text(
                                                          onTheWayDate!,
                                                          style: const TextStyle(
                                                              color:
                                                                  kColorDarkGreyIcon,
                                                              fontSize: 11),
                                                        )
                                                      : const Text(
                                                          '         ----           ',
                                                          style: TextStyle(
                                                              color:
                                                                  kColorWhite,
                                                              fontSize: 11),
                                                        )
                                                  : const Text(
                                                      '         ----           ',
                                                      style: TextStyle(
                                                          color: kColorWhite,
                                                          fontSize: 11),
                                                    ),
                                              // Text(
                                              //   '11:30 PM',
                                              //   style: TextStyle(
                                              //       color: kColorDarkGreyIcon,
                                              //       fontSize: 12),
                                              // ),
                                              SizedBox(
                                                height: screenSize.height * 0.1,
                                              ),
                                              getOrderDetailsResponse!
                                                          .orderDetails
                                                          .StatusHistory !=
                                                      ''
                                                  ? historyModel[3]
                                                              .toString() !=
                                                          'null'
                                                      ? Text(
                                                          deliveredDate!,
                                                          style: const TextStyle(
                                                              color:
                                                                  kColorDarkGreyIcon,
                                                              fontSize: 11),
                                                        )
                                                      : const Text(
                                                          '         ----           ',
                                                          style: TextStyle(
                                                              color:
                                                                  kColorWhite,
                                                              fontSize: 11),
                                                        )
                                                  : const Text(
                                                      '         ----           ',
                                                      style: TextStyle(
                                                          color: kColorWhite,
                                                          fontSize: 11),
                                                    ),
                                              // Text(
                                              //   '11:30 PM',
                                              //   style: TextStyle(
                                              //       color: kColorDarkGreyIcon,
                                              //       fontSize: 12),
                                              // ),
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: kColorWhite,
                                                      border: Border.all(
                                                          color: getOrderDetailsResponse!
                                                                      .orderDetails
                                                                      .StatusHistory !=
                                                                  ''
                                                              ? historyModel[0]
                                                                          .toString() !=
                                                                      'null'
                                                                  ? kColorPrimary
                                                                  : kColorFieldsBorders
                                                              : kColorFieldsBorders)),
                                                  child: Center(
                                                    child: Text(
                                                      '1',
                                                      style: TextStyle(
                                                          color: getOrderDetailsResponse!
                                                                      .orderDetails
                                                                      .StatusHistory !=
                                                                  ''
                                                              ? historyModel[0]
                                                                          .toString() !=
                                                                      'null'
                                                                  ? kColorPrimary
                                                                  : kColorFieldsBorders
                                                              : kColorFieldsBorders,
                                                          fontSize: 14),
                                                    ),
                                                  )),
                                              Container(
                                                height: screenSize.height * 0.1,
                                                width: 1,
                                                color: getOrderDetailsResponse!
                                                            .orderDetails
                                                            .StatusHistory !=
                                                        ''
                                                    ? historyModel[1]
                                                                .toString() !=
                                                            'null'
                                                        ? kColorPrimary
                                                        : kColorFieldsBorders
                                                    : kColorFieldsBorders,
                                              ),
                                              Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: kColorWhite,
                                                      border: Border.all(
                                                          color: getOrderDetailsResponse!
                                                                      .orderDetails
                                                                      .StatusHistory !=
                                                                  ''
                                                              ? historyModel[1]
                                                                          .toString() !=
                                                                      'null'
                                                                  ? kColorPrimary
                                                                  : kColorFieldsBorders
                                                              : kColorFieldsBorders)),
                                                  child: Center(
                                                    child: Text(
                                                      '2',
                                                      style: TextStyle(
                                                          color: getOrderDetailsResponse!
                                                                      .orderDetails
                                                                      .StatusHistory !=
                                                                  ''
                                                              ? historyModel[1]
                                                                          .toString() !=
                                                                      'null'
                                                                  ? kColorPrimary
                                                                  : kColorFieldsBorders
                                                              : kColorFieldsBorders,
                                                          fontSize: 14),
                                                    ),
                                                  )),
                                              Container(
                                                height:
                                                    screenSize.height * 0.12,
                                                width: 1,
                                                color: getOrderDetailsResponse!
                                                            .orderDetails
                                                            .StatusHistory !=
                                                        ''
                                                    ? historyModel[2]
                                                                .toString() !=
                                                            'null'
                                                        ? kColorPrimary
                                                        : kColorFieldsBorders
                                                    : kColorFieldsBorders,
                                              ),
                                              Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: kColorWhite,
                                                      border: Border.all(
                                                          color: getOrderDetailsResponse!
                                                                      .orderDetails
                                                                      .StatusHistory !=
                                                                  ''
                                                              ? historyModel[2]
                                                                          .toString() !=
                                                                      'null'
                                                                  ? kColorPrimary
                                                                  : kColorFieldsBorders
                                                              : kColorFieldsBorders)),
                                                  child: Center(
                                                    child: Text(
                                                      '3',
                                                      style: TextStyle(
                                                          color: getOrderDetailsResponse!
                                                                      .orderDetails
                                                                      .StatusHistory !=
                                                                  ''
                                                              ? historyModel[2]
                                                                          .toString() !=
                                                                      'null'
                                                                  ? kColorPrimary
                                                                  : kColorFieldsBorders
                                                              : kColorFieldsBorders,
                                                          fontSize: 14),
                                                    ),
                                                  )),
                                              Container(
                                                height:
                                                    screenSize.height * 0.08,
                                                width: 1,
                                                color: getOrderDetailsResponse!
                                                            .orderDetails
                                                            .StatusHistory !=
                                                        ''
                                                    ? historyModel[3]
                                                                .toString() !=
                                                            'null'
                                                        ? kColorPrimary
                                                        : kColorFieldsBorders
                                                    : kColorFieldsBorders,
                                              ),
                                              Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: kColorWhite,
                                                      border: Border.all(
                                                          color: getOrderDetailsResponse!
                                                                      .orderDetails
                                                                      .StatusHistory !=
                                                                  ''
                                                              ? historyModel[3]
                                                                          .toString() !=
                                                                      'null'
                                                                  ? kColorPrimary
                                                                  : kColorFieldsBorders
                                                              : kColorFieldsBorders)),
                                                  child: Center(
                                                    child: Text(
                                                      '4',
                                                      style: TextStyle(
                                                          color: getOrderDetailsResponse!
                                                                      .orderDetails
                                                                      .StatusHistory !=
                                                                  ''
                                                              ? historyModel[3]
                                                                          .toString() !=
                                                                      'null'
                                                                  ? kColorPrimary
                                                                  : kColorFieldsBorders
                                                              : kColorFieldsBorders,
                                                          fontSize: 14),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height:
                                                    screenSize.height * 0.08,
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Assigned',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      getOrderDetailsResponse!
                                                                  .orderDetails
                                                                  .StatusHistory !=
                                                              ''
                                                          ? historyModel[0]
                                                                      .toString() !=
                                                                  'null'
                                                              ? widget.previousPage ==
                                                                      'UserMyOrders'
                                                                  ? 'Your order assigned to the delivery guy. Soon he/she will pickup from the store.'
                                                                  : 'This order is assigned to you, please pickup the order from the store as soon as possible.'
                                                              : ''
                                                          : '',
                                                      style: const TextStyle(
                                                          color:
                                                              kColorFieldsBorders,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                height: screenSize.height * 0.1,
                                              ),
                                              SizedBox(
                                                height:
                                                    screenSize.height * 0.04,
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Picked',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      getOrderDetailsResponse!
                                                                  .orderDetails
                                                                  .StatusHistory !=
                                                              ''
                                                          ? historyModel[1]
                                                                      .toString() !=
                                                                  'null'
                                                              ? widget.previousPage ==
                                                                      'UserMyOrders'
                                                                  ? 'Delivery guy picked up your order. Soon it will be at your door step.'
                                                                  : 'This order is Picked by you, delivered it safely to customer as soon as possible.'
                                                              : ''
                                                          : '',
                                                      style: const TextStyle(
                                                          color:
                                                              kColorFieldsBorders,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                height: screenSize.height * 0.1,
                                              ),
                                              SizedBox(
                                                height:
                                                    screenSize.height * 0.05,
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'On the Way',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      getOrderDetailsResponse!
                                                                  .orderDetails
                                                                  .StatusHistory !=
                                                              ''
                                                          ? historyModel[2]
                                                                      .toString() !=
                                                                  'null'
                                                              ? widget.previousPage ==
                                                                      'UserMyOrders'
                                                                  ? 'Delivery guy is on the way to delivered the order to you. Soon it will be at your door step get excited.'
                                                                  : 'You are on the way, customer is waiting for you. Please delivered it safely to customer as soon as possible.'
                                                              : ''
                                                          : '',
                                                      style: const TextStyle(
                                                          color:
                                                              kColorFieldsBorders,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                height: screenSize.height * 0.1,
                                              ),
                                              SizedBox(
                                                height:
                                                    screenSize.height * 0.02,
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Delivered',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      getOrderDetailsResponse!
                                                                  .orderDetails
                                                                  .StatusHistory !=
                                                              ''
                                                          ? historyModel[3]
                                                                      .toString() !=
                                                                  'null'
                                                              ? widget.previousPage ==
                                                                      'UserMyOrders'
                                                                  ? 'Did you received the order? If you received the order then open it and enjoy it. Don\'t forget to review the products.'
                                                                  : 'Thanks for your efforts.'
                                                              : ''
                                                          : '',
                                                      style: const TextStyle(
                                                          color:
                                                              kColorFieldsBorders,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                height: screenSize.height * 0.1,
                                              ),
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                          flex: 6,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),

                              getOrderDetailsResponse!
                                          .orderDetails.AllowStorePickup ==
                                      'N'
                                  ? const SizedBox(
                                      height: 30,
                                    )
                                  : const SizedBox(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Items',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  Container(
                                    height: screenSize.height * 0.03,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // border: Border.all(
                                      //     color: kColorWidgetBackgroundColor),
                                      color: kColorWidgetBackgroundColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '      ${getOrderDetailsResponse!.orderDetails.PaymentStatus}     ',
                                        //six spaces on each side

                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: getOrderDetailsResponse!
                                      .orderDetails.productDetail.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (BuildContext context, int i) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        i == 0
                                            ? showOrderReturnCheckbox == true
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Select the products for return',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                      InkWell(
                                                        child: Container(
                                                          height: screenSize
                                                                  .height *
                                                              0.03,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            // border: Border.all(
                                                            //     color: kColorWidgetBackgroundColor),
                                                          ),
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.cancel,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          if (showOrderReturnCheckbox ==
                                                              true) {
                                                            showOrderReturnCheckbox =
                                                                false;
                                                            setState(() {});
                                                          }
                                                        },
                                                      )
                                                    ],
                                                  )
                                                : const SizedBox()
                                            : const SizedBox(),
                                        i == 0
                                            ? showOrderReturnCheckbox == true
                                                ? const SizedBox(
                                                    height: 5,
                                                  )
                                                : const SizedBox()
                                            : const SizedBox(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: screenSize.height * 0.1,
                                              width: screenSize.width * 0.23,
                                              decoration: const BoxDecoration(
                                                color:
                                                    kColorWidgetBackgroundColor,
                                                // border: Border.all(
                                                //     color: kColorWidgetBackgroundColor, // Set border color
                                                //     width: 0.0),   // Set border width
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        10.0)), // Set rounded corner radius
                                                // Make rounded corner of border
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: AppGlobal
                                                        .photosBaseURL +
                                                    getOrderDetailsResponse!
                                                        .orderDetails
                                                        .productDetail[i]
                                                        .Medium
                                                        .replaceAll('\\', '/'),
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: kColorPrimary,
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  getOrderDetailsResponse!
                                                      .orderDetails
                                                      .productDetail[i]
                                                      .Title,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          kColorDarkGreyText),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Price: ${getOrderDetailsResponse!.orderDetails.productDetail[i].Currency} ${getOrderDetailsResponse!.orderDetails.productDetail[i].totalProductPrice}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      ' x ${getOrderDetailsResponse!.orderDetails.productDetail[i].Quantity}',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              kColorBlueText),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.2,
                                            ),
                                            widget.previousPage ==
                                                    'UserMyOrders'
                                                ? showOrderReturnCheckbox ==
                                                        true
                                                    ? Theme(
                                                        data: ThemeData(
                                                            unselectedWidgetColor:
                                                                Colors.grey),
                                                        child: Checkbox(
                                                          value: getOrderDetailsResponse!
                                                              .orderDetails
                                                              .productDetail[i]
                                                              .selectedForReturn,
                                                          onChanged: (state) {
                                                            getOrderDetailsResponse!
                                                                .orderDetails
                                                                .productDetail[
                                                                    i]
                                                                .selectedForReturn = state!;
                                                            setState(() {});
                                                          },
                                                          activeColor:
                                                              kColorPrimary,
                                                          checkColor:
                                                              Colors.white,
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .padded,
                                                        ))
                                                    : SizedBox(
                                                        width:
                                                            screenSize.width *
                                                                0.2,
                                                      )
                                                : const SizedBox()
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        widget.previousPage != 'UserMyOrders'
                                            ? Text(
                                                'Store Address : ${getOrderDetailsResponse!.orderDetails.productDetail[i].StoreName}  ${getOrderDetailsResponse!.orderDetails.productDetail[i].StoreAddress},  Ph# : ${getOrderDetailsResponse!.orderDetails.productDetail[i].StorePhone}',
                                                style: const TextStyle(
                                                    color: kColorOrangeText),
                                                maxLines: 2,
                                              )
                                            : const SizedBox(),
                                        widget.previousPage != 'UserMyOrders'
                                            ? const SizedBox(
                                                height: 10,
                                              )
                                            : const SizedBox(),
                                      ],
                                    );
                                  }),

                              const SizedBox(
                                height: 25,
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Order Summary',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Subtotal',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: kColorFieldsBorders),
                                  ),
                                  Text(
                                    '${getOrderDetailsResponse!.orderDetails.productDetail[0].Currency} ${getOrderDetailsResponse!.orderDetails.totalOrderPrice}',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Discount',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: kColorFieldsBorders),
                                  ),
                                  Text(
                                    '${getOrderDetailsResponse!.orderDetails.productDetail[0].Currency} 0',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Shipping',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: kColorFieldsBorders),
                                  ),
                                  Text(
                                    '${getOrderDetailsResponse!.orderDetails.productDetail[0].Currency} ${getOrderDetailsResponse!.orderDetails.ShippingHandling}',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Price',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    '${getOrderDetailsResponse!.orderDetails.productDetail[0].Currency} ${getOrderDetailsResponse!.orderDetails.OrderTotal}',
                                    style: const TextStyle(
                                        fontSize: 18, color: kColorPrimary),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenSize.height * 0.1,
                              ),
                            ],
                          )
                        : const SizedBox(),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(Icons.arrow_back)),
                                const Text(
                                  '  Order Details',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21),
                                ),
                              ],
                            ),
                            showOrderReturnCheckbox == false
                                ? InkWell(
                                    onTap: () {
                                      if (widget.previousPage ==
                                          'UserMyOrders') {
                                        if (showOrderReturnCheckbox == false) {
                                          showOrderReturnCheckbox = true;
                                          setState(() {});
                                        }
                                      } else {
                                        changeOrderStatusReturnBottomSheet();
                                      }
                                    },
                                    child: Container(
                                      height: screenSize.height * 0.04,
                                      // width: screenSize.width * 0.8,
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(75),
                                        color: kColorPrimary.withOpacity(0.2),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Order Return',
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: kColorPrimary,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      for (int z = 0;
                                          z <
                                              getOrderDetailsResponse!
                                                  .orderDetails
                                                  .productDetail
                                                  .length;
                                          z++) {
                                        userRefundFormModel =
                                            UserRefundFormModel(
                                                OrderNumber: widget.orderNumber,
                                                RefundResaon: '',
                                                product: []);
                                        if (getOrderDetailsResponse!
                                                .orderDetails
                                                .productDetail[z]
                                                .selectedForReturn ==
                                            true) {
                                          userRefundFormModel!.product.add(
                                              Product(
                                                  ProductID:
                                                      getOrderDetailsResponse!
                                                          .orderDetails
                                                          .productDetail[z]
                                                          .ProductID
                                                          .toString(),
                                                  productCombinations: []));
                                          int productInsertIndex =
                                              userRefundFormModel!
                                                  .product.length;
                                          for (int k = 0;
                                              k <
                                                  getOrderDetailsResponse!
                                                      .orderDetails
                                                      .productDetail[z]
                                                      .productCombinations
                                                      .length;
                                              k++) {
                                            userRefundFormModel!
                                                .product[productInsertIndex - 1]
                                                .productCombinations
                                                .add(ProductCombinationsReturn(
                                                    ProductVariantCombinationID:
                                                        getOrderDetailsResponse!
                                                            .orderDetails
                                                            .productDetail[z]
                                                            .productCombinations[
                                                                k]
                                                            .ProductVariantCombinationID
                                                            .toString()));
                                          }
                                        }
                                      }

                                      ///
                                      if (userRefundFormModel!
                                          .product.isNotEmpty) {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: const Center(
                                                  child: Text(
                                                    'Order Return',
                                                    style: TextStyle(
                                                        color: kColorBlueText),
                                                  ),
                                                ),
                                                content: Container(
                                                  height: 170,
                                                  width: 300,
                                                  decoration:
                                                      const BoxDecoration(
                                                    boxShadow: [],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: kColorWhite,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 8.0,
                                                    ),
                                                    child: TextField(
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      controller:
                                                          reasonController,
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
                                                      cursorColor:
                                                          kColorPrimary,
                                                      decoration:
                                                          InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        // hintText: getTranslated(context,
                                                        //     'typeherestartdictation'),
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 20, 40, 0),
                                                        hintText: 'Reason...',
                                                        hintStyle: TextStyle(
                                                            color: Colors
                                                                .grey.shade400),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  kColorFieldsBorders,
                                                              width: 1),
                                                        ),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  kColorFieldsBorders,
                                                              width: 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  Center(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                height: screenSize
                                                                        .height *
                                                                    0.05,
                                                                width: screenSize
                                                                        .width *
                                                                    0.25,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10,
                                                                        0,
                                                                        10,
                                                                        0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              kColorFieldsBorders),
                                                                  color:
                                                                      kColorWhite,
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                    'No',
                                                                    maxLines: 1,
                                                                    style: TextStyle(
                                                                        color:
                                                                            kColorDarkGreyText,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                if (reasonController
                                                                        .text !=
                                                                    '') {
                                                                  userRefundFormModel!
                                                                          .RefundResaon =
                                                                      reasonController
                                                                          .text;
                                                                  _myOrdersBloc.add(
                                                                      UserReturnOrder(
                                                                          userRefundFormModel:
                                                                              userRefundFormModel!));
                                                                  Navigator.pop(
                                                                      context);
                                                                } else {
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          'A valid reason must be entered for refund.',
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: ToastGravity
                                                                          .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                          1,
                                                                      backgroundColor: Colors
                                                                          .grey
                                                                          .shade400,
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          12.0);
                                                                }
                                                              },
                                                              child: Container(
                                                                height: screenSize
                                                                        .height *
                                                                    0.05,
                                                                width: screenSize
                                                                        .width *
                                                                    0.25,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10,
                                                                        0,
                                                                        10,
                                                                        0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color:
                                                                      kColorPrimary,
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                    'Submit',
                                                                    maxLines: 1,
                                                                    style: TextStyle(
                                                                        color:
                                                                            kColorWhite,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Please select a product for return',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                Colors.grey.shade400,
                                            textColor: Colors.white,
                                            fontSize: 12.0);
                                      }
                                    },
                                    child: Container(
                                      height: screenSize.height * 0.04,
                                      // width: screenSize.width * 0.8,
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(75),
                                        color: Colors.red.withOpacity(0.2),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Return Selected Orders',
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                      ),
                                    ),
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
}

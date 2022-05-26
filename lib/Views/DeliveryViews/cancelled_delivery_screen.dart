import 'package:bangla_bazar/ModelClasses/dashboard_model.dart';
import 'package:bangla_bazar/ModelClasses/dashboard_response.dart';
import 'package:bangla_bazar/ModelClasses/get_driver_orders_by_status_response.dart'
    as driverOrders;
import 'package:bangla_bazar/ModelClasses/order_details_response.dart'
    as myorders;
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';

import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/MyOrders/MyOrdersBloc/myorder_bloc.dart';
import 'package:bangla_bazar/Views/MyOrders/order_details_screen.dart';

import 'package:bangla_bazar/Views/main_home_page.dart';
import 'package:bangla_bazar/Widgets/driver_my_orders_widget.dart';
import 'package:bangla_bazar/Widgets/my_orders_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CancelledDeliveryScreen extends StatefulWidget {
  final String previousPasge;
  const CancelledDeliveryScreen({
    Key? key,
    required this.previousPasge,
  }) : super(key: key);
  @override
  _CancelledDeliveryScreenState createState() =>
      _CancelledDeliveryScreenState();
}

class _CancelledDeliveryScreenState extends State<CancelledDeliveryScreen> {
  late MyOrdersBloc _myOrdersBloc;

  late String statusFilterValueChoose;

  int offset = 0;
  int totalPages = 0;

  //myorders.OrderDetailsResponse? orderDetailsResponse;
  driverOrders.GetDriverOrdersByStatusResponse? getDriverOrdersByStatusResponse;

  void changeOrderStatusDeliveredBottomSheet() {
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: const [
                      Icon(
                        MyFlutterApp.completed_d,
                        color: kColorPrimary,
                        size: 75,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Mark as Delivered',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Do you want to mark this order as delivered ?',
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
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
                      onTap: () {},
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
                            'Mark as Delivered',
                            maxLines: 1,
                            style: TextStyle(color: kColorWhite, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void changeOrderStatusCancelBottomSheet() {
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: const [
                      Icon(
                        MyFlutterApp.cancelled_d,
                        color: Colors.red,
                        size: 75,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Cancel Order',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Do you want to cancel this order ?',
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
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
                      onTap: () {},
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
                            'Cancel Order',
                            maxLines: 1,
                            style: TextStyle(color: kColorWhite, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void changeOrderStatusPickedBottomSheet() {
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: const [
                      Icon(
                        MyFlutterApp.mark_as_picked_d,
                        color: kColorBlueText,
                        size: 75,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Mark as Picked',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Do you want to mark this order as picked ?',
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
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
                      onTap: () {},
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
                            'Mark as Picked',
                            maxLines: 1,
                            style: TextStyle(color: kColorWhite, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void changeOrderStatusOnTheWayBottomSheet() {
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: const [
                      Icon(
                        MyFlutterApp.on_the_way_d,
                        color: kColorBlueText,
                        size: 75,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'On the Way',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Do you want to mark this order as on the Way ?',
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
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
                      onTap: () {},
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
                            'Mark as on the Way',
                            maxLines: 1,
                            style: TextStyle(color: kColorWhite, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
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
    statusFilterValueChoose = 'Cancelled';

    _myOrdersBloc
        .add(GetDriversOrders(offset: 0, status: statusFilterValueChoose));
  }

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
      } else if (state is GetDriverOrdersState) {
        getDriverOrdersByStatusResponse = state.getDriverOrdersByStatusResponse;
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
            backgroundColor: kColorWhite,
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                ///This is the body
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          // color: Colors.yellow,
                          width: screenSize.width,
                          height: screenSize.height * 0.15,
                        ),
                        Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    getDriverOrdersByStatusResponse != null
                                        ? getDriverOrdersByStatusResponse!
                                            .orderDetails.length
                                        : 0,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int i) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          getDriverOrdersByStatusResponse!
                                              .orderDetails[i]
                                              .productDetail
                                              .length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int j) {
                                        return Column(
                                          children: [
                                            Visibility(
                                              child: Container(
                                                width: screenSize.width,
                                                decoration: const BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black12,
                                                        offset: Offset(0, 20.0),
                                                        blurRadius: 50.0,
                                                        spreadRadius: 0.5,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    color: kColorWhite),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Order Number: ${getDriverOrdersByStatusResponse!.orderDetails[i].OrderNumber}',
                                                            style: const TextStyle(
                                                                color:
                                                                    kColorBlueText,
                                                                fontSize: 14),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            'Placed Date: ${getDriverOrdersByStatusResponse!.orderDetails[i].OrderDate}',
                                                            style: const TextStyle(
                                                                color:
                                                                    kColorFieldsBorders,
                                                                fontSize: 10),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        height:
                                                            screenSize.height *
                                                                0.03,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          // border: Border.all(
                                                          //     color: kColorWidgetBackgroundColor),
                                                          color:
                                                              kColorOrangeText,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '      ${getDriverOrdersByStatusResponse!.orderDetails[i].PaymentStatus}      ',
                                                            //six spaces on each side

                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color:
                                                                    kColorWhite,
                                                                fontSize: 10),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              visible: j == 0 ? true : false,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            DriversMyOrdersWidget(
                                              screenSize: screenSize,
                                              onPressOrderDetails: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderDetails(
                                                            previousPage:
                                                                'DriverMyOrders',
                                                            orderNumber:
                                                                getDriverOrdersByStatusResponse!
                                                                    .orderDetails[
                                                                        i]
                                                                    .productDetail[
                                                                        j]
                                                                    .OrderNumber,
                                                          )),
                                                );
                                              },
                                              onPressOrderStatusChange: () {},
                                              buttonOrderStatus:
                                                  getDriverOrdersByStatusResponse!
                                                      .orderDetails[i]
                                                      .productDetail[j]
                                                      .ProcessStatus,
                                              productDetail:
                                                  getDriverOrdersByStatusResponse!
                                                      .orderDetails[i]
                                                      .productDetail[j],
                                            ),
                                          ],
                                        );
                                      });
                                })
                          ],
                        ),
                        SizedBox(
                          height: screenSize.height * 0.1,
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
                                    '  Deliveries Cancelled',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 21),
                                  ),
                                ],
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
}

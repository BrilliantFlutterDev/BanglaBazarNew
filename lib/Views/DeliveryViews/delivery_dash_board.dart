import 'package:bangla_bazar/ModelClasses/dashboard_model.dart';
import 'package:bangla_bazar/ModelClasses/dashboard_response.dart';
import 'package:bangla_bazar/ModelClasses/get_driver_orders_by_status_response.dart'
    as driverOrders;
import 'package:bangla_bazar/ModelClasses/order_status_change_model.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/MyOrders/MyOrdersBloc/myorder_bloc.dart';
import 'package:bangla_bazar/Views/MyOrders/order_details_screen.dart';
import 'package:bangla_bazar/Widgets/driver_my_orders_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeliveryDashBoard extends StatefulWidget {
  final String previousPasge;
  const DeliveryDashBoard({
    Key? key,
    required this.previousPasge,
  }) : super(key: key);
  @override
  _DeliveryDashBoardState createState() => _DeliveryDashBoardState();
}

class _DeliveryDashBoardState extends State<DeliveryDashBoard> {
  late MyOrdersBloc _myOrdersBloc;
  DashBoardModel? dashBoardModel;
  DashBoardResponse? dashBoardResponse;
  OrderStatusChangeModel? orderStatusChangeModel;

  int selectedTeb = 1;
  late String statusFilterValueChoose;
  List<String> statusFiltersList = [
    'All',
    'Delivered',
    'Cancelled',
    'Picked',
    'Returned'
  ];
  int offset = 0;
  int totalPages = 0;
  bool loadingNextPage = false;
  final _scrollController = ScrollController();

  late String statusFilterValueChooseDashBoard;
  List<String> statusFiltersListDashBoard = [
    'This Week',
    'Last Week',
    'This Month',
    'Last Month',
    'Last 3 Months',
    'Last 6 Months'
  ];

  //myorders.OrderDetailsResponse? orderDetailsResponse;
  List<driverOrders.OrderDetails>? orderDetails = [];
  void changeOrderStatusDeliveredBottomSheet(String orderNumber) {
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
                      onTap: () {
                        orderStatusChangeModel = OrderStatusChangeModel(
                            DeliveryDriverID:
                                AppGlobal.deliveryDriverID.toString(),
                            OrderNumber: orderNumber,
                            status: 'Delivered');
                        _myOrdersBloc.add(OrderStatusChange(
                            orderStatusChangeModel: orderStatusChangeModel!));
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

  void changeOrderStatusCancelBottomSheet(String orderNumber) {
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
                      onTap: () {
                        orderStatusChangeModel = OrderStatusChangeModel(
                            DeliveryDriverID:
                                AppGlobal.deliveryDriverID.toString(),
                            OrderNumber: orderNumber,
                            status: 'Cancelled');
                        _myOrdersBloc.add(OrderStatusChange(
                            orderStatusChangeModel: orderStatusChangeModel!));
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

  void changeOrderStatusPickedBottomSheet(String orderNumber) {
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
                      onTap: () {
                        orderStatusChangeModel = OrderStatusChangeModel(
                            DeliveryDriverID:
                                AppGlobal.deliveryDriverID.toString(),
                            OrderNumber: orderNumber,
                            status: 'Picked');
                        _myOrdersBloc.add(OrderStatusChange(
                            orderStatusChangeModel: orderStatusChangeModel!));
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

  void changeOrderStatusOnTheWayBottomSheet(String orderNumber) {
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
                      onTap: () {
                        orderStatusChangeModel = OrderStatusChangeModel(
                            DeliveryDriverID:
                                AppGlobal.deliveryDriverID.toString(),
                            OrderNumber: orderNumber,
                            status: 'On the Way');
                        _myOrdersBloc.add(OrderStatusChange(
                            orderStatusChangeModel: orderStatusChangeModel!));
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
    statusFilterValueChoose = 'All';
    statusFilterValueChooseDashBoard = 'This Week';
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (offset < totalPages - 1) {
          offset++;
          loadingNextPage = true;
          _myOrdersBloc.add(
              GetDriversOrders(offset: 0, status: statusFilterValueChoose));
          print('Load Next Page');
        }
        print('Load Next Page');
      }
    });
    _myOrdersBloc
        .add(GetDriversOrders(offset: 0, status: statusFilterValueChoose));
    dashBoardModel = DashBoardModel(
        DeliveryDriverID: AppGlobal.deliveryDriverID.toString(),
        filter: statusFilterValueChooseDashBoard);
    _myOrdersBloc.add(DashBoard(dashBoardModel: dashBoardModel!));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<MyOrdersBloc, MyOrdersState>(
        listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is ErrorState) {
        //Navigator.pop(context);
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
        if (loadingNextPage == false) {
          orderDetails!.clear();

          totalPages =
              (state.getDriverOrdersByStatusResponse.totalRecords / 10).ceil();
          orderDetails!
              .addAll(state.getDriverOrdersByStatusResponse.orderDetails);
          print('Total Pages: $totalPages');
        } else {
          orderDetails!
              .addAll(state.getDriverOrdersByStatusResponse.orderDetails);
        }
      } else if (state is DashBoardState) {
        dashBoardResponse = state.dashBoardResponse;
      } else if (state is OrderStatusChangeState) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: state.orderStatusChangeResponse.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
        _myOrdersBloc
            .add(GetDriversOrders(offset: 0, status: statusFilterValueChoose));
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
                  controller: _scrollController,
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // border:
                            //     Border.all(color: kColorWidgetBackgroundColor),
                            color: kColorWidgetBackgroundColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (selectedTeb == 2) {
                                    setState(() {
                                      selectedTeb = 1;
                                    });
                                  }
                                },
                                child: Container(
                                  height: screenSize.height * 0.05,
                                  width: screenSize.width * 0.43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // border: Border.all(
                                    //     color: kColorWidgetBackgroundColor),
                                    color: selectedTeb == 1
                                        ? kColorPrimary
                                        : kColorWidgetBackgroundColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Dashboard',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: selectedTeb == 1
                                              ? kColorWhite
                                              : kColorDarkGreyText,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (selectedTeb == 1) {
                                    setState(() {
                                      selectedTeb = 2;
                                    });
                                  }
                                },
                                child: Container(
                                  height: screenSize.height * 0.05,
                                  width: screenSize.width * 0.43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: selectedTeb == 2
                                        ? kColorPrimary
                                        : kColorWidgetBackgroundColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'My Orders',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: selectedTeb == 2
                                              ? kColorWhite
                                              : kColorDarkGreyText,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        selectedTeb == 2
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Orders List',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      Container(
                                        width: screenSize.width * 0.30,
                                        height: 35,
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                kColorFieldsBorders, //                   <--- border width here
                                          ),
                                        ),
                                        child: DropdownButton(
                                          hint: Text(
                                            statusFilterValueChoose,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: kColorDarkGreyText,
                                                fontSize: 12),
                                          ),
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          dropdownColor:
                                              kColorWidgetBackgroundColor,
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: kColorDarkGreyIcon,
                                            size: 15,
                                          ),
                                          iconSize: 36,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                          onChanged: (valueItem) {},
                                          items: statusFiltersList
                                              .map((valueItem) {
                                            return DropdownMenuItem(
                                              child: Text(valueItem),
                                              value: valueItem,
                                              onTap: () {
                                                setState(() {
                                                  statusFilterValueChoose =
                                                      valueItem;
                                                  _myOrdersBloc.add(
                                                      GetDriversOrders(
                                                          offset: 0,
                                                          status:
                                                              statusFilterValueChoose));
                                                });
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: orderDetails != null
                                          ? orderDetails!.length
                                          : 0,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: orderDetails![i]
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
                                                              color: Colors
                                                                  .black12,
                                                              offset: Offset(
                                                                  0, 20.0),
                                                              blurRadius: 50.0,
                                                              spreadRadius: 0.5,
                                                            ),
                                                          ],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0)),
                                                          color: kColorWhite),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
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
                                                                  'Order Number: ${orderDetails![i].OrderNumber}',
                                                                  style: const TextStyle(
                                                                      color:
                                                                          kColorBlueText,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'Placed Date: ${orderDetails![i].OrderDate}',
                                                                  style: const TextStyle(
                                                                      color:
                                                                          kColorFieldsBorders,
                                                                      fontSize:
                                                                          10),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'Order Total : ${(orderDetails![i].totalOrderPrice + orderDetails![i].totalOrderTax + orderDetails![i].totalOrderShippingPrice).toStringAsFixed(2)}',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
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
                                                                color:
                                                                    kColorOrangeText,
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  '      ${orderDetails![i].PaymentStatus}      ',
                                                                  //six spaces on each side

                                                                  maxLines: 1,
                                                                  style: const TextStyle(
                                                                      color:
                                                                          kColorWhite,
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    visible:
                                                        j == 0 ? true : false,
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
                                                                      orderDetails![
                                                                              i]
                                                                          .productDetail[
                                                                              j]
                                                                          .OrderNumber,
                                                                )),
                                                      );
                                                    },
                                                    onPressOrderStatusChange:
                                                        () {
                                                      if (orderDetails![i]
                                                              .productDetail[j]
                                                              .ProcessStatus ==
                                                          'Assigned') {
                                                        changeOrderStatusPickedBottomSheet(
                                                            orderDetails![i]
                                                                .productDetail[
                                                                    j]
                                                                .OrderNumber);
                                                      } else if (orderDetails![
                                                                  i]
                                                              .productDetail[j]
                                                              .ProcessStatus ==
                                                          'Picked') {
                                                        changeOrderStatusOnTheWayBottomSheet(
                                                            orderDetails![i]
                                                                .productDetail[
                                                                    j]
                                                                .OrderNumber);
                                                      } else if (orderDetails![
                                                                  i]
                                                              .productDetail[j]
                                                              .ProcessStatus ==
                                                          'On the Way') {
                                                        changeOrderStatusDeliveredBottomSheet(
                                                            orderDetails![i]
                                                                .productDetail[
                                                                    j]
                                                                .OrderNumber);
                                                      }
                                                    },
                                                    buttonOrderStatus:
                                                        orderDetails![i]
                                                            .productDetail[j]
                                                            .ProcessStatus,
                                                    productDetail:
                                                        orderDetails![i]
                                                            .productDetail[j],
                                                  ),
                                                ],
                                              );
                                            });
                                      })
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: screenSize.height * 0.14,
                                        width: screenSize.width * 0.43,
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 15.0),
                                              blurRadius: 25.0,
                                              spreadRadius: 0.2,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: kColorWhite,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              MyFlutterApp.completed_delivery_d,
                                              size: 45,
                                              color: kColorOrangeText,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
                                              'Completed Delivery',
                                              style: TextStyle(
                                                  color: kColorDarkGreyText,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              dashBoardResponse != null
                                                  ? dashBoardResponse!
                                                      .driverOrderStatusCount
                                                      .DeliveredOrders
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: screenSize.height * 0.14,
                                        width: screenSize.width * 0.43,
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 15.0),
                                              blurRadius: 25.0,
                                              spreadRadius: 0.2,
                                            ),
                                          ],
                                          color: kColorWhite,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              MyFlutterApp.pending_delivery_d,
                                              size: 45,
                                              color: kColorOrangeText,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
                                              'Pending Delivery',
                                              style: TextStyle(
                                                  color: kColorDarkGreyText,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              dashBoardResponse != null
                                                  ? dashBoardResponse!
                                                      .driverOrderStatusCount
                                                      .AssignedOrders
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: screenSize.height * 0.14,
                                        width: screenSize.width * 0.43,
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 15.0),
                                              blurRadius: 25.0,
                                              spreadRadius: 0.2,
                                            ),
                                          ],
                                          color: kColorWhite,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              MyFlutterApp.cancelled_delivery_d,
                                              size: 45,
                                              color: kColorOrangeText,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
                                              'Cancelled Delivery',
                                              style: TextStyle(
                                                  color: kColorDarkGreyText,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              dashBoardResponse != null
                                                  ? dashBoardResponse!
                                                      .driverOrderStatusCount
                                                      .CancelledOrders
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: screenSize.height * 0.14,
                                        width: screenSize.width * 0.43,
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 15.0),
                                              blurRadius: 25.0,
                                              spreadRadius: 0.2,
                                            ),
                                          ],
                                          color: kColorWhite,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              MyFlutterApp.total_collected_d,
                                              size: 45,
                                              color: kColorOrangeText,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
                                              'Total Collected',
                                              style: TextStyle(
                                                  color: kColorDarkGreyText,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              dashBoardResponse != null
                                                  ? dashBoardResponse!
                                                      .getDriverCollectedAmout
                                                      .TotalCollected!
                                                  : '0',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Your Order Details ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 85,
                                            height: 85,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0, 8.0),
                                                  blurRadius: 15.0,
                                                  spreadRadius: 0.1,
                                                ),
                                              ],
                                              color: kColorWhite,
                                            ),
                                            child: Center(
                                              child: Container(
                                                width: 55,
                                                height: 55,
                                                child: const Icon(
                                                  MyFlutterApp.on_the_way_d,
                                                  color: kColorPrimary,
                                                  size: 45,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'On the Way (${dashBoardResponse != null ? dashBoardResponse!.driverOrderStatusCount.PickedOrders.toString() : '0'})',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 85,
                                            height: 85,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0, 8.0),
                                                  blurRadius: 15.0,
                                                  spreadRadius: 0.1,
                                                ),
                                              ],
                                              color: kColorWhite,
                                            ),
                                            child: Center(
                                              child: Container(
                                                width: 55,
                                                height: 55,
                                                child: const Icon(
                                                  MyFlutterApp.picked_d,
                                                  color: kColorPrimary,
                                                  size: 45,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Picked (${dashBoardResponse != null ? dashBoardResponse!.driverOrderStatusCount.PickedOrders.toString() : '0'})',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 85,
                                            height: 85,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0, 8.0),
                                                  blurRadius: 15.0,
                                                  spreadRadius: 0.1,
                                                ),
                                              ],
                                              color: kColorWhite,
                                            ),
                                            child: Center(
                                              child: Container(
                                                width: 55,
                                                height: 55,
                                                child: const Icon(
                                                  MyFlutterApp.assigned_d,
                                                  color: kColorPrimary,
                                                  size: 45,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Assigned (${dashBoardResponse != null ? dashBoardResponse!.driverOrderStatusCount.AssignedOrders.toString() : '0'})',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 85,
                                            height: 85,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0, 8.0),
                                                  blurRadius: 15.0,
                                                  spreadRadius: 0.1,
                                                ),
                                              ],
                                              color: kColorWhite,
                                            ),
                                            child: Center(
                                              child: Container(
                                                width: 55,
                                                height: 55,
                                                child: const Icon(
                                                  MyFlutterApp.to_be_return_d,
                                                  color: kColorPrimary,
                                                  size: 45,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'To be Return (${dashBoardResponse != null ? dashBoardResponse!.driverOrderStatusCount.TobeReturnedOrders.toString() : '0'})',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 35,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 85,
                                            height: 85,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0, 8.0),
                                                  blurRadius: 15.0,
                                                  spreadRadius: 0.1,
                                                ),
                                              ],
                                              color: kColorWhite,
                                            ),
                                            child: Center(
                                              child: Container(
                                                width: 55,
                                                height: 55,
                                                child: const Icon(
                                                  MyFlutterApp.return_d,
                                                  color: kColorPrimary,
                                                  size: 45,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Return (${dashBoardResponse != null ? dashBoardResponse!.driverOrderStatusCount.ReturnedOrders.toString() : '0'})',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
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
                                    '  Delivery Orders',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 21),
                                  ),
                                ],
                              ),
                              selectedTeb == 1
                                  ? Container(
                                      width: screenSize.width * 0.35,
                                      height: 35,
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: 1,
                                          color:
                                              kColorFieldsBorders, //                   <--- border width here
                                        ),
                                      ),
                                      child: DropdownButton(
                                        hint: Text(
                                          statusFilterValueChooseDashBoard,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: kColorDarkGreyText,
                                              fontSize: 12),
                                        ),
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        dropdownColor:
                                            kColorWidgetBackgroundColor,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: kColorDarkGreyIcon,
                                          size: 15,
                                        ),
                                        iconSize: 36,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        onChanged: (valueItem) {},
                                        items: statusFiltersListDashBoard
                                            .map((valueItem) {
                                          return DropdownMenuItem(
                                            child: Text(valueItem),
                                            value: valueItem,
                                            onTap: () {
                                              setState(() {
                                                statusFilterValueChooseDashBoard =
                                                    valueItem;
                                                dashBoardModel = DashBoardModel(
                                                    DeliveryDriverID: AppGlobal
                                                        .deliveryDriverID
                                                        .toString(),
                                                    filter:
                                                        statusFilterValueChooseDashBoard);
                                                _myOrdersBloc.add(DashBoard(
                                                    dashBoardModel:
                                                        dashBoardModel!));
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  : const SizedBox(),
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

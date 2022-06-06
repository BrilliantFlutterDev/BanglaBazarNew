import 'package:bangla_bazar/ModelClasses/order_details_response.dart'
    as myorders;
import 'package:bangla_bazar/Utils/app_colors.dart';

import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/MyOrders/MyOrdersBloc/myorder_bloc.dart';
import 'package:bangla_bazar/Views/MyOrders/order_details_screen.dart';

import 'package:bangla_bazar/Views/main_home_page.dart';
import 'package:bangla_bazar/Widgets/my_orders_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyOrders extends StatefulWidget {
  final String previousPasge;
  const MyOrders({
    Key? key,
    required this.previousPasge,
  }) : super(key: key);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  late MyOrdersBloc _myOrdersBloc;

  int selectedTeb = 1;
  late String statusFilterValueChoose;
  List<String> statusFiltersList = ['Inprocess', 'Ongoing', 'Delivered'];

  myorders.OrderDetailsResponse? orderDetailsResponse;

  List<myorders.OrderDetails>? orderDetails = [];

  int offset = 0;
  int totalPages = 0;
  bool loadingNextPage = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _myOrdersBloc = BlocProvider.of<MyOrdersBloc>(context);

    statusFilterValueChoose = 'Ongoing';
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (offset < totalPages - 1) {
          offset++;
          loadingNextPage = true;
          _myOrdersBloc.add(GetMyOrders(offset: offset, search: ''));
          print('Load Next Page');
        }
      }
    });
    _myOrdersBloc.add(GetMyOrders(offset: 0, search: ''));
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
      } else if (state is GetMyOrdersState) {
        if (loadingNextPage == false) {
          orderDetails!.clear();
          orderDetailsResponse = state.orderDetailsResponse;
          totalPages = (orderDetailsResponse!.totalRecords / 10).ceil();
          orderDetails!.addAll(orderDetailsResponse!.orderDetails);
          print('Total Pages: $totalPages');
        } else {
          orderDetails!.addAll(state.orderDetailsResponse.orderDetails);
        }
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
                                      'My Orders',
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
                                      'Orders History',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Orders List',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Container(
                              width: screenSize.width * 0.30,
                              height: 35,
                              padding: EdgeInsets.only(left: 16, right: 16),
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
                                  statusFilterValueChoose,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: kColorDarkGreyText, fontSize: 12),
                                ),
                                isExpanded: true,
                                underline: const SizedBox(),
                                dropdownColor: kColorWidgetBackgroundColor,
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
                                items: statusFiltersList.map((valueItem) {
                                  return DropdownMenuItem(
                                    child: Text(valueItem),
                                    value: valueItem,
                                    onTap: () {
                                      setState(() {
                                        statusFilterValueChoose = valueItem;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        orderDetails != null
                            ? orderDetails!.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: orderDetails != null
                                        ? orderDetails!.length
                                        : 0,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (BuildContext context, int i) {
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
                                                            color:
                                                                Colors.black12,
                                                            offset:
                                                                Offset(0, 20.0),
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
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                          Row(
                                                            children: [
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
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              InkWell(
                                                                  onTap: () {
                                                                    if (orderDetails![
                                                                            i]
                                                                        .openOrderDetailsDropDown) {
                                                                      orderDetails![i]
                                                                              .openOrderDetailsDropDown =
                                                                          false;
                                                                      setState(
                                                                          () {});
                                                                    } else {
                                                                      orderDetails![i]
                                                                              .openOrderDetailsDropDown =
                                                                          true;
                                                                      setState(
                                                                          () {});
                                                                    }
                                                                  },
                                                                  child: Icon(orderDetails![
                                                                              i]
                                                                          .openOrderDetailsDropDown
                                                                      ? Icons
                                                                          .keyboard_arrow_up_sharp
                                                                      : Icons
                                                                          .keyboard_arrow_down_sharp))
                                                            ],
                                                          ),
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
                                                Visibility(
                                                  child: MyOrdersWidget(
                                                    screenSize: screenSize,
                                                    onPressOrderDetails: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                OrderDetails(
                                                                  previousPage:
                                                                      'UserMyOrders',
                                                                  orderNumber:
                                                                      orderDetails![
                                                                              i]
                                                                          .productDetail[
                                                                              j]
                                                                          .OrderNumber,
                                                                )),
                                                      );
                                                    },
                                                    productDetail:
                                                        orderDetails![i]
                                                            .productDetail[j],
                                                  ),
                                                  visible: orderDetails![i]
                                                      .openOrderDetailsDropDown,
                                                ),
                                              ],
                                            );
                                          });
                                    })
                                : Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/no_order.png',
                                          scale: 4,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'No order yet',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorFieldsBorders),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()),
                                                    (Route<dynamic> route) =>
                                                        false);
                                          },
                                          child: Container(
                                            height: screenSize.height * 0.05,
                                            width: screenSize.width * 0.43,
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: kColorPrimary,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Order Now',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: kColorWhite,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/no_order.png',
                                      scale: 4,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Orders',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ],
                                ),
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
                                    '  My Orders',
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

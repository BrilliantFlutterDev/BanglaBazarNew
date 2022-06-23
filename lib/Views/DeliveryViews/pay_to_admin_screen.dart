import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/MyOrders/MyOrdersBloc/myorder_bloc.dart';
import 'package:bangla_bazar/Widgets/bottom_sheet_choose_pic_source_widget.dart';
import 'package:bangla_bazar/Widgets/pay_to_admin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bangla_bazar/ModelClasses/get_driver_orders_by_status_response.dart'
    as driverOrders;
import 'package:image_picker/image_picker.dart';

class PayToAdminScreen extends StatefulWidget {
  const PayToAdminScreen({
    Key? key,
  }) : super(key: key);
  @override
  _PayToAdminScreenState createState() => _PayToAdminScreenState();
}

class _PayToAdminScreenState extends State<PayToAdminScreen> {
  late MyOrdersBloc _myOrdersBloc;
  int offset = 0;
  int totalPages = 0;
  bool loadingNextPage = false;
  final _scrollController = ScrollController();

  List<driverOrders.OrderDetails>? orderDetails = [];
  List<driverOrders.OrderDetails>? orderDetailsTemp = [];

  double totalPriceToPay = 0.0;

  @override
  void initState() {
    super.initState();
    _myOrdersBloc = BlocProvider.of<MyOrdersBloc>(context);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (offset < totalPages - 1) {
          offset++;
          loadingNextPage = true;
          _myOrdersBloc.add(GetDriversCODOrders(offset: offset, status: 'N'));
          print('Load Next Page');
        }
        print('Load Next Page');
      }
    });
    _myOrdersBloc.add(GetDriversCODOrders(offset: 0, status: 'N'));
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
      } else if (state is SetSelectedOrdersMarkAsPaidState) {
        Navigator.pop(context);
        if (state.orderDetailsResponse.status == true) {
          orderDetailsTemp!.clear();
          _myOrdersBloc.add(GetDriversCODOrders(offset: 0, status: 'N'));
        }
        Fluttertoast.showToast(
            msg: state.orderDetailsResponse.message,
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
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
            backgroundColor: kColorWidgetBackgroundColor,
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  color: kColorWidgetBackgroundColor,

                  ///This is the body
                  child: orderDetails != null
                      ? orderDetails!.isNotEmpty
                          ? Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      controller: _scrollController,
                                      child: Column(
                                        children: [
                                          Container(
                                            // color: Colors.red,
                                            width: screenSize.width,
                                            height: screenSize.height * 0.09,
                                            color: kColorWidgetBackgroundColor,
                                          ),
                                          Container(
                                            width: screenSize.width,
                                            // height: screenSize.height * 0.65,
                                            color: kColorWidgetBackgroundColor,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: orderDetails != null
                                                    ? orderDetails!.length
                                                    : 0,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: kColorWhite,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: kColorDarkGreyIcon
                                                                    .withOpacity(
                                                                        0.1),
                                                                spreadRadius: 1,
                                                                offset:
                                                                    const Offset(
                                                                        0, 3),
                                                              )
                                                            ]),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 5,
                                                                  bottom: 5,
                                                                  left: 5),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  PaytoAdminWidget(
                                                                    screenSize:
                                                                        screenSize,
                                                                    orderNumber:
                                                                        orderDetails![index]
                                                                            .OrderNumber,
                                                                    imageUrl: orderDetails![
                                                                            index]
                                                                        .productDetail[
                                                                            0]
                                                                        .Medium,
                                                                    price: orderDetails![index]
                                                                            .productDetail[
                                                                                0]
                                                                            .Currency +
                                                                        ' ' +
                                                                        (orderDetails![index].totalOrderPrice +
                                                                                orderDetails![index].totalOrderTax +
                                                                                orderDetails![index].totalOrderShippingPrice)
                                                                            .toStringAsFixed(2),
                                                                    quantity: orderDetails![
                                                                            index]
                                                                        .productDetail
                                                                        .length
                                                                        .toString(),
                                                                  ),
                                                                  Theme(
                                                                      data: ThemeData(
                                                                          unselectedWidgetColor: Colors
                                                                              .grey),
                                                                      child:
                                                                          Checkbox(
                                                                        value: orderDetails![index]
                                                                            .selectedForCheckout,
                                                                        onChanged:
                                                                            (state) {
                                                                          orderDetails![index].selectedForCheckout =
                                                                              state!;
                                                                          if (orderDetails![index]
                                                                              .selectedForCheckout) {
                                                                            /// UnCommment
                                                                            orderDetailsTemp!.add(orderDetails![index]);
                                                                            totalPriceToPay =
                                                                                totalPriceToPay + (orderDetails![index].totalOrderPrice + orderDetails![index].totalOrderTax + orderDetails![index].totalOrderShippingPrice);
                                                                            String
                                                                                cartTotalPrice =
                                                                                totalPriceToPay.toStringAsFixed(2);
                                                                            totalPriceToPay =
                                                                                double.parse(cartTotalPrice);

                                                                            ///UnComment
                                                                            // cartDetailsResponseTemp!.totalTax =
                                                                            //     cartDetailsResponseTemp!.totalTax + cartDetailsResponse!.productCartList[index].perProductTax!;
                                                                          } else {
                                                                            totalPriceToPay =
                                                                                totalPriceToPay - (orderDetails![index].totalOrderPrice + orderDetails![index].totalOrderTax + orderDetails![index].totalOrderShippingPrice);
                                                                            orderDetailsTemp!.remove(orderDetails![index]);

                                                                            ///Uncomment
                                                                            // cartDetailsResponseTemp!.totalTax =
                                                                            //     cartDetailsResponseTemp!.totalTax - cartDetailsResponse!.productCartList[index].perProductTax!;
                                                                          }

                                                                          totalPriceToPay =
                                                                              double.parse(totalPriceToPay.toStringAsFixed(2));
                                                                          //
                                                                          // cartDetailsResponseTemp!.totalTax = double.parse(cartDetailsResponseTemp!
                                                                          //     .totalTax
                                                                          //     .toStringAsFixed(2));
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        activeColor:
                                                                            kColorPrimary,
                                                                        checkColor:
                                                                            Colors.white,
                                                                        materialTapTargetSize:
                                                                            MaterialTapTargetSize.padded,
                                                                      )),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.3,
                                          ),
                                        ],
                                      )),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: screenSize.height * 0.78,
                                    ),
                                    // dakjsdkjasb
                                    Container(
                                      width: screenSize.width,
                                      height: screenSize.height * 0.22,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(30.0),
                                              topLeft: Radius.circular(30.0)),
                                          color: kColorWhite,
                                          boxShadow: [
                                            BoxShadow(
                                              color: kColorDarkGreyIcon
                                                  .withOpacity(0.2),
                                              spreadRadius: 1,
                                              offset: Offset(1, 0),
                                            )
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, top: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Total No. of Selected Orders',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  orderDetailsTemp!.length
                                                      .toString(),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Selected Orders Total',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    orderDetailsTemp!.isNotEmpty
                                                        ? Text(
                                                            orderDetailsTemp![0]
                                                                .productDetail[
                                                                    0]
                                                                .Currency,
                                                            //'${cartDetailsResponseTemp != null ? cartDetailsResponseTemp!.productCartList.length > 0 ? cartDetailsResponseTemp!.productCartList[0].Currency : '\$' : '\$'} ${cartDetailsResponseTemp != null ? (cartDetailsResponseTemp!.cartTotalPrice + cartDetailsResponseTemp!.totalTax).toStringAsFixed(2) : 0}',
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                color:
                                                                    kColorPrimary),
                                                          )
                                                        : SizedBox(),
                                                    Text(
                                                      ' ' +
                                                          totalPriceToPay
                                                              .toString(),
                                                      //'${cartDetailsResponseTemp != null ? cartDetailsResponseTemp!.productCartList.length > 0 ? cartDetailsResponseTemp!.productCartList[0].Currency : '\$' : '\$'} ${cartDetailsResponseTemp != null ? (cartDetailsResponseTemp!.cartTotalPrice + cartDetailsResponseTemp!.totalTax).toStringAsFixed(2) : 0}',
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: kColorPrimary),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 25),
                                            InkWell(
                                              onTap: () {
                                                if (orderDetailsTemp!
                                                    .isNotEmpty) {
                                                  cameraBottomNavigationSheet();
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Please select an order.',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.grey.shade400,
                                                      textColor: Colors.white,
                                                      fontSize: 12.0);
                                                }
                                              },
                                              child: Container(
                                                  height: 45,
                                                  width: screenSize.width,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: kColorPrimary,
                                                  ),
                                                  child: const Center(
                                                      child: Text(
                                                    'Mark as Paid',
                                                    style: TextStyle(
                                                        color: kColorWhite,
                                                        fontSize: 16),
                                                  ))),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/cart_empty_pic.png',
                                  scale: 3,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'No orders to pay',
                                  style: TextStyle(fontSize: 22),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14, color: kColorFieldsBorders),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     Navigator.of(context).pushAndRemoveUntil(
                                //         MaterialPageRoute(
                                //             builder: (context) => HomePage()),
                                //         (Route<dynamic> route) => false);
                                //   },
                                //   child: Container(
                                //     height: screenSize.height * 0.05,
                                //     width: screenSize.width * 0.43,
                                //     padding:
                                //         const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(10),
                                //       color: kColorPrimary,
                                //     ),
                                //     child: const Center(
                                //       child: Text(
                                //         'Continue Shopping',
                                //         maxLines: 1,
                                //         style: TextStyle(
                                //             color: kColorWhite, fontSize: 12),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            )
                      : const SizedBox(),
                ),
                Column(
                  children: [
                    Container(
                      color: kColorWidgetBackgroundColor,
                      width: screenSize.width,
                      height: screenSize.height * 0.042,
                    ),
                    Container(
                        color: kColorWidgetBackgroundColor,
                        width: screenSize.width,
                        height: screenSize.height * 0.09,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
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
                                    '  Pay to Admin',
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

  final ImagePicker _picker = ImagePicker();
  late XFile? image;
  void cameraBottomNavigationSheet() {
    showModalBottomSheet(
        elevation: 5,
        context: context,
        backgroundColor: kColorWidgetBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          var screenSize = MediaQuery.of(context).size;
          return Container(
            height: screenSize.height * 0.25,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      const Text(
                        'Add Proof Picture',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        BottomSheetFilterByWidget(
                          icon: Icons.add_a_photo,
                          buttonLabel: 'Take picture',
                          onPressed: () async {
                            // getImage(
                            //     picker.pickImage(source: ImageSource.camera));
                            image = await _picker.pickImage(
                                source: ImageSource.camera);
                            if (image != null) {
                              _myOrdersBloc.add(SetSelectedOrdersMarkAsPaid(
                                  selectedOrders: orderDetailsTemp!,
                                  selectedImage: image!));
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Upload of Proof Image is compulsory',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey.shade400,
                                  textColor: Colors.white,
                                  fontSize: 12.0);
                            }
                          },
                        ),
                        BottomSheetFilterByWidget(
                          icon: Icons.add_photo_alternate,
                          buttonLabel: 'Browse gallery',
                          onPressed: () async {
                            image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              _myOrdersBloc.add(SetSelectedOrdersMarkAsPaid(
                                  selectedOrders: orderDetailsTemp!,
                                  selectedImage: image!));
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Upload of Proof Image is compulsory',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey.shade400,
                                  textColor: Colors.white,
                                  fontSize: 12.0);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

import 'dart:io';

import 'package:bangla_bazar/ModelClasses/BangladeshPaymentUserData.dart';
import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_price_calculation_response.dart';
import 'package:bangla_bazar/ModelClasses/payment_user_data.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/Cart/CartBloc/cart_bloc.dart';
import 'package:bangla_bazar/Views/Cart/bangladesh_order_placed.dart';
import 'package:bangla_bazar/Views/Cart/order_placed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SSLPaymentWebView extends StatefulWidget {
  final String linkUrl;
  final String orderNumber;
  CartDetailsResponse cartDetailsResponse;
  BangladeshPaymentUserData? bangladeshPaymentUserData;
  int selectedCountryId;
  bool productsAndUserCitiesAreSame;
  PathaoPriceCalculationResponse? pathaoPriceCalculationResponse;
  SSLPaymentWebView(
      {Key? key,
      required this.linkUrl,
      required this.cartDetailsResponse,
      required this.orderNumber,
      required this.bangladeshPaymentUserData,
      required this.selectedCountryId,
      required this.productsAndUserCitiesAreSame,
      required this.pathaoPriceCalculationResponse})
      : super(key: key);

  @override
  SSLPaymentWebViewState createState() => SSLPaymentWebViewState();
}

class SSLPaymentWebViewState extends State<SSLPaymentWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  late CartBloc _cartBloc;
  @override
  void initState() {
    super.initState();
    _cartBloc = BlocProvider.of<CartBloc>(context);

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: kColorPrimary,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is ErrorState) {
        Navigator.pop(context);
        Navigator.pop(context);
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
              appBar: AppBar(
                title: const Text("Bangla Bazar Payment"),
                backgroundColor: kColorPrimary,
              ),
              body: SafeArea(
                  child: Column(children: <Widget>[
                // TextField(
                //   // decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                //   controller: urlController,
                //   readOnly: true,
                //   keyboardType: TextInputType.url,
                //   onSubmitted: (value) {
                //     var url = Uri.parse(value);
                //     if (url.scheme.isEmpty) {
                //       url = Uri.parse("https://www.google.com/search?q=" + value);
                //     }
                //     webViewController?.loadUrl(urlRequest: URLRequest(url: url));
                //   },
                // ),
                Expanded(
                  child: Stack(
                    children: [
                      InAppWebView(
                        key: webViewKey,
                        initialUrlRequest:
                            URLRequest(url: Uri.parse(widget.linkUrl)),
                        initialOptions: options,
                        pullToRefreshController: pullToRefreshController,
                        onWebViewCreated: (controller) {
                          webViewController = controller;
                        },
                        onLoadStart: (controller, url) {
                          setState(() {
                            this.url = url.toString();
                            urlController.text = this.url;
                            print('onLoadStart');
                            print(url);
                          });
                        },
                        androidOnPermissionRequest:
                            (controller, origin, resources) async {
                          return PermissionRequestResponse(
                              resources: resources,
                              action: PermissionRequestResponseAction.GRANT);
                        },
                        shouldOverrideUrlLoading:
                            (controller, navigationAction) async {
                          var uri = navigationAction.request.url!;

                          // if (![
                          //   "http",
                          //   "https",
                          //   "file",
                          //   "chrome",
                          //   "data",
                          //   "javascript",
                          //   "about"
                          // ].contains(uri.scheme)) {
                          //   if (await canLaunch(url)) {
                          //     // Launch the App
                          //     await launch(
                          //       url,
                          //     );
                          //     // and cancel the request
                          //     return NavigationActionPolicy.CANCEL;
                          //   }
                          // }

                          return NavigationActionPolicy.ALLOW;
                        },
                        onLoadStop: (controller, url) async {
                          pullToRefreshController.endRefreshing();
                          print('>>>>>>>>>>onLoadStop');
                          //print(urlController.text);
                          var uri = Uri.parse(this.url);
                          print(uri.toString());
                          //print(uri.query);
                          print(uri.queryParameters['status']);
                          if (uri.queryParameters['status'] == 'success') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BangladeshOrderPlaced(
                                        orderNumber: widget.orderNumber,
                                        cartDetailsResponse:
                                            widget.cartDetailsResponse,
                                        paymentStatus: 'Paid',
                                        bangladeshPaymentUserData:
                                            widget.bangladeshPaymentUserData,
                                        selectedCountryId:
                                            widget.selectedCountryId,
                                        productsAndUserCitiesAreSame:
                                            widget.productsAndUserCitiesAreSame,
                                        paymentTypeCOD: 'card',
                                        pathaoPriceCalculationResponse: widget
                                            .pathaoPriceCalculationResponse,
                                      )),
                            );
                          } else if (uri.queryParameters['status'] ==
                              'cancel') {
                            _cartBloc.add(UpdatePaymentStatus(
                                id: widget.orderNumber, status: 'cancel'));
                          } else if (uri.queryParameters['tran_type'] ==
                              'Failed') {
                            _cartBloc.add(UpdatePaymentStatus(
                                id: widget.orderNumber, status: 'failed'));
                          }
                          setState(() {
                            this.url = url.toString();
                            urlController.text = this.url;
                          });
                        },
                        onLoadError: (controller, url, code, message) {
                          pullToRefreshController.endRefreshing();
                          print('onLoadError');
                          print(message);
                        },
                        onProgressChanged: (controller, progress) {
                          if (progress == 100) {
                            pullToRefreshController.endRefreshing();
                          }
                          setState(() {
                            this.progress = progress / 100;
                            urlController.text = url;
                          });
                        },
                        onUpdateVisitedHistory:
                            (controller, url, androidIsReload) {
                          setState(() {
                            this.url = url.toString();
                            urlController.text = this.url;
                          });
                        },
                        onConsoleMessage: (controller, consoleMessage) {
                          print(consoleMessage);
                        },
                      ),
                      progress < 1.0
                          ? LinearProgressIndicator(value: progress)
                          : Container(),
                    ],
                  ),
                ),
                // ButtonBar(
                //   alignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     ElevatedButton(
                //       child: Icon(Icons.arrow_back),
                //       onPressed: () {
                //         webViewController?.goBack();
                //       },
                //     ),
                //     ElevatedButton(
                //       child: Icon(Icons.arrow_forward),
                //       onPressed: () {
                //         webViewController?.goForward();
                //       },
                //     ),
                //     ElevatedButton(
                //       child: Icon(Icons.refresh),
                //       onPressed: () {
                //         webViewController?.reload();
                //       },
                //     ),
                //   ],
                // ),
              ]))),
        ),
      );
    });
  }

  Future<bool> _onBackPressed() {
    _cartBloc
        .add(UpdatePaymentStatus(id: widget.orderNumber, status: 'cancel'));
    print('back button pressed');
    return Future.value(false);
  }
}

import 'package:bangla_bazar/ModelClasses/BangladeshPaymentUserData.dart';
import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_price_calculation_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentScreen extends StatefulWidget {
  CartDetailsResponse cartDetailsResponse;

  bool productsAndUserCitiesAreSame;
  bool creditCardPayment;

  PathaoPriceCalculationResponse? pathaoPriceCalculationResponse;
  StripePaymentScreen(
      {Key? key,
      required this.cartDetailsResponse,
      required this.productsAndUserCitiesAreSame,
      required this.creditCardPayment,
      required this.pathaoPriceCalculationResponse})
      : super(key: key);

  @override
  _StripePaymentScreenState createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  Map<String, dynamic>? paymentIntentData;
  @override
  void initState() {
    super.initState();
    initializePayment();
  }

  initializePayment() async {
    await makePayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent(
          (widget.cartDetailsResponse.cartTotalPrice +
                  widget.cartDetailsResponse.totalTax)
              .toStringAsFixed(0),
          'USD'); //json.decode(response.body);
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
            .showSnackBar(SnackBar(content: Text("paid successfully")));

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

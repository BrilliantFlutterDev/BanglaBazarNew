import 'dart:io';

import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginBloc/login_bloc.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginscreen.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/sign_up_screen.dart';
import 'package:bangla_bazar/Views/Cart/CartBloc/cart_bloc.dart';
import 'package:bangla_bazar/Views/DeliveryViews/delivery_registration_screen1.dart';
import 'package:bangla_bazar/Views/MyOrders/MyOrdersBloc/myorder_bloc.dart';
import 'package:bangla_bazar/Views/MyOrders/order_details_screen.dart';
import 'package:bangla_bazar/Views/Notification/NotificationsBloc/notification_bloc.dart';

import 'package:bangla_bazar/Views/Product/ProductBloc/product_bloc.dart';
import 'package:bangla_bazar/Views/main_home_page.dart';

import 'package:bangla_bazar/Views/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

///Receive the message when the app is in the background
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

///Local Notifications Setup
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

///Local Notifications Setup

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51KxsHCDLQAZcqA2uRhwnlGxYux8WU6qhmwzAYhIyH81QEEbY4mPEUkXGNBzLE6NidCwVsbG7mDfFYI1ilmLcflMd00OfParwzr";
  Stripe.instance.applySettings();

  ///Local Notifications Setup
  var initializationSettingsAndroid =
      AndroidInitializationSettings('launcher_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int? id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  ///Local Notifications Setup
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  runApp(const MyApp());
}

final GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
void getDeviceId() async {
  ///Local Notifications Setup
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('launcher_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  ///Local Notifications Setup
  await Firebase.initializeApp();
  var deviceId = await FirebaseMessaging.instance.getToken();
  print("Device id:$deviceId");
  AppGlobal.deviceToken = deviceId!;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;
  var routeMessage;
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      var deviceId = await FirebaseMessaging.instance.getToken();
      print("Device id:$deviceId");
      AppGlobal.deviceToken = deviceId!;

      ///gives you the message on which user taps
      ///and it opened the app from terminated state
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          print('App is intialized');

          // print("OrderNumber: ${message.data["OrderNumber"]}");
          // print("time: ${message.data["time"]}");
          // print("channel_id: ${message.data["channel_id"]}");
          // print("TypeID: ${message.data["TypeID"]}");
          // routeMessage = message.data["TypeID"];
          // AppGlobal.notificationId = message.data["OrderNumber"];

          // if (routeMessage == '6') {
          //   routeMessage = '/orderPlaced';
          // } else {
          //   routeMessage = '/loginPage';
          // }
          // print("|||||||||||");
          // if (AppGlobal.userID != -1) {
          //   navigatorKey!.currentState!.pushReplacementNamed(routeMessage);
          // } else {
          //   navigatorKey!.currentState!.pushReplacementNamed('/loginPage');
          // }
        }
      });

      ///foreground Message only
      FirebaseMessaging.onMessage.listen((message) {
        if (message.notification != null) {
          print('App is in foreground');
          // print(message);
          print(message.notification!.title);
          print(message.notification!.body);
          print("id: ${message.data["id"]}");
          print("time: ${message.data["time"]}");
          print("channel_id: ${message.data["channel_id"]}");
          print("TypeID: ${message.data["TypeID"]}");

          routeMessage = message.data["TypeID"];

          if (routeMessage == '6') {
            routeMessage = '/orderPlaced';
            AppGlobal.notificationId = message.data["id"];
          } else if (routeMessage == '5') {
            if (message.data["id"] != 'null') {
              routeMessage = '/driverRegistrationScreen';
              AppGlobal.deliveryDriverID = int.parse(message.data["id"]);
            } else {
              routeMessage = '/notificationScreen';
            }
          } else {
            routeMessage = '/loginPage';
          }
          showNotification(message.data, flutterLocalNotificationsPlugin,
              message.notification!);
          //print(message.notification);
        }
      });

      ///when the app is in the background but opened and user taps
      ///on the notification
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print('App is minimized');
        print(message.notification!.title);
        print(message.notification!.body);
        print("id: ${message.data["id"]}");
        print("time: ${message.data["time"]}");
        print("channel_id: ${message.data["channel_id"]}");
        print("TypeID: ${message.data["TypeID"]}");
        routeMessage = message.data["TypeID"];

        if (routeMessage == '6') {
          routeMessage = '/orderPlaced';
          AppGlobal.notificationId = message.data["id"];
        } else if (routeMessage == '5') {
          if (message.data["id"] != 'null') {
            routeMessage = '/driverRegistrationScreen';
            AppGlobal.deliveryDriverID = int.parse(message.data["id"]);
          } else {
            routeMessage = '/notificationScreen';
          }
        } else {
          routeMessage = '/loginPage';
        }

        // navigatorKey.currentState.pushNamed(routeMessage);
        if (AppGlobal.userID != -1) {
          navigatorKey!.currentState!.pushReplacementNamed(routeMessage);
        } else {
          navigatorKey!.currentState!.pushReplacementNamed('/loginPage');
        }
      });

      _initialized = true;
      print('Firebase Initialized');
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  static Future<void> showNotification(
      Map<String, dynamic> message,
      FlutterLocalNotificationsPlugin fln,
      RemoteNotification notification) async {
    await showTextNotification(message, fln, notification);
  }

  static Future<void> showTextNotification(
      Map<String, dynamic> message,
      FlutterLocalNotificationsPlugin fln,
      RemoteNotification notification) async {
    //AppGlobal.notificationId = int.parse(message["id"]);
    //print("AppGlobal.notificationId: ${AppGlobal.notificationId}");

    String? _title = notification.title;
    String? _body = notification.body;
    print('????????????$_title');
    print('????????????$_body');
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'default_notification_channel_id',
      'your channel name',
      largeIcon: DrawableResourceAndroidBitmap('launcher_icon'),
      importance: Importance.max,
      priority: Priority.high,
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await fln.show(
      0,
      _title,
      _body,
      platformChannelSpecifics,
      payload: 'HEloo',
    );
  }

  @override
  void initState() {
    initializeFlutterFire();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOs = const IOSInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    // flutterLocalNotificationsPlugin.initialize(
    //   initSettings,
    // );
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
        print('Clicked');
        print(payload);
        print(routeMessage);
        if (AppGlobal.userID != -1) {
          navigatorKey!.currentState!.pushReplacementNamed(routeMessage);
        } else {
          navigatorKey!.currentState!.pushReplacementNamed('/loginPage');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<NotificationBloc>(
          create: (context) => NotificationBloc(),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<MyOrdersBloc>(
          create: (context) => MyOrdersBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Bangla Bazar',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.green,
          fontFamily: 'Circular',
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/splash",
        routes: <String, WidgetBuilder>{
          '/splash': (BuildContext context) => const SplashScreen(),
          '/loginPage': (BuildContext context) => const LoginScreen(),
          '/signupPage': (BuildContext context) => SignupScreen(),
          '/orderPlaced': (BuildContext context) => OrderDetails(
              previousPage: 'UserMyOrders',
              orderNumber: AppGlobal.notificationId.toString()),
          '/accountScreen': (BuildContext context) => HomePage(
                currentTab: 3,
              ),
          '/notificationScreen': (BuildContext context) => HomePage(
                currentTab: 1,
              ),
          '/driverRegistrationScreen': (BuildContext context) =>
              const DeliveryRegistrationScreen1(),
        },
      ),
    );
  }

  void selectNotification(String payload) async {
    print('Clicked');
    print(payload);
    print(routeMessage);
    if (AppGlobal.userID != -1) {
      navigatorKey!.currentState!.pushReplacementNamed(routeMessage);
    } else {
      navigatorKey!.currentState!.pushReplacementNamed('/loginPage');
    }
  }

  // Future onSelectNotification(String? payload) async {
  //   print('Clicked');
  //   print(payload);
  //   print(routeMessage);
  //   if (AppGlobal.userID != -1) {
  //     navigatorKey!.currentState!.pushReplacementNamed(routeMessage);
  //   } else {
  //     navigatorKey!.currentState!.pushReplacementNamed('/loginPage');
  //   }
  // }
}

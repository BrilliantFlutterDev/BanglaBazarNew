import 'dart:convert';
import 'dart:io';

import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> checkInternetConnectivity() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return true;
    }
  } on SocketException catch (_) {
    print('not connected');
    return false;
  }
  return null;
}

dynamic getUserData() async {
  FlutterSecureStorage storage = FlutterSecureStorage();
  var rememberMe = await storage.read(key: 'rememberMe');
  if (rememberMe == 'true') {
    var rememberMeEmail = await storage.read(key: 'emailAddress');
    var rememberMePassword = await storage.read(key: 'pass');
    AppGlobal.rememberMeEmail = rememberMeEmail.toString();
    AppGlobal.rememberMePassword = rememberMePassword.toString();
  }
  // print(jsonEncode('RememberMe:$rememberMe'));
  // print(jsonEncode('RememberMe Email:${AppGlobal.rememberMeEmail}'));
  // print(jsonEncode('RememberMe Password:${AppGlobal.rememberMePassword}'));
  if (rememberMe != null) {
    return rememberMe;
  } else {
    return null;
  }
}

showSnack(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

flutterToast(BuildContext context, String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade400,
      textColor: Colors.white,
      fontSize: 12.0);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

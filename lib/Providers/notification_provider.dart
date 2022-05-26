import 'dart:collection';
import 'dart:io';

import 'package:bangla_bazar/Providers/base_provider.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/web_services.dart';

class NotificationProvider extends BaseProvider {
  static Future login({
    required String username,
    required String password,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}user/login';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('EmailAddress', () => username.toString());
      params.putIfAbsent('Password', () => password.toString());

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

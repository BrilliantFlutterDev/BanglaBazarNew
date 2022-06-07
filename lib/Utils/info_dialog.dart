import 'package:flutter/material.dart';

import 'app_colors.dart';

class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Center(
                child: Column(
              children: [
                Image.asset(
                  'assets/images/warning.png',
                  scale: 4,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            )),
            content: Text(
              message,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Center(
                child: FlatButton(
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: kColorPrimary,
                    onPressed: () => Navigator.pop(context)),
              )
            ],
          );
        });
  }
}

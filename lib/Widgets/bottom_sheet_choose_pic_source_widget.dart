import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:flutter/material.dart';

class BottomSheetFilterByWidget extends StatelessWidget {
  var icon;
  String buttonLabel;
  var onPressed;
  var bgcolor;

  BottomSheetFilterByWidget({
    Key? key,
    this.onPressed,
    required this.buttonLabel,
    this.icon,
    this.bgcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      buttonLabel,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}

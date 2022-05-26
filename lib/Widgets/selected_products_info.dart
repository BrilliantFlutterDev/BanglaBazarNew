import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SelectedProductsInfoWidget extends StatelessWidget {
  const SelectedProductsInfoWidget({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: screenSize.height * 0.12,
              width: screenSize.width * 0.30,
              decoration: const BoxDecoration(
                color: kColorWidgetBackgroundColor,
                // border: Border.all(
                //     color: kColorWidgetBackgroundColor, // Set border color
                //     width: 0.0),   // Set border width
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)), // Set rounded corner radius
                // Make rounded corner of border
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'White Valise',
                  style: TextStyle(fontSize: 14, color: kColorDarkGreyText),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Color:  ',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Grey ',
                          style: TextStyle(
                              fontSize: 12, color: kColorFieldsBorders),
                        ),
                        Text(
                          ' x 01',
                          style: TextStyle(fontSize: 12, color: kColorBlueText),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '\$40.00',
                  style: TextStyle(fontSize: 18, color: kColorOrangeText),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 1,
          width: screenSize.width,
          color: kColorFieldsBorders,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

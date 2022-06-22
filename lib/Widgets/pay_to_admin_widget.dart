import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PaytoAdminWidget extends StatelessWidget {
  PaytoAdminWidget(
      {Key? key,
      required this.screenSize,
      required this.orderNumber,
      required this.price,
      required this.quantity,
      required this.imageUrl})
      : super(key: key);

  final Size screenSize;
  final String orderNumber;
  final String price;
  final String quantity;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: screenSize.height * 0.14,
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
              child: CachedNetworkImage(
                imageUrl:
                    AppGlobal.photosBaseURL + imageUrl.replaceAll('\\', '/'),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      color: kColorPrimary, value: downloadProgress.progress),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: screenSize.height * 0.14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Order Number: $orderNumber',
                    style: const TextStyle(
                        fontSize: 14,
                        color: kColorBlueText,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Quantity',
                    style: const TextStyle(
                        fontSize: 14, color: kColorDarkGreyText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

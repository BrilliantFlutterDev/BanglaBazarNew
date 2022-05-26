import 'package:bangla_bazar/ModelClasses/store_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  double? avgRating;
  int? reviewCount;
  String? inWishList;
  var onDislikePress;
  ProductWidget(
      {Key? key,
      required this.screenSize,
      required this.product,
      this.avgRating,
      this.reviewCount,
      this.inWishList,
      this.onDislikePress})
      : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: screenSize.height * 0.20,
              width: screenSize.width * 0.37,
              decoration: const BoxDecoration(
                  //color: kColorWidgetBackgroundColor,
                  // border: Border.all(
                  //     color: kColorWidgetBackgroundColor, // Set border color
                  //     width: 0.0),   // Set border width
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),

                  /// use image show here
                  // image: DecorationImage(
                  //   image:
                  //       NetworkImage('${AppGlobal.photosBaseURL}${product.medium}'),
                  //   fit: BoxFit.cover,
                  // ),
                  color: kColorWidgetBackgroundColor
                  // Set rounded corner radius
                  // Make rounded corner of border
                  ),
              child: CachedNetworkImage(
                imageUrl: AppGlobal.photosBaseURL +
                    product.medium.replaceAll('\\', '/'),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      color: kColorPrimary, value: downloadProgress.progress),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            inWishList == 'true'
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: onDislikePress,
                        child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: kColorPrimary,
                              // border: Border.all(
                              //     color: kColorDarkGreyText, width: 3),
                              // image: DecorationImage(
                              //   image: Image.asset("assets/icons/eyeicon.png",),
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            child: const Icon(
                              MyFlutterApp.heart_icon,
                              color: kColorWhite,
                              size: 15,
                            )),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        Container(
          height: screenSize.height * 0.15,
          width: screenSize.width * 0.37,
          decoration: const BoxDecoration(
              //color: kColorWidgetBackgroundColor,
              // border: Border.all(
              //     color: kColorWidgetBackgroundColor, // Set border color
              //     width: 0.0),   // Set border width
              // borderRadius: BorderRadius.all(
              //     Radius.circular(
              //         10.0)), // Set rounded corner radius
              // Make rounded corner of border
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                product.title != '' ? product.title : 'Product name',
                style: const TextStyle(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: avgRating!,
                    minRating: 1,
                    ignoreGestures: true,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 12,
                    itemCount: 5,
                    //itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '(${reviewCount.toString()} Reviews)',
                    style: const TextStyle(
                        fontSize: 12, color: kColorFieldsBorders),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    '${product.currency} ${product.price}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Text(
                  //   '\$49.00',
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     color: kColorFieldsBorders,
                  //     decoration: TextDecoration.lineThrough,
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

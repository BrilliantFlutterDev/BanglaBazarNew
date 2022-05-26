import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyCartProductWidget extends StatelessWidget {
  MyCartProductWidget(
      {Key? key,
      required this.screenSize,
      required this.productCartList,
      required this.onDeletePress,
      required this.onPlusButtonPress,
      required this.onMinusButtonPress})
      : super(key: key);

  final Size screenSize;
  ProductCartList productCartList;
  var onDeletePress;
  var onPlusButtonPress;
  var onMinusButtonPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
                    imageUrl: AppGlobal.photosBaseURL +
                        productCartList.Medium!.replaceAll('\\', '/'),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          color: kColorPrimary,
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productCartList.Title!,
                      style: const TextStyle(
                          fontSize: 14, color: kColorDarkGreyText),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          ignoreGestures: true,
                          itemSize: 14,
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
                          '( ${productCartList.REVIEWCOUNT} )',
                          style: const TextStyle(
                              fontSize: 12, color: kColorFieldsBorders),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppGlobal.userID != -1
                        ? Container(
                            width: screenSize.width * 0.35,
                            height: 15,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    productCartList.productCombinations.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${productCartList.productCombinations[index].OptionName}:  ',
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          productCartList
                                              .productCombinations[index]
                                              .OptionValue,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: kColorFieldsBorders),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        AppGlobal.userID != -1
                            ? InkWell(
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kColorDarkGreyText.withOpacity(0.2),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                          color: kColorPrimary, fontSize: 15),
                                    ),
                                  ),
                                ),
                                onTap: onMinusButtonPress,
                              )
                            : const Text(
                                ' Quantity ',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          ' ${productCartList.TotalQuantity} ',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        AppGlobal.userID != -1
                            ? InkWell(
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kColorDarkGreyText.withOpacity(0.2),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: kColorPrimary,
                                    size: 10,
                                  ),
                                ),
                                onTap: onPlusButtonPress,
                              )
                            : const SizedBox(),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${productCartList.Currency} ${productCartList.calculateTotalProductPrice}',
                  style: const TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.09,
                    ),
                    InkWell(
                      onTap: onDeletePress,
                      child: Icon(
                        MyFlutterApp.delete,
                        color: Colors.red.shade900,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 1,
          width: screenSize.width,
          color: kColorFieldsBorders,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SelectedProductsInfoWidget extends StatelessWidget {
  ProductCartList productCartList;
  SelectedProductsInfoWidget(
      {Key? key, required this.screenSize, required this.productCartList})
      : super(key: key);

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
              child: CachedNetworkImage(
                imageUrl: AppGlobal.photosBaseURL +
                    productCartList.Medium!.replaceAll('\\', '/'),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productCartList.Title!,
                  style:
                      const TextStyle(fontSize: 14, color: kColorDarkGreyText),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
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
                                        index ==
                                                productCartList
                                                        .productCombinations
                                                        .length -
                                                    1
                                            ? Text(
                                                ' x ${productCartList.TotalQuantity}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: kColorBlueText),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  productCartList.Currency! +
                      " " +
                      productCartList.calculateTotalProductPrice!.toString(),
                  style: const TextStyle(fontSize: 18, color: kColorOrangeText),
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

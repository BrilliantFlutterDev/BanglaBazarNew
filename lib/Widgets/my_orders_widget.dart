import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bangla_bazar/ModelClasses/order_details_response.dart';

class MyOrdersWidget extends StatelessWidget {
  var onPressOrderDetails;
  MyOrdersWidget(
      {Key? key,
      required this.screenSize,
      required this.onPressOrderDetails,
      required this.productDetail})
      : super(key: key);

  final Size screenSize;
  ProductDetail productDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 20.0),
                  blurRadius: 50.0,
                  spreadRadius: 0.5,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: kColorWhite),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 13),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.23,
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
                            productDetail.Medium.replaceAll('\\', '/'),
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
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productDetail.Title,
                          style: TextStyle(
                              fontSize: 12, color: kColorDarkGreyText),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Price: ${productDetail.Currency} ${productDetail.totalProductPrice}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenSize.width * 0.55,
                          height: 13,
                          child: ListView.builder(
                              //shrinkWrap: true,
                              //physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  productDetail.productCombinations.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int j) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${productDetail.productCombinations[j].OptionName}:  ',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${productDetail.productCombinations[j].OptionValue} ',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: kColorFieldsBorders),
                                          ),
                                          Text(
                                            ' x 01',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: kColorBlueText),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        //Navigator.pop(context);
                      },
                      child: Container(
                        height: screenSize.height * 0.05,
                        width: screenSize.width * 0.38,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kColorFieldsBorders),
                          color: kColorWhite,
                        ),
                        child: const Center(
                          child: Text(
                            'Cancel',
                            maxLines: 1,
                            style: TextStyle(
                                color: kColorDarkGreyText, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onPressOrderDetails,
                      child: Container(
                        height: screenSize.height * 0.05,
                        width: screenSize.width * 0.38,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kColorWidgetBackgroundColor,
                        ),
                        child: Center(
                          child: Text(
                            'View Order',
                            maxLines: 1,
                            style:
                                TextStyle(color: kColorPrimary, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}

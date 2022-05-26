import 'package:bangla_bazar/ModelClasses/store_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SubCategoryProductWidget extends StatefulWidget {
  final Product product;
  final String productPic;
  final double rating;
  const SubCategoryProductWidget({
    Key? key,
    required this.screenSize,
    required this.product,
    required this.productPic,
    required this.rating,
  }) : super(key: key);

  final Size screenSize;

  @override
  State<SubCategoryProductWidget> createState() =>
      _SubCategoryProductWidgetState();
}

class _SubCategoryProductWidgetState extends State<SubCategoryProductWidget> {
  @override
  void initState() {
    super.initState();
    print(
        AppGlobal.photosBaseURL + widget.product.medium.replaceAll('\\', '/'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.screenSize.height * 0.10,
          width: widget.screenSize.width * 0.22,
          decoration: BoxDecoration(
            color: kColorWidgetBackgroundColor,
            // border: Border.all(
            //     color: kColorWidgetBackgroundColor, // Set border color
            //     width: 0.0),   // Set border width
            borderRadius: BorderRadius.all(Radius.circular(10.0)),

            // image: DecorationImage(
            //   image:
            //       NetworkImage('${AppGlobal.photosBaseURL}${product.medium}'),
            //   fit: BoxFit.cover,
            // ),
            // Set rounded corner radius
            // Make rounded corner of border
          ),
          child: CachedNetworkImage(
            height: widget.screenSize.height * 0.08,
            width: widget.screenSize.width * 0.18,
            imageUrl: AppGlobal.photosBaseURL +
                widget.productPic.replaceAll('\\', '/'),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        color: kColorPrimary,
                        value: downloadProgress.progress)),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        Container(
          height: widget.screenSize.height * 0.09,
          width: widget.screenSize.width * 0.22,
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
                widget.product.title,
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: widget.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemSize: 07,
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
                    width: 3,
                  ),
                  Text(
                    '(0 Reviews)',
                    style: TextStyle(fontSize: 7, color: kColorFieldsBorders),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    '${widget.product.currency} ${widget.product.price}',
                    style: TextStyle(fontSize: 10),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:bangla_bazar/ModelClasses/product_details_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Widgets/photo_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductUserReviewWidget extends StatelessWidget {
  final UsersProductReviewAndRating usersProductReviewAndRating;
  const ProductUserReviewWidget({
    Key? key,
    required this.screenSize,
    required this.usersProductReviewAndRating,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kColorDarkGreyText.withOpacity(0.2),
                  // border: Border.all(
                  //     color: kColorOrangeText, width: 2),
                  // image: DecorationImage(
                  //   image: Image.asset("assets/icons/eyeicon.png",),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: PhotoAvatar(
                  photoLink:
                      '${AppGlobal.photosBaseURL}${usersProductReviewAndRating.ProfilePic!.replaceAll('\\', '/')}',
                )),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  usersProductReviewAndRating.UserName,
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  usersProductReviewAndRating.LastUpdate,
                  style: TextStyle(fontSize: 10, color: kColorDarkGreyText),
                ),
                const SizedBox(
                  height: 5,
                ),
                RatingBar.builder(
                  initialRating: double.parse(
                      usersProductReviewAndRating.Rating.toString()),
                  minRating: 1,
                  ignoreGestures: true,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemSize: 14,
                  itemCount: 5,
                  //itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: screenSize.width * 0.7,
                  child: Text(
                    usersProductReviewAndRating.Review,
                    style: TextStyle(fontSize: 10, color: kColorDarkGreyText),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Divider(
          color: kColorDarkGreyText,
          height: 1,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

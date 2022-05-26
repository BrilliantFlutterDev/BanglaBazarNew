import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationWidget extends StatelessWidget {
  final String profilePic;
  final String message;
  final String time;
  String? orderNumber;
  final String readStatus;
  NotificationWidget({
    Key? key,
    required this.screenSize,
    required this.profilePic,
    required this.message,
    required this.time,
    this.orderNumber,
    required this.readStatus,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: screenSize.width,
          height: screenSize.height * 0.11,

          /// change background color
          color: kColorWhite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  child: CachedNetworkImage(
                    imageUrl: AppGlobal.photosBaseURL + profilePic,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          color: kColorWhite, value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      MyFlutterApp.account_fill,
                      size: 35,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  width: screenSize.width * 0.50,
                  height: screenSize.height * 0.11,
                  color: kColorWhite,
                  child: Center(
                    child: Text(
                      '${message} ${orderNumber == null ? '' : 'with order number : ${orderNumber}'}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: kColorDarkGreyText, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                          color: kColorDarkGreyText, fontSize: 12),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            readStatus == 'unread' ? Colors.blue : Colors.white,
                        // border: Border.all(
                        //     color: kColorDarkGreyText, width: 3),
                        // image: DecorationImage(
                        //   image: Image.asset("assets/icons/eyeicon.png",),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}

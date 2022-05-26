import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:flutter/material.dart';

class SenderMessageWidget extends StatelessWidget {
  SenderMessageWidget({
    Key? key,
    required this.messageText,
    required this.messageTime,
    required this.screenSize,
  }) : super(key: key);
  final String messageText;
  final String messageTime;
  var screenSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: kColorWhite,
                      border: Border.all(color: kColorWidgetBackgroundColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        messageText,
                        maxLines: 100,
                        //overflow: TextOverflow.ellipsis,
                        //style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   '$messageText',
                      //   style: TextStyle(color: kColorBackground, fontSize: 7),
                      // ),
                      Text(
                        messageTime,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:flutter/material.dart';

class ReceiverMessageWidget extends StatelessWidget {
  const ReceiverMessageWidget({
    Key? key,
    required this.messageText,
    required this.messageTime,
  }) : super(key: key);
  final String messageText;
  final String messageTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                color: kColorPrimary,
                border: Border.all(color: kColorWidgetBackgroundColor),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  messageText,
                  style: TextStyle(color: kColorWidgetBackgroundColor),
                ),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Row(
              children: [
                Text(
                  messageTime,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(
                  width: 3,
                ),
                // Icon(
                //   Icons.where_to_vote,
                //   size: 15,
                //   color: kColorPrimary,
                // )
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ],
    );
  }
}

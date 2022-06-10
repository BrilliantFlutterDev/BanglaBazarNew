import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Views/Chat/personal_chat_screen.dart';
import 'package:flutter/material.dart';

class PersonIdentifierWidget extends StatefulWidget {
  PersonIdentifierWidget({
    Key? key,
    required this.screenSize,
    required this.pPhoto,
    required this.pName,
    required this.userId,
    this.onPressed,
    this.documnetIndex,
    this.followingFollowers,
    required this.time,
    this.roomId,
  }) : super(key: key);

  final Size screenSize;
  final String? roomId;
  final String pPhoto;
  final String pName;
  final String time;
  final int userId;
  int? documnetIndex;
  bool? followingFollowers;
  var onPressed;

  @override
  _PersonIdentifierWidgetState createState() => _PersonIdentifierWidgetState();
}

class _PersonIdentifierWidgetState extends State<PersonIdentifierWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            widget.followingFollowers == false
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatPersonalScreen(
                        senderName: widget.pName,
                        receiverUserId: widget.userId,
                        documnetIndex: widget.documnetIndex,
                        roomId: widget.roomId,
                      ),
                    ),
                  )
                : '';
          },
          splashColor: kColorPrimary,
          child: Container(
            color: kColorWhite,
            width: widget.screenSize.width,
            height: widget.screenSize.height * 0.125,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            '${AppGlobal.photosBaseURL}${widget.pPhoto != '' ? widget.pPhoto.replaceAll('\\', '/') : ''}'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.pName,
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.time,
                        style: const TextStyle(color: kColorFieldsBorders),
                      ),
                    ],
                  )
                ],
              ),
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

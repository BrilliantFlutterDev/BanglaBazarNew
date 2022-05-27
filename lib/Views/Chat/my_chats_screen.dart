import 'dart:io';

import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Views/Chat/personal_chat_screen.dart';
import 'package:bangla_bazar/Widgets/chat_personal_identifier_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kColorWidgetBackgroundColor,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kColorWhite,
        foregroundColor: Colors.black,
        title: const Text(
          'My Chats',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: fireStore
                .collection('Users')
                .orderBy("time_stamp", descending: true)
                .snapshots(),
            builder: (context, snapshots) {
              if (!snapshots.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: kColorPrimary,
                  ),
                );
              }
              final messagePersons = snapshots.data!.docs;
              List<PersonIdentifierWidget> messagePersonsWidgets = [];
              int documnetIndex = 0;
              for (var contact in messagePersons) {
                final receiverId = contact["receiver_id"];
                final senderId = contact["sender_id"];
                final receiverName = contact["receiver_name"];
                final senderName = contact["sender_name"];
                final receiverUrl = contact["receiver_url"];
                final senderUrl = contact["sender_url"];
                final DateTime dateTime = contact["time_stamp"].toDate();
                //print(dateTime);
                // 12/31/2000, 10:00 PM
                //print(contact.reference.id);
                final String roomId = contact.reference.id;
                // var dt = DateTime.fromMillisecondsSinceEpoch(dateTime);
                var msgTime = DateFormat('hh:mm a / dd-MM-yy').format(dateTime);
                print(msgTime);
                // final group_id = ["group_id"];
                // final type = ["type"];

                // msgTime = DateFormat('hh:mm a / dd-MM-yy')
                //     .format(DateTime.parse(d.toString()))
                //     .toString();

                // String convertedDateTime =
                //     "${dateTime.hour.toString()}-${dateTime.minute.toString()}";
                // DateTime hours =
                //     new DateTime(dateTime.hour);
                // DateTime minutes =
                //     new DateTime(dateTime.minute);
                documnetIndex = documnetIndex + 1;

                if (receiverId == AppGlobal.userID) {
                  final messagePersonsWidget = PersonIdentifierWidget(
                    screenSize: screenSize,
                    pName: senderName,
                    pPhoto: senderUrl ?? '',
                    userId: senderId,
                    roomId: roomId,
                    documnetIndex: documnetIndex,
                    followingFollowers: false,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatPersonalScreen(
                            senderName: receiverName,
                            receiverUserId: receiverId,
                            documnetIndex: documnetIndex,
                            roomId: roomId,
                          ),
                        ),
                      );
                    },
                    time: msgTime,
                  );
                  messagePersonsWidgets.add(messagePersonsWidget);
                } else if (senderId == AppGlobal.userID) {
                  final messagePersonsWidget = PersonIdentifierWidget(
                    screenSize: screenSize,
                    pName: receiverName,
                    pPhoto: receiverUrl,
                    userId: receiverId,
                    roomId: roomId,
                    documnetIndex: documnetIndex,
                    followingFollowers: false,
                    time: msgTime,
                  );
                  messagePersonsWidgets.add(messagePersonsWidget);
                }
              }
              return Expanded(
                child: ListView(
                  // reverse: true,
                  children: messagePersonsWidgets,
                ),
              );
            },
          )
          // PersonIdentifierWidget(
          //   screenSize: screenSize,
          //   pName: 'Stephi Vidr',
          //   pPhoto: null,
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) =>
          //             ChatPersonalScreen(senderName: 'Stephi Vidr'),
          //       ),
          //     );
          //   },
          // ),
          // PersonIdentifierWidget(
          //   screenSize: screenSize,
          //   pName: 'Bella',
          //   pPhoto: null,
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) =>
          //             ChatPersonalScreen(senderName: 'Bella'),
          //       ),
          //     );
          //   },
          // ),
          // PersonIdentifierWidget(
          //   screenSize: screenSize,
          //   pName: 'Rachel Scott',
          //   pPhoto: null,
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) =>
          //             ChatPersonalScreen(senderName: 'Rachel Scott'),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //         elevation: 10.0,
      //         child: const Icon(
      //           Icons.chat,
      //           color: kColorPrimary,
      //         ),
      //         backgroundColor: kColorPrimary,
      //         onPressed: () async {
      //           var status = await Permission.contacts.status;
      //           if (status.isGranted) {
      //             //Navigator.pushNamed(context, Contacts.id);
      //           } else {
      //             //ask for permission
      //
      //             showDialog(
      //                 context: context,
      //                 builder: (BuildContext context) => CupertinoAlertDialog(
      //                       title: Text('Contacts Permission'),
      //                       content: Text(
      //                           'This app needs contact list access to get connected with the people. Go to app permissions settings and allow the Contacts permission.'),
      //                       actions: <Widget>[
      //                         CupertinoDialogAction(
      //                           child: Text('Deny'),
      //                           onPressed: () => Navigator.of(context).pop(),
      //                         ),
      //                         CupertinoDialogAction(
      //                             child: Text('Settings'),
      //                             onPressed: () {
      //                               openAppSettings();
      //                               Navigator.of(context).pop();
      //                             }),
      //                       ],
      //                     ));
      //
      //             // else {
      //             //   Navigator.pushNamed(context, Contacts.id);
      //             // }
      //           }
      //           // if (Platform.isIOS) {
      //           //   Navigator.pushNamed(context, Contacts.id);
      //           // }
      //         }),
      //     SizedBox(
      //       height: screenSize.height * 0.08,
      //     )
      //   ],
      // ),
    );
  }
}

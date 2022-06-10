import 'dart:io';

import 'package:bangla_bazar/ModelClasses/chat_notify_user_model.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/web_services.dart';
import 'package:bangla_bazar/Widgets/receiver_message_widget.dart';
import 'package:bangla_bazar/Widgets/sender_message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatPersonalScreen extends StatefulWidget {
  String? roomId;
  final String senderName;
  final String? senderPic;
  final int? receiverUserId;
  final int? documnetIndex;

  ChatPersonalScreen({
    Key? key,
    required this.senderName,
    this.senderPic,
    this.receiverUserId,
    this.documnetIndex,
    this.roomId,
  }) : super(key: key);
  @override
  _ChatPersonalScreenState createState() => _ChatPersonalScreenState();
}

class _ChatPersonalScreenState extends State<ChatPersonalScreen> {
  // attach files code start from here
  // File _image;
  // File _video;
  //final picker = ImagePicker();
  var _controller = TextEditingController();
  String messageText = '';
  final fireStore = FirebaseFirestore.instance;

  // Future getImage(final pickedFileSelected) async {
  //   final pickedFile = await pickedFileSelected;
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  // void getMessages() async {
  //   final messages = await fireStore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }
  //
  // void messagesStream() async {
  //   await for (var snapshot in fireStore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  // Future getVideo(final pickedFileSelected) async {
  //   final pickedFile = await pickedFileSelected;
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }
  //attch file code ends here

  // video call attributes and functions start from here
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  // ClientRole _role = ClientRole.Broadcaster;

  Future<void> checkUser() async {
    var ref = fireStore
        .collection('Users')
        .where('receiver_id', isEqualTo: widget.receiverUserId)
        .where('sender_id', isEqualTo: AppGlobal.userID)
        .get()
        .then((value) => {
              // print('>>>>>>>>>>>${value.docs.first.id}'),
              if (value.docs.isEmpty)
                {
                  print('>>>>>>>>>>>123'),
                  fireStore
                      .collection('Users')
                      .where('receiver_id', isEqualTo: AppGlobal.userID)
                      .where('sender_id', isEqualTo: widget.receiverUserId)
                      .get()
                      .then((value) => {
                            // print('>>>>>>>>>>>${value.docs.first.id}'),
                            if (value.docs.isEmpty)
                              {
                                print('>>>>>>>>>>>124'),
                                fireStore.collection('Users').add({
                                  'sender_id': AppGlobal.userID,
                                  'sender_name': AppGlobal.userName,
                                  'sender_url': AppGlobal.profilePic,
                                  'receiver_id': widget.receiverUserId,
                                  'receiver_name': widget.senderName,
                                  'receiver_url': widget.senderPic,
                                  'time_stamp': FieldValue.serverTimestamp(),
                                }),
                                fireStore
                                    .collection('Users')
                                    .where('receiver_id',
                                        isEqualTo: AppGlobal.userID)
                                    .where('sender_id',
                                        isEqualTo: widget.receiverUserId)
                                    .get()
                                    .then((value3) => {
                                          widget.roomId = value3.docs.first.id,
                                          if (_controller.text.isNotEmpty)
                                            {
                                              messageText = _controller.text,
                                              _controller.clear(),
                                              fireStore
                                                  .collection('messages')
                                                  .add({
                                                'text': messageText,
                                                'sender_id': AppGlobal.userID,
                                                'receiver_id':
                                                    widget.receiverUserId,
                                                'time_stamp': FieldValue
                                                    .serverTimestamp(),
                                                'room_id': widget.roomId,
                                              }),
                                              postChatNotify(
                                                  AppGlobal.userID.toString(),
                                                  widget.receiverUserId
                                                      .toString())

                                              ///fghfhfh
                                              // CollectionReference collectionReference =
                                              //     FirebaseFirestore.instance
                                              //         .collection('Users');
                                              // QuerySnapshot querySnapshot =
                                              //     await collectionReference.get();
                                              // querySnapshot
                                              //     .docs[widget.documnetIndex!].reference
                                              //     .update({"time_stamp": now});
                                              /// jgjgj
                                              // print(
                                              //     'user number :${widget.documnetIndex} updated');
                                            }
                                        })
                              }
                            else
                              {
                                if (widget.roomId == null)
                                  {
                                    widget.roomId = value.docs.first.id,
                                  },
                                fireStore
                                    .collection('Users')
                                    .doc(widget.roomId)
                                    .update({
                                  'time_stamp': FieldValue.serverTimestamp(),
                                }),
                                if (_controller.text.isNotEmpty)
                                  {
                                    messageText = _controller.text,
                                    _controller.clear(),
                                    fireStore.collection('messages').add({
                                      'text': messageText,
                                      'sender_id': AppGlobal.userID,
                                      'receiver_id': widget.receiverUserId,
                                      'time_stamp':
                                          FieldValue.serverTimestamp(),
                                      'room_id': widget.roomId,
                                    }),
                                    postChatNotify(AppGlobal.userID.toString(),
                                        widget.receiverUserId.toString())
                                  }
                              }
                          })
                }
              else
                {
                  if (widget.roomId == null)
                    {
                      widget.roomId = value.docs.first.id,
                    },
                  fireStore.collection('Users').doc(widget.roomId).update({
                    'time_stamp': FieldValue.serverTimestamp(),
                  }),
                  if (_controller.text.isNotEmpty)
                    {
                      messageText = _controller.text,
                      _controller.clear(),
                      fireStore.collection('messages').add({
                        'text': messageText,
                        'sender_id': AppGlobal.userID,
                        'receiver_id': widget.receiverUserId,
                        'time_stamp': FieldValue.serverTimestamp(),
                        'room_id': widget.roomId,
                      }),
                      postChatNotify(AppGlobal.userID.toString(),
                          widget.receiverUserId.toString())
                    }
                }
            });
    // print('>>>>>>>>>>>');
    // print(ref.length.toString());
    // if (ref.length.toString() == '0') {
    //   print('>>>>>>>>>>>123');
    // }
  }

  Future<void> checkRoomID() async {
    var ref = fireStore
        .collection('Users')
        .where('receiver_id', isEqualTo: widget.receiverUserId)
        .where('sender_id', isEqualTo: AppGlobal.userID)
        .get()
        .then((value) => {
              // print('>>>>>>>>>>>${value.docs.first.id}'),
              if (value.docs.isEmpty)
                {
                  print('>>>>>>>>>>>123'),
                  fireStore
                      .collection('Users')
                      .where('receiver_id', isEqualTo: AppGlobal.userID)
                      .where('sender_id', isEqualTo: widget.receiverUserId)
                      .get()
                      .then((value) => {
                            // print('>>>>>>>>>>>${value.docs.first.id}'),
                            if (value.docs.isEmpty)
                              {}
                            else
                              {
                                widget.roomId = value.docs.first.id,
                              }
                          })
                }
              else
                {
                  widget.roomId = value.docs.first.id,
                }
            });
    // print('>>>>>>>>>>>');
    // print(ref.length.toString());
    // if (ref.length.toString() == '0') {
    //   print('>>>>>>>>>>>123');
    // }
  }

  @override
  void initState() {
    super.initState();
    //checkRoomID();
    // fireStore.collection('Users').add({
    //   'sender_id': AppGlobal.userID,
    //   'sender_url': AppGlobal.profilePic,
    //   'sender_name': AppGlobal.userName,
    //   'receiver_url': widget.senderPic,
    //   'receiver_id': widget.receiverUserId,
    //   'receiver_name': widget.senderName,
    //   'time_stamp': DateTime.now(),
    // });
  }

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  //video call attributes and functions end from here
  bool attachFileButtonFlag = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kColorWidgetBackgroundColor,
      //extendBody: true,
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: kColorWhite,
        foregroundColor: Colors.black,
        title: Text(
          widget.senderName,
        ),
        // actions: [
        // IconButton(
        //     icon: Icon(
        //       Icons.videocam,
        //       //color: kColorSecondary,
        //     ),
        //     onPressed: () {
        //       // _role = ClientRole.Broadcaster;
        //       // onJoin();
        //     }),
        // IconButton(
        //     icon: Icon(
        //       Icons.call,
        //       // color: kColorSecondary,
        //     ),
        //     onPressed: () {
        //       // _role = ClientRole.Audience;
        //       // onJoin();
        //     }),
        //],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenSize.height * 0.86,
          width: screenSize.width,
          child: Column(
            children: [
              Expanded(
                flex: 11,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: fireStore
                        .collection('messages')
                        .where('room_id', isEqualTo: widget.roomId)
                        .orderBy('time_stamp', descending: false)
                        .snapshots(),
                    builder: (context, snapshots) {
                      if (!snapshots.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: kColorPrimary,
                          ),
                        );
                      }
                      final messages = snapshots.data!.docs.reversed;
                      List<MessageWidgetSelector> messageBubbles = [];
                      for (var message in messages) {
                        final messageText = message["text"];
                        final messageSender = message["sender_id"];
                        final messageReceiver = message["receiver_id"];

                        if (message["time_stamp"] != null) {
                          DateTime dateTime = message["time_stamp"].toDate();

                          String msgTime =
                              DateFormat('hh:mm a / dd-MM-yy').format(dateTime);

                          ///
                          // String convertedDateTime =
                          //     "${dateTime.hour.toString()}-${dateTime.minute.toString()}";
                          // DateTime hours =
                          //     new DateTime(dateTime.hour);
                          // DateTime minutes =
                          //     new DateTime(dateTime.minute);

                          if ((messageReceiver == widget.receiverUserId &&
                                  messageSender == AppGlobal.userID) ||
                              (messageReceiver == AppGlobal.userID &&
                                  messageSender == widget.receiverUserId)) {
                            final messageBubble =
                                messageSender == AppGlobal.userID
                                    ? MessageWidgetSelector(
                                        myMessageFlag: true,
                                        msgText: messageText,
                                        screenSize: screenSize,
                                        time: msgTime,
                                        //time: convertedDateTime,
                                      )
                                    : MessageWidgetSelector(
                                        myMessageFlag: false,
                                        msgText: messageText,
                                        screenSize: screenSize,
                                        time: msgTime,
                                      );
                            messageBubbles.add(messageBubble);
                          }
                        }
                      }
                      return ListView(
                        reverse: true,
                        children: messageBubbles,
                      );
                    },
                  ),
                ), //ChatWidgets
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: screenSize.width,
                  color: kColorWhite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: screenSize.height * 0.10,
                          width: screenSize.width * 0.72,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: kColorPrimary.withOpacity(0.3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            child: TextFormField(
                              controller: _controller,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                // addCommentRequestModel.commentText =
                                //     value;
                              },
                              maxLines: 3,
                              style: (const TextStyle(
                                color: Colors.black,
                              )),
                              decoration: const InputDecoration(
                                //focusColor: kColorSecondary,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: 'Type here.....',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                            // child: Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     TextFormField(
                            //       controller: _controller,
                            //       cursorColor: Colors.black,
                            //       keyboardType: TextInputType.text,
                            //       onChanged: (value) {
                            //         // addCommentRequestModel.commentText =
                            //         //     value;
                            //       },
                            //       style: (TextStyle(
                            //         color: textColorBlack,
                            //       )),
                            //       decoration: InputDecoration(
                            //         //focusColor: kColorSecondary,
                            //         // contentPadding: EdgeInsets.symmetric(
                            //         //     horizontal: 10, vertical: 10),
                            //         floatingLabelBehavior:
                            //             FloatingLabelBehavior.always,
                            //         hintStyle: TextStyle(color: Colors.grey),
                            //         hintText: 'Write a comment.....',
                            //         border: InputBorder.none,
                            //         focusedBorder: InputBorder.none,
                            //         enabledBorder: InputBorder.none,
                            //         errorBorder: InputBorder.none,
                            //         disabledBorder: InputBorder.none,
                            //       ),
                            //     ),
                            //     IconButton(
                            //         icon: Icon(
                            //           Icons.attach_file,
                            //           color: kColorPrimary,
                            //           size: 35,
                            //         ),
                            //         onPressed: () {
                            //           setState(() {
                            //             if (attachFileButtonFlag == false) {
                            //               attachFileButtonFlag = true;
                            //             } else {
                            //               attachFileButtonFlag = false;
                            //             }
                            //           });
                            //         })
                            //   ],
                            // ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // DateTime date =
                            //     new DateTime(now.hour, now.minute, now.second);
                            //print(date);
                            checkUser();
                          },
                          child: Container(
                            height: screenSize.height * 0.10,
                            width: screenSize.width * 0.15,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: kColorPrimary,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: kColorWhite,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> onJoin() async {
  //   // update input validation
  //   setState(() {
  //     // _channelController.text.isEmpty
  //     //     ? _validateError = true
  //     //     : _validateError = false;
  //   });
  //   //if (_channelController.text.isNotEmpty) {
  //   //await for camera and mic permissions before pushing video page
  //   // await _handleCameraAndMic(Permission.camera);
  //   // await _handleCameraAndMic(Permission.microphone);
  //   // push video page with given channel name
  //   // await Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //     builder: (context) => CallPage(
  //   //       channelName: 'p2p',
  //   //       role: _role,
  //   //     ),
  //   //   ),
  //   // );
  // }

  Future<void> postChatNotify(String senderID, String receiverID) async {
    ChatNotifyUserModel chatNotifyUserModel =
        ChatNotifyUserModel(senderID: senderID, receiverID: receiverID);
    try {
      String url = '${AppGlobal.baseURL}admin/notify-user';

      dynamic response =
          await WebServices.apiPostToJson(url, chatNotifyUserModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

// Future<void> _handleCameraAndMic(Permission permission) async {
//   final status = await permission.request();
//   print(status);
// }

class MessageWidgetSelector extends StatelessWidget {
  MessageWidgetSelector({
    required this.myMessageFlag,
    required this.msgText,
    required this.time,
    this.screenSize,
  });
  bool myMessageFlag;
  String msgText;
  String time;
  var screenSize;
  //String time;

  @override
  Widget build(BuildContext context) {
    return myMessageFlag == false
        ? SenderMessageWidget(
            messageText: msgText, messageTime: time, screenSize: screenSize)
        : ReceiverMessageWidget(messageText: msgText, messageTime: time);
  }
}

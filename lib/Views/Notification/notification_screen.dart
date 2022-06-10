import 'package:bangla_bazar/ModelClasses/in_app_notifications_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/Chat/personal_chat_screen.dart';
import 'package:bangla_bazar/Views/Notification/NotificationsBloc/notification_bloc.dart';
import 'package:bangla_bazar/Views/main_home_page.dart';
import 'package:bangla_bazar/Widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../MyOrders/order_details_screen.dart';

class NotificationsScreen extends StatefulWidget {
  final String previousPage;

  const NotificationsScreen({
    Key? key,
    required this.previousPage,
  }) : super(key: key);
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late NotificationBloc _notificationBloc;

  InAppNotificationsResponse? inAppNotificationsResponse;

  @override
  void initState() {
    super.initState();
    _notificationBloc = BlocProvider.of<NotificationBloc>(context);
    _notificationBloc.add(GetInAppNotifications());
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is ErrorState) {
        Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
      } else if (state is InternetErrorState) {
        Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
      } else if (state is InAppNotificationsState) {
        inAppNotificationsResponse = state.inAppNotificationsResponse;
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
            backgroundColor: kColorWhite,
            body: Stack(
              children: [
                ///This is Body
                Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  color: kColorWhite,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          // color: Colors.yellow,
                          width: screenSize.width,
                          height: screenSize.height * 0.13,
                        ),
                        inAppNotificationsResponse != null
                            ? inAppNotificationsResponse!
                                    .notifications.isNotEmpty
                                ? Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'New',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                            width: 20,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  kColorWidgetBackgroundColor,
                                              // border: Border.all(
                                              //     color: kColorDarkGreyText, width: 3),
                                              // image: DecorationImage(
                                              //   image: Image.asset("assets/icons/eyeicon.png",),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                inAppNotificationsResponse !=
                                                        null
                                                    ? inAppNotificationsResponse!
                                                        .notifications.length
                                                        .toString()
                                                    : '0',
                                                style: const TextStyle(
                                                    color: kColorPrimary,
                                                    fontSize: 10),
                                              ),
                                            )),
                                      ],
                                    ),
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                        Expanded(
                          child: inAppNotificationsResponse != null
                              ? inAppNotificationsResponse!
                                      .notifications.isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          inAppNotificationsResponse != null
                                              ? inAppNotificationsResponse!
                                                  .notifications.length
                                              : 0,
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          onTap: () {
                                            if (inAppNotificationsResponse!
                                                        .notifications[i]
                                                        .orderNumber !=
                                                    null &&
                                                inAppNotificationsResponse!
                                                        .notifications[i]
                                                        .TypeID ==
                                                    6) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderDetails(
                                                          previousPage:
                                                              'UserMyOrders',
                                                          orderNumber:
                                                              inAppNotificationsResponse!
                                                                  .notifications[
                                                                      i]
                                                                  .orderNumber!,
                                                        )),
                                              );
                                            } else if (inAppNotificationsResponse!
                                                    .notifications[i].TypeID ==
                                                3) {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatPersonalScreen(
                                                    senderName:
                                                        inAppNotificationsResponse!
                                                            .notifications[i]
                                                            .UserName,
                                                    senderPic:
                                                        inAppNotificationsResponse!
                                                            .notifications[i]
                                                            .ProfilePic,
                                                    receiverUserId:
                                                        inAppNotificationsResponse!
                                                            .notifications[i]
                                                            .UserID,
                                                    documnetIndex: 0,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: NotificationWidget(
                                            screenSize: screenSize,
                                            profilePic:
                                                inAppNotificationsResponse!
                                                    .notifications[i]
                                                    .ProfilePic,
                                            message: inAppNotificationsResponse!
                                                    .notifications[i].message ??
                                                '',
                                            time: inAppNotificationsResponse!
                                                .notifications[i].formatedTime!,
                                            orderNumber:
                                                inAppNotificationsResponse!
                                                    .notifications[i]
                                                    .orderNumber,
                                            readStatus:
                                                inAppNotificationsResponse!
                                                    .notifications[i]
                                                    .NotificationStatus,
                                          ),
                                        );
                                      },
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/no_notification.png',
                                          scale: 3,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'No notification',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorFieldsBorders),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()),
                                                    (Route<dynamic> route) =>
                                                        false);
                                          },
                                          child: Container(
                                            height: screenSize.height * 0.05,
                                            width: screenSize.width * 0.43,
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: kColorPrimary,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Continue Shopping',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: kColorWhite,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/no_notification.png',
                                      scale: 3,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Notifications',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///This is AppBar
                Column(
                  children: [
                    Container(
                      color: kColorWhite,
                      width: screenSize.width,
                      height: screenSize.height * 0.035,
                    ),
                    Container(
                        color: kColorWhite,
                        width: screenSize.width,
                        height: screenSize.height * 0.09,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.previousPage == 'homePage'
                                  ? const Text(
                                      'Notifications',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 21),
                                    )
                                  : Row(
                                      children: [
                                        const Icon(Icons.arrow_back_ios_new),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            '  Notifications',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 21),
                                          ),
                                        ),
                                      ],
                                    ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => EditProfileScreen(
                                      //         previousPage: '',
                                      //       )),
                                      // );
                                    },
                                    child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorWidgetBackgroundColor,
                                          // border: Border.all(
                                          //     color: kColorDarkGreyText, width: 3),
                                          // image: DecorationImage(
                                          //   image: Image.asset("assets/icons/eyeicon.png",),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        child: const Icon(
                                          MyFlutterApp.carticonlined,
                                          color: kColorDarkGreyText,
                                          size: 18,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => EditProfileScreen(
                                      //         previousPage: '',
                                      //       )),
                                      // );
                                    },
                                    child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorWidgetBackgroundColor,
                                          // border: Border.all(
                                          //     color: kColorDarkGreyText, width: 3),
                                          // image: DecorationImage(
                                          //   image: Image.asset("assets/icons/eyeicon.png",),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        child: const Icon(
                                          Icons.search,
                                          color: kColorDarkGreyText,
                                          size: 18,
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ],
            )),
      );
    });
  }
}

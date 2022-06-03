import 'package:bangla_bazar/ModelClasses/logout_model.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginBloc/login_bloc.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginscreen.dart';
import 'package:bangla_bazar/Views/Chat/my_chats_screen.dart';
import 'package:bangla_bazar/Views/DeliveryViews/cancelled_delivery_screen.dart';
import 'package:bangla_bazar/Views/DeliveryViews/complete_delivery_screen.dart';
import 'package:bangla_bazar/Views/DeliveryViews/deliveries_pending_screen.dart';
import 'package:bangla_bazar/Views/DeliveryViews/delivery_dash_board.dart';
import 'package:bangla_bazar/Views/MyOrders/my_orders_screen.dart';
import 'package:bangla_bazar/Views/PrivacyPolicyScreen.dart';
import 'package:bangla_bazar/Views/Product/categories.dart';
import 'package:bangla_bazar/Views/Product/wish_list_screen.dart';
import 'package:bangla_bazar/Views/main_home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HelpCenterScreen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    Key? key,
  }) : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late LoginBloc _loginBloc;

  LogoutModel? logoutModel;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
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
      } else if (state is LogoutState) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen()),
            (Route<dynamic> route) => false);
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
            backgroundColor: kColorWhite,
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                ///This is Body
                AppGlobal.switchToDriverAccount == false
                    ? Container(
                        height: screenSize.height,
                        width: screenSize.width,
                        color: kColorWhite,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                SizedBox(
                                  // color: Colors.yellow,
                                  width: screenSize.width,
                                  height: screenSize.height * 0.13,
                                ),

                                /// User Menu
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 35.0,
                                      child: CachedNetworkImage(
                                        imageUrl: AppGlobal.photosBaseURL +
                                            AppGlobal.profilePic,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              color: kColorWhite,
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          MyFlutterApp.account_fill,
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppGlobal.userName,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                        ),
                                        Text(
                                          AppGlobal.emailAddress,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: kColorFieldsBorders,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage(
                                                  currentTab: 3,
                                                )),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.account_border,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'My Account',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Categories()),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.category,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Categories',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const MyOrders(
                                                previousPasge: 'UsersMenu',
                                              )),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.order,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'My Orders',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ChatScreen()),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.chat_ic,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'My Chats',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const WishListScreen(
                                                previousPage: 'Wish List',
                                              )),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.wishlist,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Wishlist',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorDarkGreyText
                                              .withOpacity(0.2),
                                          // border: Border.all(
                                          //     color: kColorDarkGreyText, width: 3),
                                          // image: DecorationImage(
                                          //   image: Image.asset("assets/icons/eyeicon.png",),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        child: const Icon(
                                          MyFlutterApp.deals,
                                          color: kColorPrimary,
                                          size: 18,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Deals',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PrivacyPolicyScreen()),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.privacy_policy,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Privacy Policy',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // InkWell(
                                //   onTap: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               const HelpCenterScreen()),
                                //     );
                                //   },
                                //   child: Row(
                                //     children: [
                                //       Container(
                                //           width: 35,
                                //           height: 35,
                                //           decoration: BoxDecoration(
                                //             shape: BoxShape.circle,
                                //             color: kColorDarkGreyText
                                //                 .withOpacity(0.2),
                                //             // border: Border.all(
                                //             //     color: kColorDarkGreyText, width: 3),
                                //             // image: DecorationImage(
                                //             //   image: Image.asset("assets/icons/eyeicon.png",),
                                //             //   fit: BoxFit.cover,
                                //             // ),
                                //           ),
                                //           child: const Icon(
                                //             MyFlutterApp.help_center,
                                //             color: kColorPrimary,
                                //             size: 18,
                                //           )),
                                //       const SizedBox(
                                //         width: 10,
                                //       ),
                                //       const Text(
                                //         'Help Center',
                                //         style: TextStyle(
                                //             color: Colors.black, fontSize: 16),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // Row(
                                //   children: [
                                //     Container(
                                //         width: 35,
                                //         height: 35,
                                //         decoration: BoxDecoration(
                                //           shape: BoxShape.circle,
                                //           color: kColorDarkGreyText
                                //               .withOpacity(0.2),
                                //           // border: Border.all(
                                //           //     color: kColorDarkGreyText, width: 3),
                                //           // image: DecorationImage(
                                //           //   image: Image.asset("assets/icons/eyeicon.png",),
                                //           //   fit: BoxFit.cover,
                                //           // ),
                                //         ),
                                //         child: const Icon(
                                //           MyFlutterApp.settings,
                                //           color: kColorPrimary,
                                //           size: 18,
                                //         )),
                                //     const SizedBox(
                                //       width: 10,
                                //     ),
                                //     const Text(
                                //       'Settings',
                                //       style: TextStyle(
                                //           color: Colors.black, fontSize: 16),
                                //     ),
                                //   ],
                                // ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () async {
                                    FlutterSecureStorage storage =
                                        const FlutterSecureStorage();
                                    await storage.write(
                                        key: 'emailAddress', value: '');
                                    await storage.write(key: 'pass', value: '');
                                    await storage.write(
                                        key: 'rememberMe', value: '');
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const LoginScreen()),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.logout_icon,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Logout',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  // color: Colors.yellow,
                                  width: screenSize.width,
                                  height: screenSize.height * 0.13,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: screenSize.height,
                        width: screenSize.width,
                        color: kColorWhite,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                SizedBox(
                                  // color: Colors.yellow,
                                  width: screenSize.width,
                                  height: screenSize.height * 0.13,
                                ),

                                /// Driver menu
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 35.0,
                                      child: CachedNetworkImage(
                                        imageUrl: AppGlobal.photosBaseURL +
                                            AppGlobal.profilePic,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              color: kColorWhite,
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          MyFlutterApp.account_fill,
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppGlobal.userName,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                        ),
                                        Text(
                                          AppGlobal.emailAddress,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: kColorFieldsBorders,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage(
                                                  currentTab: 3,
                                                )),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.account_border,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'My Profile',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DeliveryDashBoard(
                                                previousPasge: 'DriverMenu',
                                              )),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.category,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Dashboard',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CompletedDeliveryScreen(
                                                previousPasge: 'DriverMenu',
                                              )),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.completed_d,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Completed Delivery',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PendingDeliveryScreen(
                                                previousPasge: 'DriverMenu',
                                              )),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.pending_delivery,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Pending Delivery',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CancelledDeliveryScreen(
                                                previousPasge: 'DriverMenu',
                                              )),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.cancelled_d,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Cancelled Delivery',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                Row(
                                  children: [
                                    Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorDarkGreyText
                                              .withOpacity(0.2),
                                          // border: Border.all(
                                          //     color: kColorDarkGreyText, width: 3),
                                          // image: DecorationImage(
                                          //   image: Image.asset("assets/icons/eyeicon.png",),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        child: const Icon(
                                          MyFlutterApp.help_center,
                                          color: kColorPrimary,
                                          size: 18,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Help Center',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorDarkGreyText
                                              .withOpacity(0.2),
                                          // border: Border.all(
                                          //     color: kColorDarkGreyText, width: 3),
                                          // image: DecorationImage(
                                          //   image: Image.asset("assets/icons/eyeicon.png",),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        child: const Icon(
                                          MyFlutterApp.settings,
                                          color: kColorPrimary,
                                          size: 18,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Settings',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () async {
                                    FlutterSecureStorage storage =
                                        const FlutterSecureStorage();
                                    await storage.write(
                                        key: 'emailAddress', value: '');
                                    await storage.write(key: 'pass', value: '');
                                    await storage.write(
                                        key: 'rememberMe', value: '');

                                    logoutModel!.SessionID = AppGlobal.token;
                                    _loginBloc
                                        .add(Logout(logoutModel: logoutModel!));
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                            // border: Border.all(
                                            //     color: kColorDarkGreyText, width: 3),
                                            // image: DecorationImage(
                                            //   image: Image.asset("assets/icons/eyeicon.png",),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.logout_icon,
                                            color: kColorPrimary,
                                            size: 18,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Logout',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  // color: Colors.yellow,
                                  width: screenSize.width,
                                  height: screenSize.height * 0.13,
                                ),
                              ],
                            ),
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
                              // widget.previousPage == 'homePage'
                              //     ? const Text(
                              //   'Notifications',
                              //   style: TextStyle(
                              //       color: Colors.black, fontSize: 21),
                              // )
                              //     : Row(
                              //   children: [
                              //     const Icon(Icons.arrow_back_ios_new),
                              //     InkWell(
                              //       onTap: () {
                              //         Navigator.pop(context);
                              //       },
                              //       child: const Text(
                              //         '  Notifications',
                              //         style: TextStyle(
                              //             color: Colors.black,
                              //             fontSize: 21),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Row(
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         // Navigator.push(
                              //         //   context,
                              //         //   MaterialPageRoute(
                              //         //       builder: (context) => EditProfileScreen(
                              //         //         previousPage: '',
                              //         //       )),
                              //         // );
                              //       },
                              //       child: Container(
                              //           width: 35,
                              //           height: 35,
                              //           decoration: const BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: kColorWidgetBackgroundColor,
                              //             // border: Border.all(
                              //             //     color: kColorDarkGreyText, width: 3),
                              //             // image: DecorationImage(
                              //             //   image: Image.asset("assets/icons/eyeicon.png",),
                              //             //   fit: BoxFit.cover,
                              //             // ),
                              //           ),
                              //           child: const Icon(
                              //             MyFlutterApp.carticonlined,
                              //             color: kColorDarkGreyText,
                              //             size: 18,
                              //           )),
                              //     ),
                              //     const SizedBox(
                              //       width: 10,
                              //     ),
                              //     InkWell(
                              //       onTap: () {
                              //         // Navigator.push(
                              //         //   context,
                              //         //   MaterialPageRoute(
                              //         //       builder: (context) => EditProfileScreen(
                              //         //         previousPage: '',
                              //         //       )),
                              //         // );
                              //       },
                              //       child: Container(
                              //           width: 35,
                              //           height: 35,
                              //           decoration: const BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: kColorWidgetBackgroundColor,
                              //             // border: Border.all(
                              //             //     color: kColorDarkGreyText, width: 3),
                              //             // image: DecorationImage(
                              //             //   image: Image.asset("assets/icons/eyeicon.png",),
                              //             //   fit: BoxFit.cover,
                              //             // ),
                              //           ),
                              //           child: const Icon(
                              //             Icons.search,
                              //             color: kColorDarkGreyText,
                              //             size: 18,
                              //           )),
                              //     )
                              //   ],
                              // ),
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

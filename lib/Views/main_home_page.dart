import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/rout_arguments.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/account_screen.dart';
import 'package:bangla_bazar/Views/menu_screen.dart';
import 'package:bangla_bazar/Views/Cart/my_cart_screen.dart';
import 'package:bangla_bazar/Views/Notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

import 'home_screen.dart';

class HomePage extends StatefulWidget {
  static const String id = 'HomePage';
  dynamic currentTab;
  late RouteArgument routeArgument;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Widget currentPage = const HomeBody();

  // final String name;
  // final String userName;
  // final String userPic;
  HomePage({
    Key? key,
    this.currentTab,
    // required this.name,
    // required this.userName,
    // required this.userPic,
  }) : super(key: key) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _searchButtonVisibility = 0;
  late final DateTime tempBirthday;

  @override
  void initState() {
    super.initState();
    _selectTab(widget.currentTab);
    if (AppGlobal.birthDay != '') {
      tempBirthday = DateFormat("yyyy-MM-dd").parse(AppGlobal.birthDay);
      AppGlobal.birthDay =
          DateFormat('yyyy-MM-dd').format(tempBirthday).toString();
    }
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          // cusSearchBar = Text(
          //   'chat2me.',
          //   style: TextStyle(color: Colors.white),
          // );
          //_searchButtonVisibility = 0;
          widget.currentPage = HomeBody();
          break;
        case 1:
          //cusSearchBar = Text('chat2me.');
          //_searchButtonVisibility = 1;

          widget.currentPage = const NotificationsScreen(
            previousPage: 'homePage',
          );
          break;
        case 2:
          // cusSearchBar = Text('chat2me.');
          //_searchButtonVisibility = 3;
          widget.currentPage = const MyCartScreen();
          break;
        case 3:
          // cusSearchBar = Text('chat2me.');
          // _searchButtonVisibility = 4;
          widget.currentPage = const AccountScreen(
            previousPage: 'homePage',
          );
          break;
        case 4:
          // cusSearchBar = Text('chat2me.');
          // _searchButtonVisibility = 4;
          widget.currentPage = const MenuScreen();
          break;
      }
    });
  }

  Icon cusIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );

  // Widget cusSearchBar = Text(
  //   style: TextStyle(color: Colors.white),
  // );
  // Widget lastappBarTitle = Text(
  //   'chat2me.',
  //   style: TextStyle(color: Colors.white),
  // );

  double shadowValueBlurRadius = 2;
  Container bottomNavigationBarWidget() {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black38)],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kColorPrimary,
        elevation: 0,
        backgroundColor: Colors.white,
        selectedIconTheme: const IconThemeData(size: 22),
        unselectedIconTheme:
            const IconThemeData(color: kColorFieldsBorders, size: 20),
        //unselectedItemColor: kColorFieldsBorders,
        currentIndex: widget.currentTab,
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
          overflow: TextOverflow.visible,
        ),

        unselectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 10,
          overflow: TextOverflow.visible,
        ),
        onTap: (int i) {
          _selectTab(i);
        },
        // this will be set when a new tab is tapped
        items: const [
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.homeicon),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.icon_notification_solid),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.carticon),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.account_fill),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp.icon_menu_outline,
              // size: 15,
            ),
            label: '   Menu',
          ),
        ],
      ),
    );
  }

  Widget get appBar {
    return AppBar(
      backgroundColor: kColorPrimary,
      actions: <Widget>[
        _searchButtonVisibility == 0
            ? IconButton(icon: cusIcon, onPressed: () {})
            : _searchButtonVisibility == 1
                ? PopupMenuButton<String>(
                    //onSelected: handleClick,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    //padding: EdgeInsets.all(30),
                    color: kColorWhite,
                    icon: const Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    itemBuilder: (BuildContext context) {
                      return {
                        'New Group',
                        'Invite Friends',
                      }.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(
                            choice,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        );
                      }).toList();
                    },
                  )
                : const SizedBox(),
      ],
      title: const Text('Title'),
      elevation: 0.0,
      bottomOpacity: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: widget.currentPage,
        bottomNavigationBar: bottomNavigationBarWidget(),
      ),
    );
  }
}

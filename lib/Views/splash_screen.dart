import 'dart:async';

import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/common_functions.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/code_verfication.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginscreen.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/new_password_screen.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'AuthenticationScreens/forget_password.dart';
import 'AuthenticationScreens/loginBloc/login_bloc.dart';
import 'main_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  late LoginBloc _loginBloc;
  @override
  void initState() {
    super.initState();
    checkUserData();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    @override
    void dispose() {
      _animationController.dispose();
      _animation.isDismissed; // you need this
      super.dispose();
    }

    _animation.addListener(() => setState(() {}));
    _animationController.forward();

    Timer(const Duration(seconds: 3), () {
      if (AppGlobal.rememberMe == 'true') {
        _loginBloc.add(LoginUser(
            username: AppGlobal.rememberMeEmail,
            password: AppGlobal.rememberMePassword,
            rememberMe: 'Y'));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
      }
    });
  }

  void checkUserData() async {
    var temp = await getUserData();
    AppGlobal.rememberMe = temp.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is ErrorState) {
      } else if (state is InternetErrorState) {
        Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
      } else if (state is LoginSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      const Text('WELCOME TO'),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/BanglaBazarLogo.png',
                        width: _animation.value * 300,
                        //height: _animation.value * 300,
                      ),
                    ],
                  ),
                  const Text('BanglaBazar Online Marketplace')
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

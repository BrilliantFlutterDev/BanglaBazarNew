import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/forget_password.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginBloc/login_bloc.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/sign_up_screen.dart';
import 'package:bangla_bazar/Views/main_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginScreen> {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  bool visible = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  late LoginBloc _loginBloc;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    // usernameController.text = 'banglatest2@yopmail.com';
    // passwordController.text = '123456';

    // usernameController.text = 'taymoorakbar@outlook.com';
    // passwordController.text = '11111111';
    // usernameController.text = '039a@gmail.com';
    // passwordController.text = '1234567890';

    usernameController.text = 'cafarac102@balaket.com';
    passwordController.text = '11111111';

    // usernameController.text = 'uzair@gmail.com';
    // passwordController.text = '11111111';
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<LoginBloc, LoginState>(
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
        } else if (state is LoginSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else if (state is RefreshState) {}
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoadingState,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: screenSize.height * 0.08,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                AppGlobal.userID = -1;
                                AppGlobal.token = '';
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              },
                              child: const Text('Skip')),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.10,
                      ),
                      Image.asset(
                        'assets/images/BanglaBazarLogo.png',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 26),
                          )),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Sign in to your Banglabazar account',
                            style: TextStyle(
                                color: kColorDarkGreyText, fontSize: 18),
                          )),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: screenSize.height * 0.09,
                        child: TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            floatingLabelStyle:
                                const TextStyle(color: kColorPrimary),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: kColorFieldsBorders,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                  color: kColorPrimary,
                                )),
                            labelText: 'Email address',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        height: screenSize.height * 0.08,
                        child: TextField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: _isObscure
                                    ? const Icon(MyFlutterApp.eye)
                                    : const Icon(MyFlutterApp.eye_off),
                                onPressed: () {
                                  _isObscure = !_isObscure;
                                  _loginBloc.add(RefreshEvent());
                                }),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: kColorFieldsBorders,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                  color: kColorPrimary,
                                )),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor: Colors.grey),
                                  child: Checkbox(
                                    value: rememberMe,
                                    onChanged: (state) {
                                      rememberMe = state!;
                                      if (state == true) {
                                        AppGlobal.rememberMe = 'true';
                                        _loginBloc.add(RefreshEvent());
                                      } else {
                                        AppGlobal.rememberMe = 'false';
                                        _loginBloc.add(RefreshEvent());
                                      }
                                    },
                                    activeColor: kColorPrimary,
                                    checkColor: Colors.white,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                  )),
                              const Text('Keep me signed in',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: InkWell(
                              child: const Text('Forgot password ?'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPasswordScreen()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.18,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => HomePage()),
                          // );
                          if (validate()) {
                            _loginBloc.add(LoginUser(
                                username: usernameController.text.trim(),
                                password: passwordController.text.trim()));
                          }
                        },
                        child: Container(
                            height: screenSize.height * 0.065,
                            width: screenSize.width * 0.90,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: kColorPrimary,
                            ),
                            child: const Center(
                                child: Text(
                              'Sign in',
                              style:
                                  TextStyle(color: kColorWhite, fontSize: 20),
                            ))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       height: 1,
                      //       width: screenSize.width * 0.40,
                      //       color: kColorFieldsBorders,
                      //     ),
                      //     const Text(
                      //       '  OR  ',
                      //       style: TextStyle(color: kColorFieldsBorders),
                      //     ),
                      //     Container(
                      //       height: 1,
                      //       width: screenSize.width * 0.40,
                      //       color: kColorFieldsBorders,
                      //     )
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // InkWell(
                      //   onTap: () {},
                      //   child: Container(
                      //       height: screenSize.height * 0.065,
                      //       width: screenSize.width * 0.90,
                      //       padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      //       decoration: BoxDecoration(
                      //         border: Border.all(color: kColorFieldsBorders),
                      //         borderRadius: BorderRadius.circular(6),
                      //         color: kColorWhite,
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Image.asset(
                      //             'assets/images/GoogleIcon.png',
                      //             height: 25,
                      //             width: 25,
                      //           ),
                      //           const Text(
                      //             '  Sign in with Google',
                      //             style: TextStyle(
                      //                 color: Colors.black, fontSize: 20),
                      //           ),
                      //         ],
                      //       )),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          const Text('Does not have account?'),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen(
                                          previousPage: 'UserSignUp',
                                        )),
                              );
                            },
                            child: const Text(
                              ' Sign Up',
                              style: TextStyle(color: kColorPrimary),
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  bool validate() {
    if (usernameController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: 'Email field is empty',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade400,
          textColor: Colors.white,
          fontSize: 12.0);
      return false;
    } else if ((!usernameController.text.contains('@') ||
        !usernameController.text.contains('.com'))) {
      Fluttertoast.showToast(
          msg: 'Email format is not valid',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade400,
          textColor: Colors.white,
          fontSize: 12.0);
      return false;
    } else if (passwordController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: 'Password field is empty',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade400,
          textColor: Colors.white,
          fontSize: 12.0);
      return false;
    }
    return true;
  }
}

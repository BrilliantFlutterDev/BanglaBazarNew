import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/code_verfication.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginBloc/login_bloc.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginscreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

class SignupScreen extends StatefulWidget {
  String? previousPage;
  SignupScreen({Key? key, this.previousPage}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<SignupScreen> {
  FlutterSecureStorage storage = FlutterSecureStorage();

  bool _isObscure = true;
  bool _isObscureConfirmPassword = true;
  bool visible = false;
  final _key = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late LoginBloc _loginBloc;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    getDeviceIP();
  }

  Future<void> getDeviceIP() async {
    var wifiIP = await WifiInfo().getWifiIP();
    AppGlobal.ipAddress = wifiIP!;
    print('>>>>>>>Device IP Address: ${AppGlobal.ipAddress}');
  }

  bool validate() {
    if (fullNameController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: 'Full Name field is empty',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade400,
          textColor: Colors.white,
          fontSize: 12.0);
      return false;
    } else if ((!emailController.text.contains('@') ||
        !emailController.text.contains('.com'))) {
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
    } else if (passwordController.text != confirmPasswordController.text) {
      Fluttertoast.showToast(
          msg: 'Both passwords are not same',
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
        } else if (state is SignUpSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CodeVerificationScreen(
                      moduleName: 'registerUser',
                      userEmail: emailController.text.trim(),
                    )),
          );
        }
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
                      widget.previousPage == 'UserSignUp'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Skip')),
                              ],
                            )
                          : SizedBox(),
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
                          child: Text(
                            '${widget.previousPage == 'UserSignUp' ? '' : 'Driver '}Sign up',
                            style: TextStyle(fontSize: 26),
                          )),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Create your account',
                            style: TextStyle(
                                color: kColorDarkGreyText, fontSize: 18),
                          )),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: screenSize.height * 0.09,
                        child: TextField(
                          controller: fullNameController,
                          textCapitalization: TextCapitalization.words,
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
                            labelText: 'Full Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: screenSize.height * 0.09,
                        child: TextField(
                          controller: emailController,
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
                            labelText: 'Email',
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
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
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
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        height: screenSize.height * 0.09,
                        child: TextField(
                          obscureText: _isObscureConfirmPassword,
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: _isObscureConfirmPassword
                                    ? const Icon(MyFlutterApp.eye)
                                    : const Icon(MyFlutterApp.eye_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscureConfirmPassword =
                                        !_isObscureConfirmPassword;
                                  });
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
                            labelText: 'Confirm Password',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                'By creating an account, you agree to BanglaBazar\'s'),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                Text(
                                  'Conditions of Use ',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                Text('and '),
                                Text(
                                  'Privacy Notice.',
                                  style: TextStyle(color: Colors.blueAccent),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          if (widget.previousPage == 'UserSignUp') {
                            if (validate()) {
                              _loginBloc.add(SignUpUser(
                                  username: fullNameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim()));
                            }
                          } else {
                            ///Code for driver signUp
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
                              'Sign up',
                              style:
                                  TextStyle(color: kColorWhite, fontSize: 20),
                            ))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      widget.previousPage == 'UserSignUp'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 1,
                                  width: screenSize.width * 0.40,
                                  color: kColorFieldsBorders,
                                ),
                                const Text(
                                  '  OR  ',
                                  style: TextStyle(color: kColorFieldsBorders),
                                ),
                                Container(
                                  height: 1,
                                  width: screenSize.width * 0.40,
                                  color: kColorFieldsBorders,
                                )
                              ],
                            )
                          : SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      widget.previousPage == 'UserSignUp'
                          ? InkWell(
                              onTap: () {},
                              child: Container(
                                  height: screenSize.height * 0.065,
                                  width: screenSize.width * 0.90,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: kColorFieldsBorders),
                                    borderRadius: BorderRadius.circular(6),
                                    color: kColorWhite,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/GoogleIcon.png',
                                        height: 25,
                                        width: 25,
                                      ),
                                      const Text(
                                        '  Sign up with Google',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ],
                                  )),
                            )
                          : SizedBox(),
                      const SizedBox(
                        height: 30,
                      ),
                      widget.previousPage == 'UserSignUp'
                          ? Row(
                              children: <Widget>[
                                const Text('Already have account?'),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    ' Sign in',
                                    style: TextStyle(color: kColorPrimary),
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            )
                          : SizedBox(),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}

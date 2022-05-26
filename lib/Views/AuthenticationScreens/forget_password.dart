import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/code_verfication.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginBloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<ForgetPasswordScreen> {
  FlutterSecureStorage storage = FlutterSecureStorage();

  bool visible = false;
  TextEditingController emailController = TextEditingController();
  final _key = GlobalKey<FormState>();

  late LoginBloc _loginBloc;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  bool validate() {
    if (emailController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: 'Email field is empty',
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
        } else if (state is ForgetPasswordOTPSendSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CodeVerificationScreen(
                      moduleName: 'forgetPassword',
                      userEmail: emailController.text,
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
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back)),
                          const Text(
                            '  Back',
                            style: TextStyle(color: Colors.black, fontSize: 21),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.06,
                      ),
                      Image.asset(
                        'assets/images/BanglaBazarLogo.png',
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Forgot your password?',
                            style: TextStyle(fontSize: 26),
                          )),
                      Container(
                          alignment: Alignment.center,
                          child: const Text(
                            ' We can help.',
                            style: TextStyle(fontSize: 26),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Enter the email address for your BanglaBazar account. We\'ll send a verification code for you to enter before signing in.',
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            style: TextStyle(
                                color: kColorDarkGreyText, fontSize: 18),
                          )),
                      const SizedBox(
                        height: 30,
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
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          if (validate()) {
                            _loginBloc.add(ForgetPasswordSendOTP(
                              email: emailController.text.trim(),
                            ));
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
                              'Submit',
                              style:
                                  TextStyle(color: kColorWhite, fontSize: 20),
                            ))),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.15,
                      ),
                      Row(
                        children: <Widget>[
                          const Text('Remember your password?'),
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

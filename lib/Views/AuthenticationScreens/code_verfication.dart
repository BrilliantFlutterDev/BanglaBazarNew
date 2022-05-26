import 'dart:async';

import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginBloc/login_bloc.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginscreen.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/new_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeVerificationScreen extends StatefulWidget {
  final String moduleName;
  final String userEmail;
  const CodeVerificationScreen(
      {Key? key, required this.moduleName, required this.userEmail})
      : super(key: key);

  @override
  _CodeVerificationState createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerificationScreen> {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  bool visible = false;
  TextEditingController textEditingController = TextEditingController();
  late StreamController<ErrorAnimationType> errorController;
  final _key = GlobalKey<FormState>();

  late LoginBloc _loginBloc;
  late String _verificationCode;
  late String _noOfDigits;

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    if (widget.moduleName == 'phoneChangeEditProfile') {
      _noOfDigits = 'six';
    } else {
      _noOfDigits = 'five';
    }
    if (widget.moduleName == 'phoneChangeEditProfile') {
      _verifyPhone();
    }
  }

  bool validate() {
    if (textEditingController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: 'Fields are empty',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade400,
          textColor: Colors.white,
          fontSize: 12.0);
      return false;
    } else if (textEditingController.text.length < 5) {
      Fluttertoast.showToast(
          msg: 'Entered OTP is too short',
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

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.userEmail,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print('Number verified');
              //kPhoneNumber =  '+923157682007';
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => NewPassword(
              //         appBarHeading: widget.newPassword == false
              //             ? 'Password'
              //             : 'New Password',
              //         fieldsTitle: widget.newPassword == false
              //             ? 'Password'
              //             : 'New Password',
              //         newPassword: widget.newPassword,
              //       ),
              //     ),
              //         (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 60),
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            _verificationCode = verificationId;
          });
        });
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
        } else if (state is ChangeEmailVerified) {
          Fluttertoast.showToast(
              msg: 'Email verified successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey.shade400,
              textColor: Colors.white,
              fontSize: 12.0);
          AppGlobal.emailChangeVerified = true;
          AppGlobal.emailVerified = 'Y';

          Navigator.pop(context);
        } else if (state is SignUpVerifyOTP) {
          print('|||||||||');
          if (widget.moduleName == 'registerUser') {
            Fluttertoast.showToast(
                msg: 'SignUp Successful',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade400,
                textColor: Colors.white,
                fontSize: 12.0);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false);
          } else if (widget.moduleName == 'forgetPassword') {
            Fluttertoast.showToast(
                msg: 'OTP successfully verified',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade400,
                textColor: Colors.white,
                fontSize: 12.0);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPasswordScreen(
                  email: widget.userEmail,
                ),
              ),
            );
          }
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
                              child: const Icon(
                                Icons.arrow_back,
                              )),
                          const Text(
                            '  Back',
                            style: TextStyle(color: Colors.black, fontSize: 21),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      Image.asset(
                        'assets/images/CodeVerificationLogo.png',
                        height: screenSize.height * 0.2,
                        width: screenSize.height * 0.2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Please verify account',
                            style: TextStyle(fontSize: 26),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Enter the $_noOfDigits digit code we sent to your email address to verify your new BanglaBazar account.',
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            style: const TextStyle(
                                color: kColorDarkGreyText, fontSize: 18),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: const TextStyle(
                            color: kColorWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          length: widget.moduleName == 'phoneChangeEditProfile'
                              ? 6
                              : 5,
                          obscureText: false,
                          obscuringCharacter: '*',
                          animationType: AnimationType.fade,
                          validator: (v) {
                            // if (v.length < 3) {
                            //   return "I'm from validator";
                            // } else {
                            //   return null;
                            // }
                          },
                          pinTheme: PinTheme(
                            activeColor: kColorPrimary,
                            selectedFillColor: Colors.white,
                            selectedColor: kColorPrimary,
                            disabledColor: Colors.red,
                            inactiveFillColor: Colors.white,
                            inactiveColor: kColorFieldsBorders,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 60,
                            fieldWidth: 50,
                            activeFillColor: Colors.white,
                          ),
                          cursorColor: kColorPrimary,

                          animationDuration: const Duration(milliseconds: 300),
                          textStyle: const TextStyle(fontSize: 20, height: 1.6),
                          backgroundColor: Colors.white,
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          // boxShadows: const [
                          //   BoxShadow(
                          //     offset: Offset(0, 1),
                          //     color: Colors.black12,
                          //     blurRadius: 10,
                          //   )
                          // ],
                          onCompleted: (v) {
                            print("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              //currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () async {
                          if (widget.moduleName == 'registerUser') {
                            if (validate()) {
                              _loginBloc.add(VerifyOTPSignUpUser(
                                  email: widget.userEmail,
                                  otp: textEditingController.text));
                            }
                          } else if (widget.moduleName == 'forgetPassword') {
                            if (validate()) {
                              _loginBloc.add(VerifyOTPForgetPassword(
                                  email: widget.userEmail,
                                  otp: textEditingController.text));
                            }
                          } else if (widget.moduleName ==
                              'emailChangeEditProfile') {
                            if (validate()) {
                              _loginBloc.add(VerifyChangeEmailEditProfile(
                                  email: widget.userEmail,
                                  otp: textEditingController.text));
                            }
                          } else if (widget.moduleName ==
                              'phoneChangeEditProfile') {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId: _verificationCode,
                                          smsCode: textEditingController.text))
                                  .then((value) async {
                                if (value.user != null) {
                                  Fluttertoast.showToast(
                                      msg: 'OTP code accepted',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey.shade400,
                                      textColor: Colors.white,
                                      fontSize: 12.0);
                                  AppGlobal.phoneVerified = 'Y';
                                  AppGlobal.phoneChangeVerify = true;
                                  AppGlobal.phoneNumber = widget.userEmail;
                                  Navigator.pop(context);
                                }
                                // else {
                                //   widget.parentScaffoldKey.currentState.showSnackBar(
                                //       SnackBar(content: Text('invalid OTP')));
                                // }
                              });
                            } catch (e) {
                              // Fluttertoast.showToast(msg: 'Invalid OTP code');
                              Fluttertoast.showToast(
                                  msg: 'Entered OTP is invalid',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey.shade400,
                                  textColor: Colors.white,
                                  fontSize: 12.0);
                            }
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
                              'Verify & Continue',
                              style:
                                  TextStyle(color: kColorWhite, fontSize: 20),
                            ))),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('It may take a minute to receive your code.'),
                      Row(
                        children: <Widget>[
                          const Text('Haven\'t received any code ?'),
                          InkWell(
                            onTap: () {
                              if (widget.moduleName ==
                                  'phoneChangeEditProfile') {
                                _verifyPhone();
                                Fluttertoast.showToast(
                                    msg: 'OTP resend successfully',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey.shade400,
                                    textColor: Colors.white,
                                    fontSize: 12.0);
                              } else {
                                _loginBloc.add(ResendOTPSignUpUser(
                                  email: widget.userEmail,
                                ));
                              }
                            },
                            child: const Text(
                              ' Resend a new code.',
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

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }
}

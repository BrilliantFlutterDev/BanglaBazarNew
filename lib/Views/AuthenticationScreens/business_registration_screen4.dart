import 'dart:io';

import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/code_verfication.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginBloc/login_bloc.dart';
import 'package:bangla_bazar/Views/main_home_page.dart';
import 'package:bangla_bazar/Widgets/bottom_sheet_choose_pic_source_widget.dart';
import 'package:bangla_bazar/Widgets/photo_avatar.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class BusinessRegistrationScreen4 extends StatefulWidget {
  const BusinessRegistrationScreen4({
    Key? key,
  }) : super(key: key);
  @override
  _BusinessRegistrationScreen4State createState() =>
      _BusinessRegistrationScreen4State();
}

class _BusinessRegistrationScreen4State
    extends State<BusinessRegistrationScreen4> {
  late LoginBloc _loginBloc;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  late String businessTypeValueChoose = '';
  List<String> bTypeList = ['Hole Sale', 'Retail'];
  late String _chooseCountryCode = '';

  PhoneNumber phoneNumber = PhoneNumber();
  final TextEditingController controller = TextEditingController();

  late DateTime pickedDate;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();

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
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
            backgroundColor: kColorWhite,
            // extendBody: true,
            // resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                ///This is the body
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          // color: Colors.yellow,
                          width: screenSize.width,
                          height: screenSize.height * 0.18,
                        ),
                        const Text(
                          'Business Registration',
                          style: TextStyle(fontSize: 22),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenSize.width * 0.80,
                          child: const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, color: kColorDarkGreyText),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kColorPrimary,
                                // border: Border.all(
                                //     color: kColorDarkGreyText, width: 3),
                                // image: DecorationImage(
                                //   image: Image.asset("assets/icons/eyeicon.png",),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: const Center(
                                  child: Icon(
                                Icons.done,
                                color: kColorWhite,
                                size: 18,
                              )),
                            ),
                            Container(
                              height: 1,
                              width: screenSize.width * 0.26,
                              color: kColorFieldsBorders,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kColorPrimary,
                                // border: Border.all(
                                //     color: kColorFieldsBorders, width: 1),
                                // image: DecorationImage(
                                //   image: Image.asset("assets/icons/eyeicon.png",),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.done,
                                  color: kColorWhite,
                                  size: 18,
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              width: screenSize.width * 0.26,
                              color: kColorFieldsBorders,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kColorPrimary,
                                // border: Border.all(
                                //     color: kColorFieldsBorders, width: 1),
                                // image: DecorationImage(
                                //   image: Image.asset("assets/icons/eyeicon.png",),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: const Center(
                                  child: Icon(
                                Icons.done,
                                color: kColorWhite,
                                size: 18,
                              )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Business Info',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Container(
                              //height: 1,
                              width: screenSize.width * 0.13,
                              //color: kColorDarkGreyText,
                            ),
                            const Text(
                              'Store Info',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Container(
                              //height: 1,
                              width: screenSize.width * 0.13,
                              //color: kColorDarkGreyText,
                            ),
                            const Text(
                              'Verification',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenSize.height * 0.1,
                        ),
                        Image.asset(
                          'assets/images/business-registration-success-image.png',
                          height: screenSize.height * 0.25,
                          width: screenSize.height * 0.25,
                        ),
                        const Text(
                          'Form is Successfully Submitted ',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenSize.width * 0.80,
                          child: const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, color: kColorDarkGreyText),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        // SizedBox(
                        //   height: screenSize.height * 0.01,
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                          child: Container(
                            height: screenSize.height * 0.05,
                            width: screenSize.width * 0.38,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: kColorPrimary,
                            ),
                            child: Center(
                              child: Text(
                                'Back to Home',
                                maxLines: 1,
                                style:
                                    TextStyle(color: kColorWhite, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.2,
                        ),
                      ],
                    ),
                  ),
                ),

                ///This is appbar
                Column(
                  children: [
                    Container(
                      color: kColorWhite,
                      width: screenSize.width,
                      height: screenSize.height * 0.042,
                    ),
                    Container(
                        color: kColorWhite,
                        width: screenSize.width,
                        height: screenSize.height * 0.09,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/BanglaBazarLogo.png',
                                width: screenSize.width * 0.50,
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

  late File _image;
  final picker = ImagePicker();
  late String _imagePath;

  Future getImage(final pickedFileSelected) async {
    final pickedFile = await pickedFileSelected;
    // _userEditRequestModel.profilePic = pickedFile;

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      File rotatedImage =
          await FlutterExifRotation.rotateImage(path: _image.path);

      _image = rotatedImage;

      _loginBloc.add(UploadProfilePic(
        userid: AppGlobal.userID.toString(),
        selectedImage: _image,
      ));

      print('Image Path: $_image');
    } else {
      print('No image selected.');
    }
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (date != null) {
      pickedDate = date;

      print('picked Date' + pickedDate.toString());
      dateOfBirthController.text =
          DateFormat('yyyy-MM-dd').format(pickedDate).toString();
      setState(() {});
    }
  }

  void cameraBottomNavigationSheet() {
    showModalBottomSheet(
        elevation: 5,
        context: context,
        backgroundColor: kColorWidgetBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          var screenSize = MediaQuery.of(context).size;
          return Container(
            height: screenSize.height * 0.30,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      const Text(
                        'Add Profile Pic',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        BottomSheetFilterByWidget(
                          icon: Icons.add_a_photo,
                          buttonLabel: 'Take picture',
                          onPressed: () {
                            Navigator.pop(context);
                            getImage(
                                picker.pickImage(source: ImageSource.camera));
                          },
                        ),
                        BottomSheetFilterByWidget(
                          icon: Icons.add_photo_alternate,
                          buttonLabel: 'Browse gallery',
                          onPressed: () {
                            getImage(
                                picker.pickImage(source: ImageSource.gallery));
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  bool validateEmail() {
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
}

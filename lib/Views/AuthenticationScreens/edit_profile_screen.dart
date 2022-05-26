import 'dart:io';

import 'package:bangla_bazar/ModelClasses/allowed_countries_list_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_city_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_states_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/code_verfication.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginBloc/login_bloc.dart';
import 'package:bangla_bazar/Widgets/bottom_sheet_choose_pic_source_widget.dart';
import 'package:bangla_bazar/Widgets/photo_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileScreen extends StatefulWidget {
  //static const String id = 'chatscreen';
  //final GlobalKey<ScaffoldState> parentScaffoldKey;
  final String previousPage;

  const EditProfileScreen({
    Key? key,
    required this.previousPage,
  }) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late LoginBloc _loginBloc;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  List<String> genderList = ['Male', 'Female'];
  late String genderValueChoose;
  List<String> statusList = ['Active', 'Deactive'];
  late String statusValueChoose;

  late FocusNode phoneNumberFieldFocus = FocusNode();

  late DateTime pickedDate;

  late String _chooseCountryCode = '';

  List<String> allowedCountriesISO2List = [];
  late AllowedCountriesResponse allowedCountriesResponse;
  AllowedVendorStatesResponse allowedVendorStatesResponse =
      AllowedVendorStatesResponse(status: true, states: [
    // States(
    //     StateID: 1,
    //     CountryID: 16,
    //     State: 'Barguna',
    //     Native: 'বরগুনা',
    //     StateCode: 'BRG',
    //     VATTaxRate: '0.00',
    //     FlatDeliveryRate: '0.00',
    //     FlatDeliveryRateKilo: '0.00',
    //     Active: 'Y',
    //     AdminNote: '')
  ]);

  AllowedVendorCityResponse allowedVendorCityResponse =
      AllowedVendorCityResponse(status: true, cities: [
    // Cities(
    //     CityID: 1,
    //     CountryID: 16,
    //     StateID: 8,
    //     City: 'Akhaura',
    //     Native: 'আখাউড়া',
    //     VATTaxRate: '0.00',
    //     FlatDeliveryRate: '0.00',
    //     FlatDeliveryRateKilo: '0.00',
    //     DeliveryPersonAvailable: '',
    //     Active: 'Y',
    //     AdminNote: '')
  ]);

  @override
  void initState() {
    super.initState();
    _askPermission();
    pickedDate = DateTime.now();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginBloc.add(GetVendorAllowedCountries());
    firstNameController.text = AppGlobal.userName;
    emailController.text = AppGlobal.emailAddress;
    phoneNumberController.text =
        AppGlobal.phoneNumber != 'null' ? AppGlobal.phoneNumber : '';
    genderValueChoose = AppGlobal.gender;
    statusValueChoose = AppGlobal.active == 'Y' ? 'Active' : 'Deactive';
    dateOfBirthController.text = AppGlobal.birthDay;
    AppGlobal.phoneChangeVerify = true;
    AppGlobal.emailChangeVerified = true;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is ErrorState) {
        if (state.error == 'OTP is resend to the EmailAddress') {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey.shade400,
              textColor: Colors.white,
              fontSize: 12.0);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CodeVerificationScreen(
                moduleName: 'emailChangeEditProfile',
                userEmail: AppGlobal.emailAddress,
              ),
            ),
          );
        } else {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey.shade400,
              textColor: Colors.white,
              fontSize: 12.0);
        }
      } else if (state is InternetErrorState) {
        Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
      } else if (state is ProfileUpdatedSuccessfully) {
        Fluttertoast.showToast(
            msg: 'Profile image updated successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
        setState(() {});
      } else if (state is SignUpSuccess) {
        Fluttertoast.showToast(
            msg: 'User information updated successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
        Navigator.pop(context);
      } else if (state is EmailCheckedSuccess) {
        print(dateOfBirthController.text);
        if (AppGlobal.emailVerified == 'Y') {
          if (validateEmail()) {
            _loginBloc.add(UpdateUser(
              username: firstNameController.text.trim(),
              email: emailController.text.trim(),
              birthday: dateOfBirthController.text.toString(),
              gender: genderValueChoose,
              phoneVerified: AppGlobal.phoneVerified,
              phoneNumber: AppGlobal.phoneVerified == 'Y'
                  ? _chooseCountryCode + phoneNumberController.text
                  : '',
              emailVerified: AppGlobal.emailChangeVerified == false ? 'N' : 'Y',
            ));
          }
        }
      } else if (state is ForgetPasswordOTPSendSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CodeVerificationScreen(
              moduleName: 'emailChangeEditProfile',
              userEmail: emailController.text,
            ),
          ),
        );
      } else if (state is VendorAllowedCountries) {
        allowedCountriesResponse = state.allowedCountriesResponse;
        for (int i = 0; i < allowedCountriesResponse.countries.length; i++) {
          allowedCountriesISO2List
              .add(allowedCountriesResponse.countries[i].ISO2);
        }

        ///Todo: remove this line on production
        allowedCountriesISO2List.add('PK');
      } else if (state is VendorAllowedCities) {
        allowedVendorCityResponse = state.allowedVendorCityResponse;
        // for (int i = 0; i < allowedCountriesResponse.countries.length; i++) {
        //   allowedCountriesISO2List
        //       .add(allowedCountriesResponse.countries[i].ISO2);
        // }
      } else if (state is VendorAllowedStates) {
        allowedVendorStatesResponse = state.allowedVendorStatesResponse;

        // for (int i = 0; i < allowedCountriesResponse.countries.length; i++) {
        //   allowedCountriesISO2List
        //       .add(allowedCountriesResponse.countries[i].ISO2);
        // }
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
                  child: Column(
                    children: [
                      SizedBox(
                        // color: Colors.yellow,
                        width: screenSize.width,
                        height: screenSize.height * 0.13,
                      ),
                      Container(
                        height: screenSize.height * 0.30,
                        width: screenSize.width,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: screenSize.height * 0.15,
                                  width: screenSize.width,
                                  color: kColorWidgetBackgroundColor,
                                ),
                                Container(
                                  height: screenSize.height * 0.15,
                                  width: screenSize.width,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: screenSize.height * 0.15,
                                  height: screenSize.height * 0.15,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: kColorPrimary,
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(60),
                                    //color: kColorPrimary,
                                  ),
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    child: CachedNetworkImage(
                                      imageUrl: AppGlobal.photosBaseURL +
                                          AppGlobal.profilePic,
                                      imageBuilder: (context, imageProvider) =>
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
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: screenSize.height * 0.1,
                                      left: screenSize.height * 0.11),
                                  child: InkWell(
                                    onTap: () {
                                      cameraBottomNavigationSheet();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: kColorWhite,
                                          width: 2.0,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 1.0,
                                            color: kColorPrimary,
                                          )
                                        ],
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: kColorPrimary,
                                        radius: screenSize.height * 0.02,
                                        child: Icon(
                                          Icons.camera_alt_rounded,
                                          color: Colors.white,
                                          size: screenSize.height * 0.025,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Personal Information',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'First Name',
                                style: TextStyle(
                                    fontSize: 14, color: kColorFieldsBorders),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: screenSize.height * 0.06,
                              child: TextField(
                                controller: firstNameController,
                                textCapitalization: TextCapitalization.words,
                                style:
                                    const TextStyle(color: kColorDarkGreyText),
                                decoration: InputDecoration(
                                  // floatingLabelStyle:
                                  // const TextStyle(color: kColorPrimary),
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
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Date of Birth',
                                style: TextStyle(
                                    fontSize: 14, color: kColorFieldsBorders),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Stack(
                              alignment: AlignmentDirectional.centerEnd,
                              children: [
                                Container(
                                  height: screenSize.height * 0.06,
                                  child: TextField(
                                    controller: dateOfBirthController,
                                    style: const TextStyle(
                                        color: kColorDarkGreyText),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        // floatingLabelStyle:
                                        // const TextStyle(color: kColorPrimary),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: const BorderSide(
                                            color: kColorFieldsBorders,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            borderSide: const BorderSide(
                                              color: kColorPrimary,
                                            )),
                                        hintText: '--/--/----',
                                        hintStyle: const TextStyle(
                                            color: kColorFieldsBorders)),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      _pickDate();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(MyFlutterApp
                                            .icon_calendar_outlined),
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Gender',
                                style: TextStyle(
                                    fontSize: 14, color: kColorFieldsBorders),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: screenSize.width * 0.93,
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                  width: 1,
                                  color:
                                      kColorFieldsBorders, //                   <--- border width here
                                ),
                              ),
                              child: DropdownButton(
                                hint: Text(
                                    genderValueChoose == 'Null'
                                        ? 'Choose your gender'
                                        : genderValueChoose,
                                    style: const TextStyle(
                                      color: kColorDarkGreyText,
                                    )),
                                isExpanded: true,
                                underline: const SizedBox(),
                                dropdownColor: kColorWidgetBackgroundColor,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: kColorDarkGreyIcon,
                                  size: 25,
                                ),
                                iconSize: 36,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                onChanged: (valueItem) {},
                                items: genderList.map((valueItem) {
                                  return DropdownMenuItem(
                                    child: Text(valueItem),
                                    value: valueItem,
                                    onTap: () {
                                      setState(() {
                                        genderValueChoose = valueItem;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Phone Number',
                                style: TextStyle(
                                    fontSize: 14, color: kColorFieldsBorders),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    width: screenSize.width * 0.25,
                                    height: screenSize.height * 0.06,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: kColorFieldsBorders, width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                      color: kColorWhite,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _chooseCountryCode == ''
                                              ? 'CC'
                                              : _chooseCountryCode,
                                          style: const TextStyle(
                                            color: kColorDarkGreyText,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: kColorDarkGreyText,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    _countryCodePickerDialog(
                                        deliveryPhone: false);
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: screenSize.height * 0.06,
                                  width: screenSize.width * 0.63,
                                  child: TextField(
                                    controller: phoneNumberController,
                                    focusNode: phoneNumberFieldFocus,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ], // Only numbers can be entered
                                    onChanged: (value) {
                                      if (AppGlobal.phoneNumber !=
                                          _chooseCountryCode +
                                              phoneNumberController.text
                                                  .trim()) {
                                        AppGlobal.phoneChangeVerify = false;
                                      } else {
                                        AppGlobal.phoneChangeVerify = true;
                                      }
                                      setState(() {});
                                    },
                                    style: const TextStyle(
                                        color: kColorDarkGreyText),
                                    decoration: InputDecoration(
                                        // floatingLabelStyle:
                                        // const TextStyle(color: kColorPrimary),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: const BorderSide(
                                            color: kColorFieldsBorders,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            borderSide: const BorderSide(
                                              color: kColorPrimary,
                                            )),
                                        hintText: 'Add number',
                                        hintStyle: const TextStyle(
                                            color: kColorFieldsBorders)),
                                  ),
                                ),
                              ],
                            ),
                            AppGlobal.phoneVerified == 'N' ||
                                    AppGlobal.phoneChangeVerify == false
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // _loginBloc.add(ResendOTPSignUpUser(
                                          //   email: AppGlobal.emailAddress,
                                          // ));
                                          if (_chooseCountryCode.length > 1 &&
                                              phoneNumberController
                                                      .text.length >
                                                  7) {
                                            //phoneNumberFieldFocus.unfocus();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CodeVerificationScreen(
                                                  moduleName:
                                                      'phoneChangeEditProfile',
                                                  userEmail:
                                                      _chooseCountryCode +
                                                          phoneNumberController
                                                              .text,
                                                ),
                                              ),
                                            );
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Please enter a valid phone number',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    Colors.grey.shade400,
                                                textColor: Colors.white,
                                                fontSize: 12.0);
                                          }
                                        },
                                        child: Column(
                                          children: const [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'Note:Phone Number not verified. To update profile you have to verify the number first. ',
                                                    style: TextStyle(
                                                        color:
                                                            kColorFieldsBorders),
                                                  ),
                                                  TextSpan(
                                                    text: 'Verify number?',
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 25,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Status',
                                style: TextStyle(
                                    fontSize: 14, color: kColorFieldsBorders),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: screenSize.width * 0.93,
                              padding: EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                  width: 1,
                                  color:
                                      kColorFieldsBorders, //                   <--- border width here
                                ),
                              ),
                              child: DropdownButton(
                                hint: Text(
                                  statusValueChoose,
                                  style: const TextStyle(
                                    color: kColorDarkGreyText,
                                  ),
                                ),
                                isExpanded: true,
                                underline: const SizedBox(),
                                dropdownColor: kColorWidgetBackgroundColor,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: kColorDarkGreyIcon,
                                  size: 25,
                                ),
                                iconSize: 36,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                onChanged: (valueItem) {},
                                items: statusList.map((valueItem) {
                                  return DropdownMenuItem(
                                    child: Text(valueItem),
                                    value: valueItem,
                                    onTap: () {
                                      setState(() {
                                        statusValueChoose = valueItem;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.07,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Email & Password',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 14, color: kColorFieldsBorders),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: screenSize.height * 0.06,
                              child: TextField(
                                controller: emailController,
                                readOnly: AppGlobal.emailVerified == 'N'
                                    ? true
                                    : false,
                                onChanged: (value) {
                                  if (AppGlobal.emailAddress !=
                                      emailController.text.trim()) {
                                    AppGlobal.emailChangeVerified = false;
                                  } else {
                                    AppGlobal.emailChangeVerified = true;
                                  }
                                  setState(() {});
                                },
                                style:
                                    const TextStyle(color: kColorDarkGreyText),
                                decoration: InputDecoration(
                                  // floatingLabelStyle:
                                  // const TextStyle(color: kColorPrimary),
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
                                ),
                              ),
                            ),
                            AppGlobal.emailVerified == 'N' ||
                                    AppGlobal.emailChangeVerified == false
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (emailController.text.length > 5) {
                                            _loginBloc.add(ResendOTPSignUpUser(
                                              email: emailController.text,
                                            ));
                                          }
                                        },
                                        child: Column(
                                          children: const [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'Note:Email not verified. To update profile you have to verify the email first. ',
                                                    style: TextStyle(
                                                        color:
                                                            kColorFieldsBorders),
                                                  ),
                                                  TextSpan(
                                                    text: 'Verify email?',
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 25,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  // phoneNumberController.text =
                                  //     _chooseCountryCode +
                                  //         phoneNumberController.text;

                                  if (AppGlobal.phoneVerified == 'Y' &&
                                      AppGlobal.emailVerified == 'Y' &&
                                      AppGlobal.phoneChangeVerify == true) {
                                    if (validateEmail()) {
                                      _loginBloc.add(CheckEmailAvailability(
                                        email: AppGlobal.emailAddress,
                                      ));
                                    }
                                  }
                                },
                                child: Container(
                                  height: screenSize.height * 0.065,
                                  width: screenSize.width * 0.35,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: AppGlobal.emailVerified != 'Y' ||
                                            AppGlobal.phoneVerified != 'Y' ||
                                            AppGlobal.phoneChangeVerify == false
                                        ? kColorWidgetBackgroundColor
                                        : kColorPrimary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Save Changes',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppGlobal.emailVerified ==
                                                      'N' ||
                                                  AppGlobal.phoneVerified !=
                                                      'Y' ||
                                                  AppGlobal.phoneChangeVerify ==
                                                      false
                                              ? kColorDarkGreyText
                                              : kColorWhite,
                                          fontSize: 14),
                                    ),
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
                    ],
                  ),
                ),

                ///This is appbar
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
                            children: [
                              InkWell(
                                child: const Icon(Icons.arrow_back),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const Text(
                                '  Edit Profile',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 21),
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

  Future<void> _askPermission() async {
    PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      print('Permission granted');
    }
  }

  Future<PermissionStatus> _getPermission() async {
    PermissionStatus permissionStatus;
    PermissionStatus permission = await Permission.storage.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      permissionStatus = await Permission.storage.request();
    } else {
      permissionStatus = permission;
    }

    return permissionStatus;
  }

  late File _image = File('');
  final picker = ImagePicker();
  late String _imagePath;

  final ImagePicker _picker = ImagePicker();

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
                          onPressed: () async {
                            Navigator.pop(context);
                            // getImage(
                            //     picker.pickImage(source: ImageSource.camera));
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.camera);
                            _loginBloc.add(UploadProfilePic(
                              userid: AppGlobal.userID.toString(),
                              selectedImage: image,
                            ));
                          },
                        ),
                        BottomSheetFilterByWidget(
                          icon: Icons.add_photo_alternate,
                          buttonLabel: 'Browse gallery',
                          onPressed: () async {
                            Navigator.pop(context);
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            _loginBloc.add(UploadProfilePic(
                              userid: AppGlobal.userID.toString(),
                              selectedImage: image,
                            ));
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

  void _countryCodePickerDialog({required bool deliveryPhone}) => showDialog(
      context: context,
      builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CountryPickerDialog(
              titlePadding: const EdgeInsets.all(8.0),
              searchCursorColor: Colors.pinkAccent,
              searchInputDecoration:
                  const InputDecoration(hintText: 'Search...'),
              isSearchable: true,
              title: const Text('Select your phone code'),
              onValuePicked: (country) {
                if (deliveryPhone == false) {
                  _chooseCountryCode = '+' + country.phoneCode;
                }
                setState(() {});
              },

              itemFilter: (c) => allowedCountriesISO2List.contains(c.isoCode),
              itemBuilder: _buildDialogItem,
              // priorityList: [
              //   CountryPickerUtils.getCountryByIsoCode('TR'),
              //   CountryPickerUtils.getCountryByIsoCode('US'),
              // ],
            ),
          ));
  Widget _buildDialogItem(country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          const SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );
}

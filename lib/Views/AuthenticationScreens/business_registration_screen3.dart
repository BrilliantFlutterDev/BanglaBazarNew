import 'dart:io';
import 'package:bangla_bazar/ModelClasses/AddNewBusinessPage2Model.dart';
import 'package:bangla_bazar/ModelClasses/AddNewBussinessPage1Model.dart';
import 'package:bangla_bazar/ModelClasses/allowed_countries_list_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_city_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_states_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_access_token_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_area_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_area_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_cities_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_token_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_zone_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_zones_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/business_registration_screen4.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/code_verfication.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginBloc/login_bloc.dart';
import 'package:bangla_bazar/Views/main_home_page.dart';
import 'package:bangla_bazar/Widgets/bottom_sheet_choose_pic_source_widget.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class BusinessRegistrationScreen3 extends StatefulWidget {
  final String processNumber;
  AddBusinessPage1Data? addBusinessPage1Data;
  AllowedCountriesResponse allowedCountriesResponse;
  AllowedVendorStatesResponse allowedVendorStatesResponse;
  AllowedVendorCityResponse allowedVendorCityResponse;
  List<String> allowedCountriesISO2List;
  bool businessAlreadyExist = false;
  BusinessRegistrationScreen3(
      {Key? key,
      required this.processNumber,
      this.addBusinessPage1Data,
      required this.allowedCountriesResponse,
      required this.allowedVendorStatesResponse,
      required this.allowedCountriesISO2List,
      required this.allowedVendorCityResponse,
      required this.businessAlreadyExist})
      : super(key: key);
  @override
  _BusinessRegistrationScreen3State createState() =>
      _BusinessRegistrationScreen3State();
}

class _BusinessRegistrationScreen3State
    extends State<BusinessRegistrationScreen3> {
  late LoginBloc _loginBloc;
  TextEditingController storeNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController storeEmailController = TextEditingController();
  TextEditingController storeUrlController = TextEditingController();
  TextEditingController storeFaxController = TextEditingController();

  TextEditingController adminNoteController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  late String businessTypeValueChoose = '';
  List<String> bTypeList = ['Hole Sale', 'Retail'];
  late String _chooseCountryCode = '';

  PhoneNumber phoneNumber = PhoneNumber();
  final TextEditingController controller = TextEditingController();

  late DateTime pickedDate;
  var _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('BD');
  late String selectedState = '';
  late String selectedCity = '';

  late String storeStatusActive = 'Y';
  late AddBusinessPage2Data addBusinessPage2Data;

  late AllowedCountriesResponse allowedCountriesResponse;
  List<String> allowedCountriesISO2List = [];
  bool countrySelected = false;
  late int selectedCountryId = -1;

  PathaoAccessTokenResponse? pathaoAccessTokenResponse;
  PathaoTokenModel? pathaoTokenModel;
  PathaoCitiesResponse pathaoCitiesResponse =
      PathaoCitiesResponse(status: true, cities: []);

  PathaoZoneModel? pathaoZoneModel;
  PathaoZonesResponse pathaoZonesResponse =
      PathaoZonesResponse(status: true, zones: []);

  PathaoAreaModel? pathaoAreaModel;
  PathaoAreaResponse pathaoAreaResponse =
      PathaoAreaResponse(status: true, areas: []);

  late int selectedCityId = 0;
  late int dbSelectedCityId = 0;

  late String selectedZone = '';
  late int selectedZoneId = 0;

  late String selectedArea = '';
  late int selectedAreaId = 0;

  bool verifyEmail = false;
  String tempEmailVerified = '';

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();

    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginBloc.add(GetVendorAllowedCountries());
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
      } else if (state is RegisterBusinessStep1Submitted) {
        ///Call page2 api here
        ///
        print('||||||||||Store registration api is going to hit');
        _loginBloc.add(SubmitBusinessRegistrationPage2Data(
            addBusinessPage2Data: addBusinessPage2Data));
      } else if (state is RegisterBusinessStep2Submitted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BusinessRegistrationScreen4()),
        );
      } else if (state is VendorAllowedCountries) {
        allowedCountriesResponse = state.allowedCountriesResponse;
        for (int i = 0; i < allowedCountriesResponse.countries.length; i++) {
          allowedCountriesISO2List
              .add(allowedCountriesResponse.countries[i].ISO2);
        }
      } else if (state is VendorAllowedCities) {
        widget.allowedVendorCityResponse = state.allowedVendorCityResponse;
        // for (int i = 0; i < allowedCountriesResponse.countries.length; i++) {
        //   allowedCountriesISO2List
        //       .add(allowedCountriesResponse.countries[i].ISO2);
        // }
      } else if (state is VendorAllowedStates) {
        widget.allowedVendorStatesResponse = state.allowedVendorStatesResponse;
        // for (int i = 0; i < allowedCountriesResponse.countries.length; i++) {
        //   allowedCountriesISO2List
        //       .add(allowedCountriesResponse.countries[i].ISO2);
        // }
      } else if (state is PathaoGetAccessTokenState) {
        pathaoAccessTokenResponse = state.pathaoAccessTokenResponse;
        pathaoTokenModel =
            PathaoTokenModel(token: pathaoAccessTokenResponse!.token);
        _loginBloc.add(GetPathaoCities(pathaoTokenModel: pathaoTokenModel!));
      } else if (state is PathaoCitiesState) {
        pathaoCitiesResponse = state.pathaoCitiesResponse;
      } else if (state is PathaoZonesState) {
        pathaoZonesResponse = state.pathaoZonesResponse;
      } else if (state is PathaoAreasState) {
        pathaoAreaResponse = state.pathaoAreaResponse;
      }
      // else if (state is VendorAllowedStates) {
      //
      //
      //   _loginBloc.add(GetVendorAllowedStates(
      //       id: allowedCountriesResponse.countries[i].CountryID));
      //   _loginBloc.add(GetVendorAllowedCities(
      //       id: allowedCountriesResponse.countries[i].CountryID));
      // }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: WillPopScope(
          onWillPop: _onBackPressed,
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
                            'Store Registration',
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
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                        color: kColorWhite, fontSize: 16),
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
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kColorWhite,
                                  border: Border.all(
                                      color: kColorFieldsBorders, width: 1),
                                  // image: DecorationImage(
                                  //   image: Image.asset("assets/icons/eyeicon.png",),
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                        color: kColorFieldsBorders,
                                        fontSize: 16),
                                  ),
                                ),
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Container(
                                //height: 1,
                                width: screenSize.width * 0.13,
                                //color: kColorDarkGreyText,
                              ),
                              const Text(
                                'Store Info',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Container(
                                //height: 1,
                                width: screenSize.width * 0.13,
                                //color: kColorDarkGreyText,
                              ),
                              const Text(
                                'Verification',
                                style: TextStyle(
                                    color: kColorFieldsBorders, fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenSize.height * 0.07,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Store Info',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Store Name',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: screenSize.height * 0.06,
                            child: TextField(
                              controller: storeNameController,
                              textCapitalization: TextCapitalization.words,
                              style: const TextStyle(color: kColorDarkGreyText),
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
                                hintText: 'Enter Store Name',
                                hintStyle:
                                    const TextStyle(color: kColorFieldsBorders),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Store Email',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: screenSize.height * 0.06,
                            child: TextField(
                              controller: storeEmailController,
                              textCapitalization: TextCapitalization.words,
                              style: const TextStyle(color: kColorDarkGreyText),
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
                                hintText: 'Enter Store Email',
                                hintStyle:
                                    const TextStyle(color: kColorFieldsBorders),
                              ),
                            ),
                          ),
                          verifyEmail == false ||
                                  tempEmailVerified != storeEmailController.text
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (validateEmail()) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CodeVerificationScreen(
                                                      moduleName:
                                                          'businessEmailVerification',
                                                      userEmail:
                                                          storeEmailController
                                                              .text
                                                              .trim(),
                                                    )),
                                          );
                                          var result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  CodeVerificationScreen(
                                                moduleName:
                                                    'businessEmailVerification',
                                                userEmail: storeEmailController
                                                    .text
                                                    .trim(),
                                              ),
                                            ),
                                          );
                                          if (result == true) {
                                            verifyEmail = true;
                                            tempEmailVerified =
                                                storeEmailController.text;
                                            setState(() {});
                                          }
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
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Store Phone',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
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
                                  _countryCodePickerDialog();
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: screenSize.height * 0.06,
                                width: screenSize.width * 0.6,
                                child: TextField(
                                  controller: phoneNumberController,
                                  // readOnly: AppGlobal.phoneVerified == 'N'
                                  //     ? true
                                  //     : false,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (value) {
                                    if (AppGlobal.phoneNumber !=
                                        _chooseCountryCode +
                                            phoneNumberController.text.trim()) {
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

                          /// Do after
                          // AppGlobal.phoneVerified == 'N' ||
                          //         AppGlobal.phoneChangeVerify == false
                          //     ? Column(
                          //         children: [
                          //           const SizedBox(
                          //             height: 10,
                          //           ),
                          //           InkWell(
                          //             onTap: () {
                          //               // _loginBloc.add(ResendOTPSignUpUser(
                          //               //   email: AppGlobal.emailAddress,
                          //               // ));
                          //               if (_chooseCountryCode.length > 1 &&
                          //                   phoneNumberController.text.length >
                          //                       7) {
                          //                 Navigator.push(
                          //                   context,
                          //                   MaterialPageRoute(
                          //                     builder: (context) =>
                          //                         CodeVerificationScreen(
                          //                       moduleName:
                          //                           'phoneChangeEditProfile',
                          //                       userEmail: _chooseCountryCode +
                          //                           phoneNumberController.text,
                          //                     ),
                          //                   ),
                          //                 );
                          //               } else {
                          //                 Fluttertoast.showToast(
                          //                     msg:
                          //                         'Please enter a valid phone number',
                          //                     toastLength: Toast.LENGTH_SHORT,
                          //                     gravity: ToastGravity.BOTTOM,
                          //                     timeInSecForIosWeb: 1,
                          //                     backgroundColor:
                          //                         Colors.grey.shade400,
                          //                     textColor: Colors.white,
                          //                     fontSize: 12.0);
                          //               }
                          //             },
                          //             child: Column(
                          //               children: const [
                          //                 Text.rich(
                          //                   TextSpan(
                          //                     children: [
                          //                       TextSpan(
                          //                         text:
                          //                             'Note:Email not verified. To update profile you have to verify the email first. ',
                          //                         style: TextStyle(
                          //                             color: kColorFieldsBorders),
                          //                       ),
                          //                       TextSpan(
                          //                         text: 'Verify email?',
                          //                         style: TextStyle(
                          //                             color: Colors.blue,
                          //                             fontWeight:
                          //                                 FontWeight.bold),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       )
                          //     : SizedBox(),
                          const SizedBox(
                            height: 25,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Address 1',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: address1Controller,
                            textCapitalization: TextCapitalization.words,
                            style: const TextStyle(color: kColorDarkGreyText),
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
                              hintText: 'Enter Address 1',
                              hintStyle:
                                  const TextStyle(color: kColorFieldsBorders),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Address 2',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: address2Controller,
                            textCapitalization: TextCapitalization.words,
                            style: const TextStyle(color: kColorDarkGreyText),
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
                              hintText: 'Enter Address 2',
                              hintStyle:
                                  const TextStyle(color: kColorFieldsBorders),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),

                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Country',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          countrySelected == false
                              ? InkWell(
                                  onTap: _openCountryPickerDialog,
                                  child: Container(
                                    height: screenSize.height * 0.06,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        color: kColorWhite,
                                        border: Border.all(
                                            color: kColorFieldsBorders)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Select Country',
                                            style: TextStyle(
                                                color: kColorFieldsBorders),
                                          ),
                                          Icon(Icons.arrow_drop_down_sharp)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: screenSize.height * 0.068,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: kColorWhite,
                                      border: Border.all(
                                          color: kColorFieldsBorders)),
                                  child: Center(
                                    child: ListTile(
                                      onTap: _openCountryPickerDialog,
                                      title: _buildDialogItem(
                                          _selectedDialogCountry),
                                    ),
                                  ),
                                ),

                          ///
                          // Container(
                          //     height: screenSize.height * 0.065,
                          //     width: screenSize.width * 0.90,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(6.0),
                          //       border: Border.all(
                          //         width: 1,
                          //         color: kColorFieldsBorders,
                          //         //style: BorderStyle.solid,
                          //       ),
                          //     ),
                          //     child: Padding(
                          //       padding:
                          //           const EdgeInsets.symmetric(horizontal: 10),
                          //       child: Row(
                          //         children: [
                          //           Icon(Icons.flag),
                          //           SizedBox(
                          //             width: 7,
                          //           ),
                          //           InkWell(
                          //             onTap: () {
                          //               showCountryPicker(
                          //                 context: context,
                          //                 countryListTheme: CountryListThemeData(
                          //                     backgroundColor: kColorWhite,
                          //                     borderRadius:
                          //                         const BorderRadius.only(
                          //                       topLeft: Radius.circular(20.0),
                          //                       topRight: Radius.circular(20.0),
                          //                     ),
                          //                     inputDecoration: InputDecoration(
                          //                       hintText: 'Search your country',
                          //                       hintStyle: TextStyle(
                          //                           color: Colors.grey.shade400),
                          //                       prefixIcon:
                          //                           const Icon(Icons.search),
                          //                       border: const OutlineInputBorder(
                          //                         borderRadius: BorderRadius.all(
                          //                             Radius.circular(5.0)),
                          //                         borderSide: BorderSide(
                          //                             color: Colors.grey,
                          //                             width: 1),
                          //                       ),
                          //                     ),
                          //                     textStyle: const TextStyle(
                          //                         color: kColorDarkGreyText)),
                          //
                          //                 showPhoneCode:
                          //                     true, // optional. Shows phone code before the country name.
                          //                 onSelect: (Country country) {
                          //                   setState(() {
                          //                     _chooseCountryCode =
                          //                         '+' + country.phoneCode;
                          //                   });
                          //                 },
                          //               );
                          //             },
                          //             child: Icon(
                          //               Icons.keyboard_arrow_down_rounded,
                          //               color: kColorDarkGreyIcon,
                          //               size: 25,
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             width: 7,
                          //           ),
                          //           Text(
                          //             'Bangladesh',
                          //             style: TextStyle(
                          //                 color: kColorDarkGreyText,
                          //                 fontSize: 14),
                          //           )
                          //         ],
                          //       ),
                          //     )),
                          const SizedBox(
                            height: 25,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Zip Code',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: screenSize.height * 0.06,
                            child: TextField(
                              controller: zipCodeController,
                              textCapitalization: TextCapitalization.words,
                              style: const TextStyle(color: kColorDarkGreyText),
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
                                hintText: 'Enter Zip Code',
                                hintStyle:
                                    const TextStyle(color: kColorFieldsBorders),
                              ),
                            ),
                          ),
                          selectedCountryId == 226
                              ? const SizedBox(
                                  height: 25,
                                )
                              : SizedBox(),
                          selectedCountryId == 226
                              ? const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'State',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                )
                              : SizedBox(),
                          selectedCountryId == 226
                              ? const SizedBox(
                                  height: 5,
                                )
                              : SizedBox(),

                          selectedCountryId == 226
                              ? widget.allowedVendorStatesResponse.states
                                      .isNotEmpty
                                  ? Container(
                                      width: screenSize.width * 0.93,
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        border: Border.all(
                                          width: 1,
                                          color:
                                              kColorFieldsBorders, //                   <--- border width here
                                        ),
                                      ),
                                      child: DropdownButton(
                                        hint: Text(
                                            selectedState == ''
                                                ? 'Select'
                                                : selectedState,
                                            style: const TextStyle(
                                              color: kColorDarkGreyText,
                                            )),
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        dropdownColor:
                                            kColorWidgetBackgroundColor,
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
                                        items: widget
                                            .allowedVendorStatesResponse.states
                                            .map((valueItem) {
                                          return DropdownMenuItem(
                                            child: Text(valueItem.State),
                                            value: valueItem,
                                            onTap: () {
                                              setState(() {
                                                selectedState = valueItem.State;
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  : Container(
                                      height: screenSize.height * 0.06,
                                      child: TextField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        onChanged: (value) {
                                          selectedState = value;
                                          //print(selectedState);
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
                                          hintText: 'Enter State',
                                          hintStyle: const TextStyle(
                                              color: kColorFieldsBorders),
                                        ),
                                      ),
                                    )
                              : SizedBox(),
                          selectedCountryId == 16 || selectedCountryId == 226
                              ? const SizedBox(
                                  height: 25,
                                )
                              : const SizedBox(),
                          selectedCountryId == 16 || selectedCountryId == 226
                              ? const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'City',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 5,
                          ),
                          selectedCountryId == 16
                              ? pathaoCitiesResponse.cities.isNotEmpty
                                  ? Container(
                                      width: screenSize.width * 0.93,
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        border: Border.all(
                                          width: 1,
                                          color:
                                              kColorFieldsBorders, //                   <--- border width here
                                        ),
                                      ),
                                      child: DropdownButton(
                                        hint: Text(
                                            selectedCity == ''
                                                ? 'Select'
                                                : selectedCity,
                                            style: const TextStyle(
                                              color: kColorDarkGreyText,
                                            )),
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        dropdownColor:
                                            kColorWidgetBackgroundColor,
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
                                        items: pathaoCitiesResponse.cities
                                            .map((valueItem) {
                                          return DropdownMenuItem(
                                            child: Text(valueItem.cityName),
                                            value: valueItem,
                                            onTap: () {
                                              setState(() {
                                                selectedCity =
                                                    valueItem.cityName;
                                                selectedCityId =
                                                    valueItem.cityId;
                                                dbSelectedCityId =
                                                    valueItem.DBCityID;

                                                selectedZone = '';
                                                selectedZoneId = 0;
                                                pathaoZoneModel = PathaoZoneModel(
                                                    token:
                                                        pathaoAccessTokenResponse!
                                                            .token,
                                                    cityId: selectedCityId
                                                        .toString());
                                                _loginBloc.add(GetPathaoZones(
                                                    pathaoZoneModel:
                                                        pathaoZoneModel!));

                                                // paymentUserData!.cityID = valueItem.CityID;
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  : Container(
                                      height: screenSize.height * 0.06,
                                      child: TextField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        onChanged: (value) {
                                          selectedCity = value;
                                          //print(selectedState);
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
                                          hintText: 'Enter City',
                                          hintStyle: const TextStyle(
                                              color: kColorFieldsBorders),
                                        ),
                                      ),
                                    )
                              : const SizedBox(),
                          selectedCountryId == 226
                              ? widget.allowedVendorCityResponse.cities
                                      .isNotEmpty
                                  ? Container(
                                      width: screenSize.width * 0.93,
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        border: Border.all(
                                          width: 1,
                                          color:
                                              kColorFieldsBorders, //                   <--- border width here
                                        ),
                                      ),
                                      child: DropdownButton(
                                        hint: Text(
                                            selectedCity == ''
                                                ? 'Select'
                                                : selectedCity,
                                            style: const TextStyle(
                                              color: kColorDarkGreyText,
                                            )),
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        dropdownColor:
                                            kColorWidgetBackgroundColor,
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
                                        items: widget
                                            .allowedVendorCityResponse.cities
                                            .map((valueItem) {
                                          return DropdownMenuItem(
                                            child: Text(valueItem.City),
                                            value: valueItem,
                                            onTap: () {
                                              setState(() {
                                                selectedCity = valueItem.City;
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  : Container(
                                      height: screenSize.height * 0.06,
                                      child: TextField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        onChanged: (value) {
                                          selectedCity = value;
                                          //print(selectedState);
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
                                          hintText: 'Enter City',
                                          hintStyle: const TextStyle(
                                              color: kColorFieldsBorders),
                                        ),
                                      ),
                                    )
                              : SizedBox(),
                          const SizedBox(
                            height: 25,
                          ),
                          selectedCountryId == 16
                              ? const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Zone',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                )
                              : const SizedBox(),
                          selectedCountryId == 16
                              ? const SizedBox(
                                  height: 5,
                                )
                              : const SizedBox(),
                          selectedCountryId == 16
                              ? pathaoZonesResponse.zones.isNotEmpty
                                  ? Container(
                                      width: screenSize.width * 0.93,
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        border: Border.all(
                                          width: 1,
                                          color:
                                              kColorFieldsBorders, //                   <--- border width here
                                        ),
                                      ),
                                      child: DropdownButton(
                                        hint: Text(
                                            selectedZone == ''
                                                ? 'Select'
                                                : selectedZone,
                                            style: const TextStyle(
                                              color: kColorDarkGreyText,
                                            )),
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        dropdownColor:
                                            kColorWidgetBackgroundColor,
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
                                        items: pathaoZonesResponse.zones
                                            .map((valueItem) {
                                          return DropdownMenuItem(
                                            child: Text(valueItem.zoneName),
                                            value: valueItem,
                                            onTap: () {
                                              setState(() {
                                                selectedZone =
                                                    valueItem.zoneName;
                                                selectedZoneId =
                                                    valueItem.zoneId;
                                                if (selectedZoneId != 0) {
                                                  selectedArea = '';
                                                  selectedAreaId = 0;
                                                  pathaoAreaModel = PathaoAreaModel(
                                                      token:
                                                          pathaoAccessTokenResponse!
                                                              .token,
                                                      zoneId: selectedZoneId
                                                          .toString());
                                                  _loginBloc.add(GetPathaoAreas(
                                                      pathaoAreaModel:
                                                          pathaoAreaModel!));
                                                }
                                                // paymentUserData!.cityID = valueItem.CityID;
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  : Container(
                                      height: screenSize.height * 0.06,
                                      child: TextField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        onChanged: (value) {
                                          selectedZone = value;
                                          //print(selectedState);
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
                                          hintText: 'Enter Zone',
                                          hintStyle: const TextStyle(
                                              color: kColorFieldsBorders),
                                        ),
                                      ),
                                    )
                              : const SizedBox(),
                          selectedCountryId == 16
                              ? const SizedBox(
                                  height: 25,
                                )
                              : const SizedBox(),
                          selectedCountryId == 16
                              ? const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Area',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                )
                              : const SizedBox(),
                          selectedCountryId == 16
                              ? const SizedBox(
                                  height: 5,
                                )
                              : const SizedBox(),
                          selectedCountryId == 16
                              ? pathaoAreaResponse.areas.isNotEmpty
                                  ? Container(
                                      width: screenSize.width * 0.93,
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        border: Border.all(
                                          width: 1,
                                          color:
                                              kColorFieldsBorders, //                   <--- border width here
                                        ),
                                      ),
                                      child: DropdownButton(
                                        hint: Text(
                                            selectedArea == ''
                                                ? 'Select'
                                                : selectedArea,
                                            style: const TextStyle(
                                              color: kColorDarkGreyText,
                                            )),
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        dropdownColor:
                                            kColorWidgetBackgroundColor,
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
                                        items: pathaoAreaResponse.areas
                                            .map((valueItem) {
                                          return DropdownMenuItem(
                                            child: Text(valueItem.areaName),
                                            value: valueItem,
                                            onTap: () {
                                              setState(() {
                                                selectedArea =
                                                    valueItem.areaName;
                                                selectedAreaId =
                                                    valueItem.areaId;

                                                // paymentUserData!.cityID = valueItem.CityID;
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  : Container(
                                      height: screenSize.height * 0.06,
                                      child: TextField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        onChanged: (value) {
                                          selectedArea = value;
                                          //print(selectedState);
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
                                          hintText: 'Enter Area',
                                          hintStyle: const TextStyle(
                                              color: kColorFieldsBorders),
                                        ),
                                      ),
                                    )
                              : const SizedBox(),
                          selectedCountryId == 16
                              ? const SizedBox(
                                  height: 25,
                                )
                              : const SizedBox(),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Store Fax',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: screenSize.height * 0.06,
                            child: TextField(
                              controller: storeFaxController,
                              textCapitalization: TextCapitalization.words,
                              style: const TextStyle(color: kColorDarkGreyText),
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
                                hintText: 'Enter Store Fax',
                                hintStyle:
                                    const TextStyle(color: kColorFieldsBorders),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Store URL',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: screenSize.height * 0.06,
                            child: TextField(
                              controller: storeUrlController,
                              textCapitalization: TextCapitalization.words,
                              style: const TextStyle(color: kColorDarkGreyText),
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
                                hintText: 'Enter Store URL',
                                hintStyle:
                                    const TextStyle(color: kColorFieldsBorders),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Active',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyIcon,
                                          ),
                                          child: Center(
                                              child: Container(
                                            width: 18,
                                            height: 18,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kColorWhite,
                                            ),
                                            child: Center(
                                                child: Container(
                                              width: 13,
                                              height: 13,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: storeStatusActive == 'Y'
                                                    ? kColorPrimary
                                                    : kColorWhite,
                                              ),
                                            )),
                                          )),
                                        ),
                                        onTap: () {
                                          if (storeStatusActive == 'N') {
                                            setState(() {
                                              storeStatusActive = 'Y';
                                            });
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 75,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyIcon,
                                          ),
                                          child: Center(
                                              child: Container(
                                            width: 18,
                                            height: 18,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kColorWhite,
                                            ),
                                            child: Center(
                                                child: Container(
                                              width: 13,
                                              height: 13,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: storeStatusActive == 'N'
                                                    ? kColorPrimary
                                                    : kColorWhite,
                                              ),
                                            )),
                                          )),
                                        ),
                                        onTap: () {
                                          if (storeStatusActive == 'Y') {
                                            setState(() {
                                              storeStatusActive = 'N';
                                            });
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'No',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  )
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 25,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Admin Note',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),

                          Container(
                            height: screenSize.height * 0.3,
                            width: screenSize.width,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              color: kColorWhite,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                controller: adminNoteController,
                                //focusNode: fObservation,
                                // maxLength: 200,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    //charLength = value.length;
                                  });
                                  //print('$value,$charLength');
                                },
                                maxLines: 8,
                                cursorColor: kColorPrimary,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  // hintText: getTranslated(context,
                                  //     'typeherestartdictation'),
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 20, 40, 0),
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade400),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                        color: kColorFieldsBorders, width: 1),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                        color: kColorFieldsBorders, width: 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _onBackPressed();
                                },
                                child: Container(
                                  height: screenSize.height * 0.065,
                                  width: screenSize.width * 0.43,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border:
                                        Border.all(color: kColorFieldsBorders),
                                    color: kColorWhite,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Previous',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: kColorDarkGreyText,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (selectedCountryId == 226) {
                                    if (storeNameController.text != '') {
                                      if (validateEmail()) {
                                        if (_chooseCountryCode != '') {
                                          if (phoneNumberController.text !=
                                              '') {
                                            if (address1Controller.text != '') {
                                              if (address2Controller.text !=
                                                  '') {
                                                if (zipCodeController.text !=
                                                    '') {
                                                  if (selectedState != '') {
                                                    if (selectedCity != '') {
                                                      if (storeFaxController
                                                              .text !=
                                                          '') {
                                                        if (storeUrlController
                                                                .text !=
                                                            '') {
                                                          if (adminNoteController
                                                                  .text !=
                                                              '') {
                                                            addBusinessPage2Data = AddBusinessPage2Data(
                                                                vendorID: AppGlobal
                                                                    .userID
                                                                    .toString(),
                                                                storeName:
                                                                    storeNameController
                                                                        .text,
                                                                storeEmail:
                                                                    storeEmailController
                                                                        .text,
                                                                storePhoneCode:
                                                                    _chooseCountryCode,
                                                                storephoneNumber:
                                                                    phoneNumberController
                                                                        .text,
                                                                storeAddress1:
                                                                    address1Controller
                                                                        .text,
                                                                storeAddress2:
                                                                    address2Controller
                                                                        .text,
                                                                storeCountry: widget.processNumber == 'store'
                                                                    ? _selectedDialogCountry
                                                                        .name
                                                                    : widget
                                                                        .addBusinessPage1Data!
                                                                        .country,
                                                                storeZipCode:
                                                                    zipCodeController
                                                                        .text,
                                                                storeState:
                                                                    selectedState,
                                                                storeCity:
                                                                    selectedCity,
                                                                storeFax:
                                                                    storeFaxController
                                                                        .text,
                                                                storeURL:
                                                                    storeUrlController
                                                                        .text,
                                                                active:
                                                                    storeStatusActive,
                                                                storeAdminNote:
                                                                    adminNoteController
                                                                        .text);
                                                            if (widget
                                                                    .processNumber ==
                                                                'store') {
                                                              _loginBloc.add(
                                                                  SubmitBusinessRegistrationPage2Data(
                                                                      addBusinessPage2Data:
                                                                          addBusinessPage2Data));
                                                            } else {
                                                              _loginBloc.add(
                                                                  SubmitBusinessRegistrationPage1Data(
                                                                      addBusinessPage1Data:
                                                                          widget
                                                                              .addBusinessPage1Data!));
                                                            }
                                                            // Navigator.push(
                                                            //   context,
                                                            //   MaterialPageRoute(
                                                            //       builder:
                                                            //           (context) =>
                                                            //               BusinessRegistrationScreen4()),
                                                            // );
                                                          } else {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Please enter Admin Note',
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Colors.grey
                                                                        .shade400,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 12.0);
                                                          }
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'Please enter Store URL',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  Colors.grey
                                                                      .shade400,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 12.0);
                                                        }
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'Please enter a Store Fax',
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.grey
                                                                    .shade400,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 12.0);
                                                      }
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Please select a City',
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.grey
                                                                  .shade400,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 12.0);
                                                    }
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'Please select a State',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors
                                                            .grey.shade400,
                                                        textColor: Colors.white,
                                                        fontSize: 12.0);
                                                  }
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Please enter Address 1',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.grey.shade400,
                                                      textColor: Colors.white,
                                                      fontSize: 12.0);
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Please enter Address 2',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.grey.shade400,
                                                    textColor: Colors.white,
                                                    fontSize: 12.0);
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: 'Please enter Address 1',
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      Colors.grey.shade400,
                                                  textColor: Colors.white,
                                                  fontSize: 12.0);
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Please enter a phone number',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    Colors.grey.shade400,
                                                textColor: Colors.white,
                                                fontSize: 12.0);
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Please select a country code',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Colors.grey.shade400,
                                              textColor: Colors.white,
                                              fontSize: 12.0);
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Please enter a valid email',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                Colors.grey.shade400,
                                            textColor: Colors.white,
                                            fontSize: 12.0);
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Please enter store name',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey.shade400,
                                          textColor: Colors.white,
                                          fontSize: 12.0);
                                    }
                                  } else {
                                    if (storeNameController.text != '') {
                                      if (validateEmail()) {
                                        if (_chooseCountryCode != '') {
                                          if (phoneNumberController.text !=
                                              '') {
                                            if (address1Controller.text != '') {
                                              if (address2Controller.text !=
                                                  '') {
                                                if (zipCodeController.text !=
                                                    '') {
                                                  if (selectedZone != '') {
                                                    if (selectedCity != '') {
                                                      if (selectedArea != '') {
                                                        if (storeFaxController
                                                                .text !=
                                                            '') {
                                                          if (storeUrlController
                                                                  .text !=
                                                              '') {
                                                            if (adminNoteController
                                                                    .text !=
                                                                '') {
                                                              addBusinessPage2Data = AddBusinessPage2Data(
                                                                  vendorID: AppGlobal
                                                                      .userID
                                                                      .toString(),
                                                                  storeName:
                                                                      storeNameController
                                                                          .text,
                                                                  storeEmail:
                                                                      storeEmailController
                                                                          .text,
                                                                  storePhoneCode:
                                                                      _chooseCountryCode,
                                                                  storephoneNumber:
                                                                      phoneNumberController
                                                                          .text,
                                                                  storeAddress1:
                                                                      address1Controller
                                                                          .text,
                                                                  storeAddress2:
                                                                      address2Controller
                                                                          .text,
                                                                  storeCountry: widget.processNumber == 'store'
                                                                      ? _selectedDialogCountry
                                                                          .name
                                                                      : widget
                                                                          .addBusinessPage1Data!
                                                                          .country,
                                                                  storeZipCode:
                                                                      zipCodeController
                                                                          .text,
                                                                  storeState:
                                                                      selectedState,
                                                                  storeCity:
                                                                      selectedCity,
                                                                  storeFax:
                                                                      storeFaxController
                                                                          .text,
                                                                  storeURL:
                                                                      storeUrlController
                                                                          .text,
                                                                  active:
                                                                      storeStatusActive,
                                                                  storeAdminNote:
                                                                      adminNoteController
                                                                          .text,
                                                                  dbPathaoCityId:
                                                                      dbSelectedCityId,
                                                                  pathaoCityId:
                                                                      selectedCityId,
                                                                  pathaoZoneId:
                                                                      selectedZoneId,
                                                                  pathaoAreaId:
                                                                      selectedAreaId,
                                                                  pathaoAccessToken:
                                                                      pathaoAccessTokenResponse!
                                                                          .token);
                                                              if (widget
                                                                      .processNumber ==
                                                                  'store') {
                                                                _loginBloc.add(
                                                                    SubmitBusinessRegistrationPage2Data(
                                                                        addBusinessPage2Data:
                                                                            addBusinessPage2Data));
                                                              } else {
                                                                _loginBloc.add(
                                                                    SubmitBusinessRegistrationPage1Data(
                                                                        addBusinessPage1Data:
                                                                            widget.addBusinessPage1Data!));
                                                              }
                                                              // Navigator.push(
                                                              //   context,
                                                              //   MaterialPageRoute(
                                                              //       builder:
                                                              //           (context) =>
                                                              //               BusinessRegistrationScreen4()),
                                                              // );
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      'Please enter Admin Note',
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade400,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      12.0);
                                                            }
                                                          } else {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Please enter Store URL',
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Colors.grey
                                                                        .shade400,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 12.0);
                                                          }
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'Please enter a Store Fax',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  Colors.grey
                                                                      .shade400,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 12.0);
                                                        }
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'Please select a Area',
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.grey
                                                                    .shade400,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 12.0);
                                                      }
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Please select a City',
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.grey
                                                                  .shade400,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 12.0);
                                                    }
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'Please select a Zone',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors
                                                            .grey.shade400,
                                                        textColor: Colors.white,
                                                        fontSize: 12.0);
                                                  }
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Please enter Address 1',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.grey.shade400,
                                                      textColor: Colors.white,
                                                      fontSize: 12.0);
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Please enter Address 2',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.grey.shade400,
                                                    textColor: Colors.white,
                                                    fontSize: 12.0);
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: 'Please enter Address 1',
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      Colors.grey.shade400,
                                                  textColor: Colors.white,
                                                  fontSize: 12.0);
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Please enter a phone number',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    Colors.grey.shade400,
                                                textColor: Colors.white,
                                                fontSize: 12.0);
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Please select a country code',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Colors.grey.shade400,
                                              textColor: Colors.white,
                                              fontSize: 12.0);
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Please enter a valid email',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                Colors.grey.shade400,
                                            textColor: Colors.white,
                                            fontSize: 12.0);
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Please enter store name',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey.shade400,
                                          textColor: Colors.white,
                                          fontSize: 12.0);
                                    }
                                  }

                                  ///use it in state
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           BusinessRegistrationScreen4()),
                                  // );
                                },
                                child: Container(
                                  height: screenSize.height * 0.065,
                                  width: screenSize.width * 0.43,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: kColorPrimary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Next',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: kColorWhite, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
        ),
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

  Widget _buildDialogItem(country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          const SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: const InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: const Text('Select your country'),
            onValuePicked: (country) {
              setState(() => _selectedDialogCountry = country);

              //print(_selectedDialogCountry.phoneCode);
              for (int i = 0;
                  i < allowedCountriesResponse.countries.length;
                  i++) {
                if (allowedCountriesResponse.countries[i].ISO2 ==
                    _selectedDialogCountry.isoCode) {
                  if (selectedCountryId !=
                      allowedCountriesResponse.countries[i].CountryID) {}
                  selectedCountryId =
                      allowedCountriesResponse.countries[i].CountryID;
                  countrySelected = true;
                  if (selectedCountryId == 16) {
                    _loginBloc.add(GetPathaoAccessToken());
                  } else {
                    _loginBloc.add(GetVendorAllowedStates(
                        id: allowedCountriesResponse.countries[i].CountryID));
                    _loginBloc.add(GetVendorAllowedCities(
                        id: allowedCountriesResponse.countries[i].CountryID));
                  }
                  break;
                }
              }
            },

            itemFilter: (c) => allowedCountriesISO2List.contains(c.isoCode),
            itemBuilder: _buildDialogItem,
            // priorityList: [
            //   CountryPickerUtils.getCountryByIsoCode('TR'),
            //   CountryPickerUtils.getCountryByIsoCode('US'),
            // ],
          ),
        ),
      );

  void _countryCodePickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: Text('Select your phone code'),
            onValuePicked: (country) {
              _chooseCountryCode = '+' + country.phoneCode;
              setState(() {});
            },

            itemFilter: (c) =>
                widget.allowedCountriesISO2List.contains(c.isoCode),
            itemBuilder: _buildDialogItem,
            // priorityList: [
            //   CountryPickerUtils.getCountryByIsoCode('TR'),
            //   CountryPickerUtils.getCountryByIsoCode('US'),
            // ],
          ),
        ),
      );

  bool validateEmail() {
    if (storeEmailController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: 'Email field is empty',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade400,
          textColor: Colors.white,
          fontSize: 12.0);
      return false;
    } else if ((!storeEmailController.text.contains('@') ||
        !storeEmailController.text.contains('.com'))) {
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

  Future<bool> _onBackPressed() {
    if (widget.businessAlreadyExist == true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomePage(
                    currentTab: 3,
                  )),
          (Route<dynamic> route) => false);
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }
}

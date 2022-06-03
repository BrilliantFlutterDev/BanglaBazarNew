//business_registration_screen1

import 'dart:io';

import 'package:bangla_bazar/ModelClasses/AddNewBussinessPage1Model.dart';
import 'package:bangla_bazar/ModelClasses/allowed_countries_list_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_city_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_states_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/business_registration_screen3.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/code_verfication.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginBloc/login_bloc.dart';
import 'package:bangla_bazar/Widgets/bottom_sheet_choose_pic_source_widget.dart';

import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:country_pickers/country_pickers.dart';

class BusinessRegistrationScreen2 extends StatefulWidget {
  final String processNumber;
  const BusinessRegistrationScreen2({
    Key? key,
    required this.processNumber,
  }) : super(key: key);
  @override
  _BusinessRegistrationScreen2State createState() =>
      _BusinessRegistrationScreen2State();
}

class _BusinessRegistrationScreen2State
    extends State<BusinessRegistrationScreen2> {
  late LoginBloc _loginBloc;
  TextEditingController companyNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2NameController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController textIdController = TextEditingController();
  TextEditingController govIdController = TextEditingController();
  TextEditingController paymentAcController = TextEditingController();
  TextEditingController paymentRoutingController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessUrlController = TextEditingController();

  TextEditingController adminNoteController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController businessPhoneNumberController = TextEditingController();
  TextEditingController createdDateController = TextEditingController();

  late String selectedState = '';
  late String selectedCity = '';
  late int selectedCityId;
  late int selectedCountryId;
  List<String> statesList = ['Barguna', 'Barisal'];
  List<String> allowedCountriesISO2List = [];
  late String _chooseCountryCode = '';
  late String _chooseBusinessCountryCode = '';
  late String allowedDelivery = 'Y';
  late String allowedStorePickUp = 'Y';
  late String allowedProductApproval = 'Y';

  // PhoneNumber phoneNumber = PhoneNumber();
  final TextEditingController controller = TextEditingController();

  late DateTime pickedDate;

  var _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('BD');

  AddBusinessPage1Data? addBusinessPage1Data;

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

  bool businessAlreadyExist = false;
  bool verifyEmail = false;
  String tempEmailVerified = '';

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();

    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginBloc.add(GetVendorAllowedCountries());
    _loginBloc.add(CheckUserBusiness(id: AppGlobal.userID));
  }
  // CountryPickerDropdown(
  // initialValue: 'AR',
  // itemBuilder: _buildDropdownItem,
  // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
  // priorityList:[
  // CountryPickerUtils.getCountryByIsoCode('GB'),
  // CountryPickerUtils.getCountryByIsoCode('CN'),
  // ],
  // sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
  // onValuePicked: (Country country) {
  // print("${country.name}");
  // },
  // )

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
        if (state.error == 'Business Already exists') {
          businessAlreadyExist = true;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BusinessRegistrationScreen3(
                      processNumber: 'store',
                      allowedCountriesResponse: allowedCountriesResponse,
                      allowedVendorStatesResponse: allowedVendorStatesResponse,
                      allowedVendorCityResponse: allowedVendorCityResponse,
                      allowedCountriesISO2List: allowedCountriesISO2List,
                      businessAlreadyExist: businessAlreadyExist,
                    )),
          );
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
      } else if (state is BusinessNotExist) {
      } else if (state is VendorAllowedCountries) {
        allowedCountriesResponse = state.allowedCountriesResponse;
        for (int i = 0; i < allowedCountriesResponse.countries.length; i++) {
          allowedCountriesISO2List
              .add(allowedCountriesResponse.countries[i].ISO2);
        }
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
                              child: Center(
                                child: Text(
                                  '1',
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
                                  '2',
                                  style: TextStyle(
                                      color: kColorFieldsBorders, fontSize: 16),
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
                                      color: kColorFieldsBorders, fontSize: 16),
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
                              style: TextStyle(
                                  color: kColorFieldsBorders, fontSize: 14),
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
                            'Basic Info',
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                        ),

                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Company Name',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: screenSize.height * 0.06,
                          child: TextField(
                            controller: companyNameController,
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
                              hintText: 'Enter Company Name',
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
                            'Address 1',
                            style: TextStyle(fontSize: 14, color: Colors.black),
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
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: address2NameController,
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
                            'Phone Number',
                            style: TextStyle(fontSize: 14, color: Colors.black),
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
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                            'Country',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        Container(
                          height: screenSize.height * 0.068,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: kColorWhite,
                              border: Border.all(color: kColorFieldsBorders)),
                          child: Center(
                            child: ListTile(
                              onTap: _openCountryPickerDialog,
                              title: _buildDialogItem(_selectedDialogCountry),
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
                            style: TextStyle(fontSize: 14, color: Colors.black),
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
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'State',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        allowedVendorStatesResponse.states.isNotEmpty
                            ? Container(
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
                                      selectedState == ''
                                          ? 'Select'
                                          : selectedState,
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
                                  items: allowedVendorStatesResponse.states
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
                                  textCapitalization: TextCapitalization.words,
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
                                      borderRadius: BorderRadius.circular(6.0),
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
                              ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'City',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        allowedVendorCityResponse.cities.isNotEmpty
                            ? Container(
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
                                      selectedCity == ''
                                          ? 'Select'
                                          : selectedCity,
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
                                  items: allowedVendorCityResponse.cities
                                      .map((valueItem) {
                                    return DropdownMenuItem(
                                      child: Text(valueItem.City),
                                      value: valueItem,
                                      onTap: () {
                                        setState(() {
                                          selectedCity = valueItem.City;
                                          selectedCityId = valueItem.CityID;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              )
                            : Container(
                                height: screenSize.height * 0.06,
                                child: TextField(
                                  textCapitalization: TextCapitalization.words,
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
                                      borderRadius: BorderRadius.circular(6.0),
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
                              ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Tax ID',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: screenSize.height * 0.06,
                          child: TextField(
                            controller: textIdController,
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
                              hintText: 'Enter Text ID',
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
                            'Tax ID Picture',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          child: Container(
                            width: screenSize.width,
                            height: screenSize.height * 0.06,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: kColorFieldsBorders, width: 1),
                              borderRadius: BorderRadius.circular(5),
                              color: kColorWhite,
                            ),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 90,
                                  height: 25,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: kColorWidgetBackgroundColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Choose',
                                      style: const TextStyle(
                                        color: kColorPrimary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  textIDImage != null
                                      ? textIDImage!.name != ''
                                          ? 'Image Selected'
                                          : 'No file selected'
                                      : 'No file selected',
                                  style: const TextStyle(
                                    color: kColorFieldsBorders,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            cameraBottomNavigationSheetTextID();
                            // print('||||||||||||||||||');
                            // print(textIDImage!.name);
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Government ID',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: screenSize.height * 0.06,
                          child: TextField(
                            controller: govIdController,
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
                              hintText: 'Enter Government ID',
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
                            'Government ID Picture',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          child: Container(
                            width: screenSize.width,
                            height: screenSize.height * 0.06,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: kColorFieldsBorders, width: 1),
                              borderRadius: BorderRadius.circular(5),
                              color: kColorWhite,
                            ),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 90,
                                  height: 25,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: kColorWidgetBackgroundColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Choose',
                                      style: const TextStyle(
                                        color: kColorPrimary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  govIDImage != null
                                      ? govIDImage!.name != ''
                                          ? 'Image Selected'
                                          : 'No file selected'
                                      : 'No file selected',
                                  style: const TextStyle(
                                    color: kColorFieldsBorders,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            cameraBottomNavigationSheetGovernmentID();
                            // print('||||||||||||||||||');
                            // print(textIDImage!.name);
                            setState(() {});
                          },
                        ),

                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Company Logo',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          child: Container(
                            width: screenSize.width,
                            height: screenSize.height * 0.06,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: kColorFieldsBorders, width: 1),
                              borderRadius: BorderRadius.circular(5),
                              color: kColorWhite,
                            ),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 90,
                                  height: 25,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: kColorWidgetBackgroundColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Choose',
                                      style: const TextStyle(
                                        color: kColorPrimary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: screenSize.width * 0.5,
                                  child: Text(
                                    companyLogoImage != null
                                        ? companyLogoImage!.name != ''
                                            ? 'Image Selected'
                                            : 'No file selected'
                                        : 'No file selected',
                                    style: const TextStyle(
                                      color: kColorFieldsBorders,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            cameraBottomNavigationSheetCompanyLogo();
                            // print('||||||||||||||||||');
                            // print(textIDImage!.name);
                            setState(() {});
                          },
                        ),

                        SizedBox(
                          height: screenSize.height * 0.07,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Payment Info',
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                        ),

                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Payment Account',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: screenSize.height * 0.06,
                          child: TextField(
                            controller: paymentAcController,
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
                              hintText: 'Enter Payment Account',
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
                            'Payment Routing',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: screenSize.height * 0.06,
                          child: TextField(
                            controller: paymentRoutingController,
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
                              hintText: 'Enter Payment Routing',
                              hintStyle:
                                  const TextStyle(color: kColorFieldsBorders),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.07,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'General Info',
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                        ),

                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Business Email',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: screenSize.height * 0.06,
                          child: TextField(
                            controller: businessEmailController,
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
                              hintText: 'Enter Business Email',
                              hintStyle:
                                  const TextStyle(color: kColorFieldsBorders),
                            ),
                          ),
                        ),
                        verifyEmail == false ||
                                tempEmailVerified !=
                                    businessEmailController.text
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
                                                        businessEmailController
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
                                              userEmail: businessEmailController
                                                  .text
                                                  .trim(),
                                            ),
                                          ),
                                        );
                                        if (result == true) {
                                          verifyEmail = true;
                                          tempEmailVerified =
                                              businessEmailController.text;
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
                                                    color: kColorFieldsBorders),
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
                            'Business Phone',
                            style: TextStyle(fontSize: 14, color: Colors.black),
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
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                                      _chooseBusinessCountryCode == ''
                                          ? 'CC'
                                          : _chooseBusinessCountryCode,
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
                                _countryCodeBusinessPickerDialog();
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: screenSize.height * 0.06,
                              width: screenSize.width * 0.6,
                              child: TextField(
                                controller: businessPhoneNumberController,
                                // readOnly: AppGlobal.phoneVerified == 'N'
                                //     ? true
                                //     : false,
                                onChanged: (value) {
                                  if (AppGlobal.phoneNumber !=
                                      _chooseBusinessCountryCode +
                                          businessPhoneNumberController.text
                                              .trim()) {
                                    AppGlobal.phoneChangeVerify = false;
                                  } else {
                                    AppGlobal.phoneChangeVerify = true;
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
                        //               if (_chooseBusinessCountryCode.length >
                        //                       1 &&
                        //                   businessPhoneNumberController
                        //                           .text.length >
                        //                       7) {
                        //                 Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                     builder: (context) =>
                        //                         CodeVerificationScreen(
                        //                       moduleName:
                        //                           'phoneChangeEditProfile',
                        //                       userEmail:
                        //                           _chooseBusinessCountryCode +
                        //                               businessPhoneNumberController
                        //                                   .text,
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
                            'Business URL',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: screenSize.height * 0.06,
                          child: TextField(
                            controller: businessUrlController,
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
                              hintText: 'Enter Business URL',
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
                            'Created Date',
                            style: TextStyle(fontSize: 14, color: Colors.black),
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
                                controller: createdDateController,
                                style:
                                    const TextStyle(color: kColorDarkGreyText),
                                readOnly: true,
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
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        borderSide: const BorderSide(
                                          color: kColorPrimary,
                                        )),
                                    hintText: 'dd/mm/yyyy',
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
                                    child: Icon(
                                        MyFlutterApp.icon_calendar_outlined),
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
                            'Allow Delivery',
                            style: TextStyle(fontSize: 14, color: Colors.black),
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
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorDarkGreyIcon,
                                        ),
                                        child: Center(
                                            child: Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorWhite,
                                          ),
                                          child: Center(
                                              child: Container(
                                            width: 13,
                                            height: 13,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: allowedDelivery == 'Y'
                                                  ? kColorPrimary
                                                  : kColorWhite,
                                            ),
                                          )),
                                        )),
                                      ),
                                      onTap: () {
                                        if (allowedDelivery == 'N') {
                                          setState(() {
                                            allowedDelivery = 'Y';
                                          });
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
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
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorDarkGreyIcon,
                                        ),
                                        child: Center(
                                            child: Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorWhite,
                                          ),
                                          child: Center(
                                              child: Container(
                                            width: 13,
                                            height: 13,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: allowedDelivery == 'N'
                                                  ? kColorPrimary
                                                  : kColorWhite,
                                            ),
                                          )),
                                        )),
                                      ),
                                      onTap: () {
                                        if (allowedDelivery == 'Y') {
                                          setState(() {
                                            allowedDelivery = 'N';
                                          });
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
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
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Allow Store Pickup',
                            style: TextStyle(fontSize: 14, color: Colors.black),
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
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorDarkGreyIcon,
                                        ),
                                        child: Center(
                                            child: Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorWhite,
                                          ),
                                          child: Center(
                                              child: Container(
                                            width: 13,
                                            height: 13,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: allowedStorePickUp == 'Y'
                                                  ? kColorPrimary
                                                  : kColorWhite,
                                            ),
                                          )),
                                        )),
                                      ),
                                      onTap: () {
                                        if (allowedStorePickUp == 'N') {
                                          setState(() {
                                            allowedStorePickUp = 'Y';
                                          });
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
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
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorDarkGreyIcon,
                                        ),
                                        child: Center(
                                            child: Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorWhite,
                                          ),
                                          child: Center(
                                              child: Container(
                                            width: 13,
                                            height: 13,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: allowedStorePickUp == 'N'
                                                  ? kColorPrimary
                                                  : kColorWhite,
                                            ),
                                          )),
                                        )),
                                      ),
                                      onTap: () {
                                        if (allowedStorePickUp == 'Y') {
                                          setState(() {
                                            allowedStorePickUp = 'N';
                                          });
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
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
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Product Approval',
                            style: TextStyle(fontSize: 14, color: Colors.black),
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
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorDarkGreyIcon,
                                        ),
                                        child: Center(
                                            child: Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorWhite,
                                          ),
                                          child: Center(
                                              child: Container(
                                            width: 13,
                                            height: 13,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  allowedProductApproval == 'Y'
                                                      ? kColorPrimary
                                                      : kColorWhite,
                                            ),
                                          )),
                                        )),
                                      ),
                                      onTap: () {
                                        if (allowedProductApproval == 'N') {
                                          setState(() {
                                            allowedProductApproval = 'Y';
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
                                Text(
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
                                              color:
                                                  allowedProductApproval == 'N'
                                                      ? kColorPrimary
                                                      : kColorWhite,
                                            ),
                                          )),
                                        )),
                                      ),
                                      onTap: () {
                                        if (allowedProductApproval == 'Y') {
                                          setState(() {
                                            allowedProductApproval = 'N';
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
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),

                        Container(
                          height: screenSize.height * 0.3,
                          width: screenSize.width,
                          decoration: const BoxDecoration(
                            boxShadow: [],
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: kColorWhite,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
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
                                    const EdgeInsets.fromLTRB(10, 20, 40, 0),
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
                                Navigator.pop(context);
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
                                if (companyNameController.text != '') {
                                  if (address1Controller.text != '') {
                                    if (address2NameController.text != '') {
                                      if (_chooseCountryCode != '') {
                                        if (phoneNumberController.text != '') {
                                          if (_selectedDialogCountry.name !=
                                              '') {
                                            if (zipCodeController.text != '') {
                                              if (selectedState != '') {
                                                if (selectedCity != '') {
                                                  if (textIdController.text !=
                                                      '') {
                                                    if (govIdController.text !=
                                                        '') {
                                                      if (paymentAcController
                                                              .text !=
                                                          '') {
                                                        if (paymentRoutingController
                                                                .text !=
                                                            '') {
                                                          if (validateEmail()) {
                                                            if (_chooseBusinessCountryCode !=
                                                                '') {
                                                              if (businessPhoneNumberController
                                                                      .text !=
                                                                  '') {
                                                                if (businessUrlController
                                                                        .text !=
                                                                    '') {
                                                                  if (createdDateController
                                                                          .text !=
                                                                      '') {
                                                                    if (adminNoteController
                                                                            .text !=
                                                                        '') {
                                                                      if (textIDImage !=
                                                                          null) {
                                                                        if (govIDImage !=
                                                                            null) {
                                                                          if (companyLogoImage !=
                                                                              null) {
                                                                            addBusinessPage1Data = AddBusinessPage1Data(
                                                                                name: companyNameController.text,
                                                                                address1: address1Controller.text,
                                                                                address2: address2NameController.text,
                                                                                phoneCode: _chooseCountryCode,
                                                                                phoneNumber: phoneNumberController.text,
                                                                                country: _selectedDialogCountry.name,
                                                                                zipCode: zipCodeController.text,
                                                                                state: selectedState,
                                                                                city: selectedCity,
                                                                                textID: textIdController.text,
                                                                                textIDImage: textIDImage,
                                                                                govID: govIdController.text,
                                                                                govIDImage: govIDImage,
                                                                                companyLogoImage: companyLogoImage,
                                                                                paymentAc: paymentAcController.text,
                                                                                paymentRout: paymentRoutingController.text,
                                                                                businessEmail: businessEmailController.text,
                                                                                businessPhoneCode: _chooseBusinessCountryCode,
                                                                                businessPhoneNumber: businessPhoneNumberController.text,
                                                                                businessURL: businessUrlController.text,
                                                                                gatewayID: selectedCountryId == 16 ? '4' : '5',
                                                                                createdAtDate: createdDateController.text,
                                                                                allowDelivery: allowedDelivery,
                                                                                allowStorePickup: allowedStorePickUp,
                                                                                productApproval: allowedProductApproval,
                                                                                adminNote: adminNoteController.text,
                                                                                countryID: selectedCountryId,
                                                                                cityID: selectedCityId);

                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => BusinessRegistrationScreen3(
                                                                                        processNumber: '1st_business',
                                                                                        addBusinessPage1Data: addBusinessPage1Data!,
                                                                                        allowedCountriesResponse: allowedCountriesResponse,
                                                                                        allowedVendorStatesResponse: allowedVendorStatesResponse,
                                                                                        allowedVendorCityResponse: allowedVendorCityResponse,
                                                                                        allowedCountriesISO2List: allowedCountriesISO2List,
                                                                                        businessAlreadyExist: businessAlreadyExist,
                                                                                      )),
                                                                            );
                                                                          } else {
                                                                            Fluttertoast.showToast(
                                                                                msg: 'Please company logo image',
                                                                                toastLength: Toast.LENGTH_SHORT,
                                                                                gravity: ToastGravity.BOTTOM,
                                                                                timeInSecForIosWeb: 1,
                                                                                backgroundColor: Colors.grey.shade400,
                                                                                textColor: Colors.white,
                                                                                fontSize: 12.0);
                                                                          }
                                                                        } else {
                                                                          Fluttertoast.showToast(
                                                                              msg: 'Please add Government ID Picture',
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.BOTTOM,
                                                                              timeInSecForIosWeb: 1,
                                                                              backgroundColor: Colors.grey.shade400,
                                                                              textColor: Colors.white,
                                                                              fontSize: 12.0);
                                                                        }
                                                                      } else {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                'Please add Text ID Picture',
                                                                            toastLength: Toast
                                                                                .LENGTH_SHORT,
                                                                            gravity: ToastGravity
                                                                                .BOTTOM,
                                                                            timeInSecForIosWeb:
                                                                                1,
                                                                            backgroundColor:
                                                                                Colors.grey.shade400,
                                                                            textColor: Colors.white,
                                                                            fontSize: 12.0);
                                                                      }
                                                                    } else {
                                                                      Fluttertoast.showToast(
                                                                          msg:
                                                                              'Please enter an Admin Note',
                                                                          toastLength: Toast
                                                                              .LENGTH_SHORT,
                                                                          gravity: ToastGravity
                                                                              .BOTTOM,
                                                                          timeInSecForIosWeb:
                                                                              1,
                                                                          backgroundColor: Colors
                                                                              .grey
                                                                              .shade400,
                                                                          textColor: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              12.0);
                                                                    }
                                                                  } else {
                                                                    Fluttertoast.showToast(
                                                                        msg:
                                                                            'Please enter a Created Date',
                                                                        toastLength:
                                                                            Toast
                                                                                .LENGTH_SHORT,
                                                                        gravity:
                                                                            ToastGravity
                                                                                .BOTTOM,
                                                                        timeInSecForIosWeb:
                                                                            1,
                                                                        backgroundColor: Colors
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
                                                                          'Please enter a Business URL',
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: ToastGravity
                                                                          .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                          1,
                                                                      backgroundColor: Colors
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
                                                                        'Please enter a Business Phone Number',
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_SHORT,
                                                                    gravity: ToastGravity
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
                                                                      'Please select a Business Country Code',
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
                                                                    'Please enter a valid Email',
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
                                                                  'Please enter a Payment Routing',
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
                                                                'Please enter a Payment Account',
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
                                                              'Please enter a Government ID',
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
                                                            'Please enter a TextID',
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
                                                          'Please select a City',
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
                                                        'Please select a State',
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
                                                  msg: 'Please enter Zip Code',
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
                                                msg: 'Please select a Country',
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
                                              msg: 'Please enter phone number',
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
                                                'Please select Phone Number Country Code',
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
                                          msg: 'Please enter Address 2',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey.shade400,
                                          textColor: Colors.white,
                                          fontSize: 12.0);
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Please enter Address 1',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey.shade400,
                                        textColor: Colors.white,
                                        fontSize: 12.0);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Please enter company name',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey.shade400,
                                      textColor: Colors.white,
                                      fontSize: 12.0);
                                }
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
                                child: const Center(
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
      createdDateController.text =
          DateFormat('yyyy-MM-dd').format(pickedDate).toString();
      setState(() {});
    }
  }

  final ImagePicker _picker = ImagePicker();
  XFile? textIDImage;

  XFile? govIDImage;
  XFile? companyLogoImage;

  void cameraBottomNavigationSheetTextID() {
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
                        'Add Text ID Picture',
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
                            textIDImage = await _picker.pickImage(
                                source: ImageSource.camera);
                          },
                        ),
                        BottomSheetFilterByWidget(
                          icon: Icons.add_photo_alternate,
                          buttonLabel: 'Browse gallery',
                          onPressed: () async {
                            Navigator.pop(context);
                            textIDImage = await _picker.pickImage(
                                source: ImageSource.gallery);
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

  void cameraBottomNavigationSheetGovernmentID() {
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
                        'Add Government ID Picture',
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
                            govIDImage = await _picker.pickImage(
                                source: ImageSource.camera);
                          },
                        ),
                        BottomSheetFilterByWidget(
                          icon: Icons.add_photo_alternate,
                          buttonLabel: 'Browse gallery',
                          onPressed: () async {
                            Navigator.pop(context);
                            govIDImage = await _picker.pickImage(
                                source: ImageSource.gallery);
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

  void cameraBottomNavigationSheetCompanyLogo() {
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
                        'Add Company Logo',
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
                            companyLogoImage = await _picker.pickImage(
                                source: ImageSource.camera);
                          },
                        ),
                        BottomSheetFilterByWidget(
                          icon: Icons.add_photo_alternate,
                          buttonLabel: 'Browse gallery',
                          onPressed: () async {
                            Navigator.pop(context);
                            companyLogoImage = await _picker.pickImage(
                                source: ImageSource.gallery);
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
          SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          SizedBox(width: 8.0),
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
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: const Text('Select your country'),
            onValuePicked: (country) {
              setState(() => _selectedDialogCountry = country);
              print(_selectedDialogCountry.phoneCode);
              for (int i = 0;
                  i < allowedCountriesResponse.countries.length;
                  i++) {
                if (allowedCountriesResponse.countries[i].ISO2 ==
                    _selectedDialogCountry.isoCode) {
                  selectedCountryId =
                      allowedCountriesResponse.countries[i].CountryID;
                  _loginBloc.add(GetVendorAllowedStates(
                      id: allowedCountriesResponse.countries[i].CountryID));
                  _loginBloc.add(GetVendorAllowedCities(
                      id: allowedCountriesResponse.countries[i].CountryID));
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

            itemFilter: (c) => allowedCountriesISO2List.contains(c.isoCode),
            itemBuilder: _buildDialogItem,
            // priorityList: [
            //   CountryPickerUtils.getCountryByIsoCode('TR'),
            //   CountryPickerUtils.getCountryByIsoCode('US'),
            // ],
          ),
        ),
      );
  void _countryCodeBusinessPickerDialog() => showDialog(
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
              _chooseBusinessCountryCode = '+' + country.phoneCode;
              setState(() {});
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
  bool validateEmail() {
    if (businessEmailController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: 'Email field is empty',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade400,
          textColor: Colors.white,
          fontSize: 12.0);
      return false;
    } else if ((!businessEmailController.text.contains('@') ||
        !businessEmailController.text.contains('.com'))) {
      Fluttertoast.showToast(
          msg: 'Please enter a valid email.',
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

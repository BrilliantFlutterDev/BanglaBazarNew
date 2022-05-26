import 'dart:io';

import 'package:bangla_bazar/ModelClasses/allowed_countries_list_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_city_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_states_response.dart';
import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/ModelClasses/payment_history_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';

import 'package:bangla_bazar/Views/Cart/CartBloc/cart_bloc.dart';
import 'package:bangla_bazar/Views/Cart/checkout_address_screen.dart';
import 'package:bangla_bazar/Views/Cart/checkout_country_selection.dart';
import 'package:bangla_bazar/Widgets/bottom_sheet_choose_pic_source_widget.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PreviousAddressSelectionScreen extends StatefulWidget {
  CartDetailsResponse cartDetailsResponse;
  PreviousAddressSelectionScreen({Key? key, required this.cartDetailsResponse})
      : super(key: key);
  @override
  _PreviousAddressSelectionScreenState createState() =>
      _PreviousAddressSelectionScreenState();
}

class _PreviousAddressSelectionScreenState
    extends State<PreviousAddressSelectionScreen> {
  late CartBloc _cartBloc;
  var _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('BD');

  List<String> allowedCountriesISO2List = [];
  late AllowedCountriesResponse allowedCountriesResponse;
  bool countrySelected = false;
  late int selectedCountryId = -1;
  late String selectedState = '';
  late String selectedCity = '';
  late int selectedCityId = 0;

  bool creditCardPayment = true;

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

  PaymentHistory? paymentHistory;
  int paymentIndex = -1;

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _cartBloc = BlocProvider.of<CartBloc>(context);
    _cartBloc.add(GetPaymentHistory());
    _cartBloc.add(GetVendorAllowedCountries());
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<CartBloc, CartState>(listener: (context, state) {
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
        print('>>>>>>>>>>>2222');

        /// Uncomment the below code when implement recent addresses
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => CheckoutAddressScreen(
        //       cartDetailsResponse: widget.cartDetailsResponse,
        //       allowedCountriesISO2List: allowedCountriesISO2List,
        //       allowedCountriesResponse: allowedCountriesResponse,
        //       selectedCountryId: selectedCountryId,
        //       allowedVendorStatesResponse: allowedVendorStatesResponse,
        //       allowedVendorCityResponse: allowedVendorCityResponse,
        //       creditCardPayment: creditCardPayment,
        //       userPaymentHistory: paymentIndex != -1
        //           ? paymentHistory!.userPaymentHistory[paymentIndex]
        //           : null,
        //     ),
        //   ),
        // );
      } else if (state is GetPaymentHistoryState) {
        paymentHistory = state.paymentHistory;

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
                          'Delivery Address Selection',
                          style: TextStyle(fontSize: 22),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenSize.width * 0.80,
                          child: const Text(
                            'Select from previous addresses or add new one.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, color: kColorDarkGreyText),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.03,
                        ),
                        Container(
                          width: screenSize.width,
                          height: screenSize.height * 0.5,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: paymentHistory != null
                                  ? paymentHistory!.userPaymentHistory.length
                                  : 0,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    ///
                                    paymentIndex = index;
                                    selectedCountryId = paymentHistory!
                                        .userPaymentHistory[index].CountryID;
                                    _cartBloc.add(GetVendorAllowedStates(
                                        id: paymentHistory!
                                            .userPaymentHistory[index]
                                            .CountryID));
                                    _cartBloc.add(GetVendorAllowedCities(
                                        id: paymentHistory!
                                            .userPaymentHistory[index]
                                            .CountryID));
                                  },
                                  child: Container(
                                    height: screenSize.height * 0.16,
                                    width: screenSize.width,
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            kColorFieldsBorders, //                   <--- border color
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                      color: kColorWhite,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                paymentHistory!
                                                    .userPaymentHistory[index]
                                                    .Name,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              const Icon(
                                                MyFlutterApp.ic_location_on,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            paymentHistory!
                                                .userPaymentHistory[index]
                                                .Address1,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: kColorFieldsBorders,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            paymentHistory!
                                                    .userPaymentHistory[index]
                                                    .City +
                                                ', ' +
                                                paymentHistory!
                                                    .userPaymentHistory[index]
                                                    .ZipCode +
                                                ', ' +
                                                paymentHistory!
                                                    .userPaymentHistory[index]
                                                    .State +
                                                ', ' +
                                                paymentHistory!
                                                    .userPaymentHistory[index]
                                                    .Country,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: kColorFieldsBorders,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.15,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              ///
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         CheckoutCountrySelection(
                              //       cartDetailsResponse:
                              //           widget.cartDetailsResponse,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Container(
                              height: screenSize.height * 0.065,
                              width: screenSize.width,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      kColorPrimary, //                   <--- border color
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                color: kColorWhite,
                              ),
                              child: const Center(
                                child: Text(
                                  'Add New',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: kColorPrimary, fontSize: 14),
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

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: const InputDecoration(hintText: 'Search...'),
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
                  if (selectedCountryId !=
                      allowedCountriesResponse.countries[i].CountryID) {}
                  selectedCountryId =
                      allowedCountriesResponse.countries[i].CountryID;
                  countrySelected = true;

                  _cartBloc.add(GetVendorAllowedStates(
                      id: allowedCountriesResponse.countries[i].CountryID));
                  _cartBloc.add(GetVendorAllowedCities(
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

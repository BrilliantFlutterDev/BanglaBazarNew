import 'package:bangla_bazar/ModelClasses/allowed_countries_list_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_city_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_states_response.dart';
import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/Cart/CartBloc/cart_bloc.dart';
import 'package:bangla_bazar/Views/Cart/bangladesh_checkout_address_screen.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckoutCountrySelection extends StatefulWidget {
  CartDetailsResponse cartDetailsResponse;

  /// Delivery Checks variable
  final bool countriesAreSame;
  final bool globalShipping;
  final bool shippingAvailable;
  final String shippingAvailableCity;
  final int shippingAvailableCountryID;
  final String globalShippingCountry;
  CheckoutCountrySelection(
      {Key? key,
      required this.cartDetailsResponse,
      required this.countriesAreSame,
      required this.globalShipping,
      required this.shippingAvailable,
      required this.shippingAvailableCity,
      required this.shippingAvailableCountryID,
      required this.globalShippingCountry})
      : super(key: key);
  @override
  _CheckoutCountrySelectionState createState() =>
      _CheckoutCountrySelectionState();
}

class _CheckoutCountrySelectionState extends State<CheckoutCountrySelection> {
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

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _cartBloc = BlocProvider.of<CartBloc>(context);
    print('>>>>>>>>>>>>>>>>>>>>>Country Selection Screen');
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
        print('>>>>>>>>122');
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
                          'Delivery Country Selection',
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
                        SizedBox(
                          height: screenSize.height * 0.07,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Delivery Address Country',
                            style: TextStyle(fontSize: 14, color: Colors.black),
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
                                    border:
                                        Border.all(color: kColorFieldsBorders)),
                                child: Center(
                                  child: ListTile(
                                    onTap: _openCountryPickerDialog,
                                    title: _buildDialogItem(
                                        _selectedDialogCountry),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: screenSize.height * 0.1,
                        ),
                        selectedCountryId == 16
                            ? const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Select payment type',
                                  style: TextStyle(
                                      color: kColorPrimary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : const SizedBox(),
                        selectedCountryId == 16
                            ? const SizedBox(
                                height: 30,
                              )
                            : const SizedBox(),
                        selectedCountryId == 16
                            ? Row(
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
                                                color: creditCardPayment == true
                                                    ? kColorPrimary
                                                    : kColorWhite,
                                              ),
                                            )),
                                          )),
                                        ),
                                        onTap: () {
                                          if (creditCardPayment == false) {
                                            setState(() {
                                              creditCardPayment = true;
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
                                    'Credit/Debit card',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  )
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        selectedCountryId == 16
                            ? Row(
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
                                                    creditCardPayment == false
                                                        ? kColorPrimary
                                                        : kColorWhite,
                                              ),
                                            )),
                                          )),
                                        ),
                                        onTap: () {
                                          if (creditCardPayment == true) {
                                            setState(() {
                                              creditCardPayment = false;
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
                                    'Cash on delivery',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  )
                                ],
                              )
                            : const SizedBox(),
                        selectedCountryId == 16
                            ? SizedBox(
                                height: screenSize.height * 0.15,
                              )
                            : SizedBox(
                                height: screenSize.height * 0.3,
                              ),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              ///Delivery Custom Checks

                              if (widget.shippingAvailable == false &&
                                  widget.globalShipping == false) {
                                if (selectedCountryId ==
                                    widget.shippingAvailableCountryID) {
                                  if (selectedCountryId == 16) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BangladeshCheckoutAddressScreen(
                                                  cartDetailsResponse: widget
                                                      .cartDetailsResponse,
                                                  allowedCountriesISO2List:
                                                      allowedCountriesISO2List,
                                                  allowedCountriesResponse:
                                                      allowedCountriesResponse,
                                                  selectedCountryId:
                                                      selectedCountryId,
                                                  allowedVendorStatesResponse:
                                                      allowedVendorStatesResponse,
                                                  allowedVendorCityResponse:
                                                      allowedVendorCityResponse,
                                                  creditCardPayment:
                                                      creditCardPayment,
                                                  countriesAreSame:
                                                      widget.countriesAreSame,
                                                  globalShipping:
                                                      widget.globalShipping,
                                                  shippingAvailable:
                                                      widget.shippingAvailable,
                                                  shippingAvailableCity: widget
                                                      .shippingAvailableCity,
                                                  shippingAvailableCountryID: widget
                                                      .shippingAvailableCountryID,
                                                  globalShippingCountry: widget
                                                      .globalShippingCountry)),
                                    );
                                  } else if (selectedCountryId == 226) {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           CheckoutAddressScreen(
                                    //             cartDetailsResponse:
                                    //                 widget.cartDetailsResponse,
                                    //             allowedCountriesISO2List:
                                    //                 allowedCountriesISO2List,
                                    //             allowedCountriesResponse:
                                    //                 allowedCountriesResponse,
                                    //             selectedCountryId:
                                    //                 selectedCountryId,
                                    //             allowedVendorStatesResponse:
                                    //                 allowedVendorStatesResponse,
                                    //             allowedVendorCityResponse:
                                    //                 allowedVendorCityResponse,
                                    //             creditCardPayment:
                                    //                 creditCardPayment,
                                    //           )),
                                    // );
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Product and delivery country should be same.',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey.shade400,
                                      textColor: Colors.white,
                                      fontSize: 12.0);
                                }
                              } else if (widget.shippingAvailable == false &&
                                  widget.globalShipping == true) {
                                if (selectedCountryId ==
                                    widget.shippingAvailableCountryID) {
                                  if (selectedCountryId == 16) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BangladeshCheckoutAddressScreen(
                                                  cartDetailsResponse: widget
                                                      .cartDetailsResponse,
                                                  allowedCountriesISO2List:
                                                      allowedCountriesISO2List,
                                                  allowedCountriesResponse:
                                                      allowedCountriesResponse,
                                                  selectedCountryId:
                                                      selectedCountryId,
                                                  allowedVendorStatesResponse:
                                                      allowedVendorStatesResponse,
                                                  allowedVendorCityResponse:
                                                      allowedVendorCityResponse,
                                                  creditCardPayment:
                                                      creditCardPayment,
                                                  countriesAreSame:
                                                      widget.countriesAreSame,
                                                  globalShipping:
                                                      widget.globalShipping,
                                                  shippingAvailable:
                                                      widget.shippingAvailable,
                                                  shippingAvailableCity: widget
                                                      .shippingAvailableCity,
                                                  shippingAvailableCountryID: widget
                                                      .shippingAvailableCountryID,
                                                  globalShippingCountry: widget
                                                      .globalShippingCountry)),
                                    );
                                  } else if (selectedCountryId == 226) {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           CheckoutAddressScreen(
                                    //             cartDetailsResponse:
                                    //                 widget.cartDetailsResponse,
                                    //             allowedCountriesISO2List:
                                    //                 allowedCountriesISO2List,
                                    //             allowedCountriesResponse:
                                    //                 allowedCountriesResponse,
                                    //             selectedCountryId:
                                    //                 selectedCountryId,
                                    //             allowedVendorStatesResponse:
                                    //                 allowedVendorStatesResponse,
                                    //             allowedVendorCityResponse:
                                    //                 allowedVendorCityResponse,
                                    //             creditCardPayment:
                                    //                 creditCardPayment,
                                    //           )),
                                    // );
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Product and delivery country should be same.',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey.shade400,
                                      textColor: Colors.white,
                                      fontSize: 12.0);
                                }
                              } else if (widget.shippingAvailable == true &&
                                  widget.globalShipping == false) {
                                if (selectedCountryId ==
                                    widget.shippingAvailableCountryID) {
                                  if (selectedCountryId == 16) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BangladeshCheckoutAddressScreen(
                                                  cartDetailsResponse: widget
                                                      .cartDetailsResponse,
                                                  allowedCountriesISO2List:
                                                      allowedCountriesISO2List,
                                                  allowedCountriesResponse:
                                                      allowedCountriesResponse,
                                                  selectedCountryId:
                                                      selectedCountryId,
                                                  allowedVendorStatesResponse:
                                                      allowedVendorStatesResponse,
                                                  allowedVendorCityResponse:
                                                      allowedVendorCityResponse,
                                                  creditCardPayment:
                                                      creditCardPayment,
                                                  countriesAreSame:
                                                      widget.countriesAreSame,
                                                  globalShipping:
                                                      widget.globalShipping,
                                                  shippingAvailable:
                                                      widget.shippingAvailable,
                                                  shippingAvailableCity: widget
                                                      .shippingAvailableCity,
                                                  shippingAvailableCountryID: widget
                                                      .shippingAvailableCountryID,
                                                  globalShippingCountry: widget
                                                      .globalShippingCountry)),
                                    );
                                  } else if (selectedCountryId == 226) {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           CheckoutAddressScreen(
                                    //             cartDetailsResponse:
                                    //                 widget.cartDetailsResponse,
                                    //             allowedCountriesISO2List:
                                    //                 allowedCountriesISO2List,
                                    //             allowedCountriesResponse:
                                    //                 allowedCountriesResponse,
                                    //             selectedCountryId:
                                    //                 selectedCountryId,
                                    //             allowedVendorStatesResponse:
                                    //                 allowedVendorStatesResponse,
                                    //             allowedVendorCityResponse:
                                    //                 allowedVendorCityResponse,
                                    //             creditCardPayment:
                                    //                 creditCardPayment,
                                    //           )),
                                    // );
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Product and delivery country should be same.',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey.shade400,
                                      textColor: Colors.white,
                                      fontSize: 12.0);
                                }
                              } else if (widget.shippingAvailable == true &&
                                  widget.globalShipping == true) {
                                if (selectedCountryId == 16) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BangladeshCheckoutAddressScreen(
                                                cartDetailsResponse:
                                                    widget.cartDetailsResponse,
                                                allowedCountriesISO2List:
                                                    allowedCountriesISO2List,
                                                allowedCountriesResponse:
                                                    allowedCountriesResponse,
                                                selectedCountryId:
                                                    selectedCountryId,
                                                allowedVendorStatesResponse:
                                                    allowedVendorStatesResponse,
                                                allowedVendorCityResponse:
                                                    allowedVendorCityResponse,
                                                creditCardPayment:
                                                    creditCardPayment,
                                                countriesAreSame:
                                                    widget.countriesAreSame,
                                                globalShipping:
                                                    widget.globalShipping,
                                                shippingAvailable:
                                                    widget.shippingAvailable,
                                                shippingAvailableCity: widget
                                                    .shippingAvailableCity,
                                                shippingAvailableCountryID: widget
                                                    .shippingAvailableCountryID,
                                                globalShippingCountry: widget
                                                    .globalShippingCountry)),
                                  );
                                } else if (selectedCountryId == 226) {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           CheckoutAddressScreen(
                                  //             cartDetailsResponse:
                                  //                 widget.cartDetailsResponse,
                                  //             allowedCountriesISO2List:
                                  //                 allowedCountriesISO2List,
                                  //             allowedCountriesResponse:
                                  //                 allowedCountriesResponse,
                                  //             selectedCountryId:
                                  //                 selectedCountryId,
                                  //             allowedVendorStatesResponse:
                                  //                 allowedVendorStatesResponse,
                                  //             allowedVendorCityResponse:
                                  //                 allowedVendorCityResponse,
                                  //             creditCardPayment:
                                  //                 creditCardPayment,
                                  //           )),
                                  // );
                                }
                              }
                            },
                            child: Container(
                              height: screenSize.height * 0.065,
                              width: screenSize.width * 0.50,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: kColorPrimary,
                              ),
                              child: const Center(
                                child: Text(
                                  'Continue',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: kColorWhite, fontSize: 14),
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

                  // _cartBloc.add(GetVendorAllowedStates(
                  //     id: allowedCountriesResponse.countries[i].CountryID));
                  // _cartBloc.add(GetVendorAllowedCities(
                  //     id: allowedCountriesResponse.countries[i].CountryID));
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

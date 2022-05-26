import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AddDriverModel {
  late String address1;
  late String address2;
  late String phoneCode;
  late String phoneNumber;
  late String zipCode;
  late String state;
  late String city;
  late String govID;
  late XFile? govIDImage;
  late String paymentAc;
  late String paymentRout;
  late String businessEmail;

  late String gatewayID;
  int? cityID;
  int? countryID;
  bool? registerAc = true;
  AddDriverModel(
      {required this.address1,
      required this.address2,
      required this.phoneCode,
      required this.phoneNumber,
      required this.zipCode,
      required this.state,
      required this.city,
      required this.govID,
      required this.govIDImage,
      required this.paymentAc,
      required this.paymentRout,
      required this.businessEmail,
      required this.gatewayID,
      this.cityID,
      this.countryID,
      this.registerAc});
}

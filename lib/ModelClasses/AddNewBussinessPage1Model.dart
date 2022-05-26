import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AddBusinessPage1Data {
  late String name;
  late String address1;
  late String address2;
  late String phoneCode;
  late String phoneNumber;
  late String country;
  late String zipCode;
  late String state;
  late String city;
  late String textID;
  late XFile? textIDImage;
  late String govID;
  late XFile? govIDImage;
  late XFile? companyLogoImage;
  late String paymentAc;
  late String paymentRout;
  late String businessEmail;
  late String businessPhoneCode;
  late String businessPhoneNumber;
  late String businessURL;
  late String gatewayID;
  late String createdAtDate;
  late String allowDelivery;
  late String allowStorePickup;
  late String productApproval;
  late String adminNote;
  int? cityID;
  int? countryID;
  AddBusinessPage1Data(
      {required this.name,
      required this.address1,
      required this.address2,
      required this.phoneCode,
      required this.phoneNumber,
      required this.country,
      required this.zipCode,
      required this.state,
      required this.city,
      required this.textID,
      required this.textIDImage,
      required this.govID,
      required this.govIDImage,
      required this.companyLogoImage,
      required this.paymentAc,
      required this.paymentRout,
      required this.businessEmail,
      required this.businessPhoneCode,
      required this.businessPhoneNumber,
      required this.businessURL,
      required this.gatewayID,
      required this.createdAtDate,
      required this.allowDelivery,
      required this.allowStorePickup,
      required this.productApproval,
      required this.adminNote,
      this.cityID,
      this.countryID});
}

class PaymentUserData {
  late String name;
  late String address1;
  late String address2;
  late String phoneCode;
  late String phoneNumber;
  late String country;
  late String zipCode;
  late String? state;
  late String city;
  late String createdAtDate;
  late String adminNote;
  int? cityID;
  int? countryID;
  bool? banglaBazarDelivery = false;
  bool? pickUp = false;

  ///For delivery address

  late String nameDelivery;
  late String address1Delivery;
  late String address2Delivery;
  late String phoneCodeDelivery;
  late String phoneNumberDelivery;
  late String zipCodeDelivery;
  late String? stateDelivery;
  late String cityDelivery;
  late String adminNoteDelivery;

  PaymentUserData({
    required this.name,
    required this.address1,
    required this.address2,
    required this.phoneCode,
    required this.phoneNumber,
    required this.country,
    required this.zipCode,
    this.state,
    required this.city,
    required this.createdAtDate,
    required this.adminNote,
    this.cityID,
    this.countryID,
    this.banglaBazarDelivery,
    this.pickUp,
    required this.nameDelivery,
    required this.address1Delivery,
    required this.address2Delivery,
    required this.phoneCodeDelivery,
    required this.phoneNumberDelivery,
    required this.zipCodeDelivery,
    this.stateDelivery,
    required this.cityDelivery,
    required this.adminNoteDelivery,
  });
}

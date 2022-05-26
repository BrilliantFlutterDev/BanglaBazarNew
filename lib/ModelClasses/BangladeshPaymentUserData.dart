class BangladeshPaymentUserData {
  late int selectedPaymentCountry;
  late String? name;
  late String? cardNumber;
  late String? address1;
  late String? address2;
  late String phoneCode;
  late String phoneNumber;
  late String country;
  late int countryID;
  late String zipCode;
  late String state;
  late String? city;
  late String? createdAtDate;
  late int selectedDeliveryCountry;
  bool? banglaBazarDelivery = false;
  bool? pickUp = false;

  ///For delivery address

  late String nameDelivery;
  late String address1Delivery;
  late String address2Delivery;
  late String phoneCodeDelivery;
  late String phoneNumberDelivery;
  late String zipCodeDelivery;
  late String nickNameDelivery;
  late String zoneDelivery;
  late String cityDelivery;
  late String areaDelivery;
  late int zoneDeliveryID;
  late int cityDeliveryID;
  late int areaDeliveryID;
  late String? adminNoteDelivery;

  late double shippingPrice;

  bool savePaymentAddress;
  bool saveDeliveryAddress;

  BangladeshPaymentUserData(
      {required this.selectedPaymentCountry,
      required this.name,
      required this.cardNumber,
      required this.address1,
      required this.address2,
      required this.phoneCode,
      required this.phoneNumber,
      required this.country,
      required this.countryID,
      required this.zipCode,
      required this.state,
      required this.city,
      required this.createdAtDate,
      required this.selectedDeliveryCountry,
      this.banglaBazarDelivery,
      this.pickUp,
      required this.nameDelivery,
      required this.address1Delivery,
      required this.address2Delivery,
      required this.phoneCodeDelivery,
      required this.phoneNumberDelivery,
      required this.zipCodeDelivery,
      required this.cityDelivery,
      required this.zoneDelivery,
      required this.areaDelivery,
      required this.cityDeliveryID,
      required this.areaDeliveryID,
      required this.zoneDeliveryID,
      required this.nickNameDelivery,
      required this.adminNoteDelivery,
      required this.shippingPrice,
      required this.savePaymentAddress,
      required this.saveDeliveryAddress});
}

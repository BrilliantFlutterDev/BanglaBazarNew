class AddBusinessPage2Data {
  late String vendorID;
  late String storeName;
  late String storeEmail;
  late String storePhoneCode;
  late String storephoneNumber;
  late String storeAddress1;
  late String storeAddress2;
  late String storeCountry;
  late String storeZipCode;
  late String? storeState;
  late String? storeCity;
  late String storeFax;
  late String storeURL;
  late String active;
  late String storeAdminNote;
  late String? pathaoAccessToken;
  late int? pathaoCityId;
  late int? dbPathaoCityId;
  late int? pathaoZoneId;
  late int? pathaoAreaId;
  AddBusinessPage2Data(
      {required this.vendorID,
      required this.storeName,
      required this.storeEmail,
      required this.storePhoneCode,
      required this.storephoneNumber,
      required this.storeAddress1,
      required this.storeAddress2,
      required this.storeCountry,
      required this.storeZipCode,
      required this.storeState,
      required this.storeCity,
      required this.storeFax,
      required this.storeURL,
      required this.active,
      required this.storeAdminNote,
      this.pathaoCityId,
      this.pathaoZoneId,
      this.pathaoAreaId,
      this.dbPathaoCityId,
      this.pathaoAccessToken});
}

class UspsAddressVerifyResponse {
  UspsAddressVerifyResponse({
    required this.status,
    this.data,
    this.errorData,
    required this.message,
  });
  late final bool status;
  Data? data;
  ErrorData? errorData;
  late final String message;

  UspsAddressVerifyResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    // errorData = json['ErrorData'] != null
    //     ? ErrorData.fromJson(json['ErrorData'])
    //     : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data!.toJson();
    _data['ErrorData'] = errorData!.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.address,
  });
  late final Address address;

  Data.fromJson(Map<String, dynamic> json) {
    address = Address.fromJson(json['Address']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Address'] = address.toJson();
    return _data;
  }
}

class Address {
  Address({
    required this.attributes,
    required this.address1,
    required this.address2,
    required this.city,
    required this.cityAbbreviation,
    required this.state,
    required this.zip5,
    required this.zip4,
    required this.deliveryPoint,
    required this.carrierRoute,
    required this.footnotes,
    required this.dPVConfirmation,
    required this.dPVCMRA,
    required this.dPVFootnotes,
    required this.business,
    required this.centralDeliveryPoint,
    required this.vacant,
  });
  late final Attributes attributes;
  late final Address1 address1;
  late final Address2 address2;
  late final City city;
  late final CityAbbreviation cityAbbreviation;
  late final State state;
  late final Zip5 zip5;
  late final Zip4 zip4;
  late final DeliveryPoint deliveryPoint;
  late final CarrierRoute carrierRoute;
  late final Footnotes footnotes;
  late final DPVConfirmation dPVConfirmation;
  late final DPVCMRA dPVCMRA;
  late final DPVFootnotes dPVFootnotes;
  late final Business business;
  late final CentralDeliveryPoint centralDeliveryPoint;
  late final Vacant vacant;

  Address.fromJson(Map<String, dynamic> json) {
    attributes = Attributes.fromJson(json['_attributes']);
    address1 = Address1.fromJson(json['Address1']);
    address2 = Address2.fromJson(json['Address2']);
    city = City.fromJson(json['City']);
    //cityAbbreviation = CityAbbreviation.fromJson(json['CityAbbreviation']);
    state = State.fromJson(json['State']);
    zip5 = Zip5.fromJson(json['Zip5']);
    zip4 = Zip4.fromJson(json['Zip4']);
    deliveryPoint = DeliveryPoint.fromJson(json['DeliveryPoint']);
    carrierRoute = CarrierRoute.fromJson(json['CarrierRoute']);
    // //footnotes = Footnotes.fromJson(json['Footnotes']);
    dPVConfirmation = DPVConfirmation.fromJson(json['DPVConfirmation']);
    dPVCMRA = DPVCMRA.fromJson(json['DPVCMRA']);
    dPVFootnotes = DPVFootnotes.fromJson(json['DPVFootnotes']);
    business = Business.fromJson(json['Business']);
    centralDeliveryPoint =
        CentralDeliveryPoint.fromJson(json['CentralDeliveryPoint']);
    vacant = Vacant.fromJson(json['Vacant']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_attributes'] = attributes.toJson();
    _data['Address1'] = address1.toJson();
    _data['Address2'] = address2.toJson();
    _data['City'] = city.toJson();
    _data['CityAbbreviation'] = cityAbbreviation.toJson();
    _data['State'] = state.toJson();
    _data['Zip5'] = zip5.toJson();
    _data['Zip4'] = zip4.toJson();
    _data['DeliveryPoint'] = deliveryPoint.toJson();
    _data['CarrierRoute'] = carrierRoute.toJson();
    _data['Footnotes'] = footnotes.toJson();
    _data['DPVConfirmation'] = dPVConfirmation.toJson();
    _data['DPVCMRA'] = dPVCMRA.toJson();
    _data['DPVFootnotes'] = dPVFootnotes.toJson();
    _data['Business'] = business.toJson();
    _data['CentralDeliveryPoint'] = centralDeliveryPoint.toJson();
    _data['Vacant'] = vacant.toJson();
    return _data;
  }
}

class Attributes {
  Attributes({
    required this.ID,
  });
  late final String ID;

  Attributes.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ID'] = ID;
    return _data;
  }
}

class Address1 {
  Address1({
    required this.text,
  });
  late final String text;

  Address1.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class Address2 {
  Address2({
    required this.text,
  });
  late final String text;

  Address2.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class City {
  City({
    required this.text,
  });
  late final String text;

  City.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class CityAbbreviation {
  CityAbbreviation({
    required this.text,
  });
  late final String text;

  CityAbbreviation.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class State {
  State({
    required this.text,
  });
  late final String text;

  State.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class Zip5 {
  Zip5({
    required this.text,
  });
  late final String text;

  Zip5.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class Zip4 {
  Zip4({
    required this.text,
  });
  late final String text;

  Zip4.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class DeliveryPoint {
  DeliveryPoint({
    required this.text,
  });
  late final String text;

  DeliveryPoint.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class CarrierRoute {
  CarrierRoute({
    required this.text,
  });
  late final String text;

  CarrierRoute.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class Footnotes {
  Footnotes({
    required this.text,
  });
  late final String text;

  Footnotes.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class DPVConfirmation {
  DPVConfirmation({
    required this.text,
  });
  late final String text;

  DPVConfirmation.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class DPVCMRA {
  DPVCMRA({
    required this.text,
  });
  late final String text;

  DPVCMRA.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class DPVFootnotes {
  DPVFootnotes({
    required this.text,
  });
  late final String text;

  DPVFootnotes.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class Business {
  Business({
    required this.text,
  });
  late final String text;

  Business.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class CentralDeliveryPoint {
  CentralDeliveryPoint({
    required this.text,
  });
  late final String text;

  CentralDeliveryPoint.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class Vacant {
  Vacant({
    required this.text,
  });
  late final String text;

  Vacant.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class ErrorData {
  ErrorData({
    required this.address,
  });
  late final AddressE address;

  ErrorData.fromJson(Map<String, dynamic> json) {
    address = AddressE.fromJson(json['Address']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Address'] = address.toJson();
    return _data;
  }
}

class AddressE {
  AddressE({
    required this.attributes,
    required this.error,
  });
  late final AttributesE attributes;
  late final ErrorE error;

  AddressE.fromJson(Map<String, dynamic> json) {
    attributes = AttributesE.fromJson(json['_attributes']);
    error = ErrorE.fromJson(json['Error']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_attributes'] = attributes.toJson();
    _data['Error'] = error.toJson();
    return _data;
  }
}

class AttributesE {
  AttributesE({
    required this.ID,
  });
  late final String ID;

  AttributesE.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ID'] = ID;
    return _data;
  }
}

class ErrorE {
  ErrorE({
    required this.Number,
    required this.Source,
    required this.Description,
    required this.HelpFile,
    required this.HelpContext,
  });
  late final NumberE Number;
  late final SourceE Source;
  late final DescriptionE Description;
  late final HelpFileE HelpFile;
  late final HelpContextE HelpContext;

  ErrorE.fromJson(Map<String, dynamic> json) {
    Number = NumberE.fromJson(json['Number']);
    Source = SourceE.fromJson(json['Source']);
    Description = DescriptionE.fromJson(json['Description']);
    HelpFile = HelpFileE.fromJson(json['HelpFile']);
    HelpContext = HelpContextE.fromJson(json['HelpContext']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Number'] = Number.toJson();
    _data['Source'] = Source.toJson();
    _data['Description'] = Description.toJson();
    _data['HelpFile'] = HelpFile.toJson();
    _data['HelpContext'] = HelpContext.toJson();
    return _data;
  }
}

class NumberE {
  NumberE({
    required this.text,
  });
  late final String text;

  NumberE.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class SourceE {
  SourceE({
    required this.text,
  });
  late final String text;

  SourceE.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class DescriptionE {
  DescriptionE({
    required this.text,
  });
  late final String text;

  DescriptionE.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class HelpFileE {
  HelpFileE();

  HelpFileE.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

class HelpContextE {
  HelpContextE();

  HelpContextE.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

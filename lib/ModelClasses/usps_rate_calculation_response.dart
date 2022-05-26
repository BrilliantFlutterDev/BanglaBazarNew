class UspsRateCalculationResponse {
  UspsRateCalculationResponse({
    required this.status,
    this.data,
    this.ErrorData,
    required this.message,
  });
  late final bool status;
  Data? data;
  ErrorDataE? ErrorData;
  late final String message;

  UspsRateCalculationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    ErrorData = json['ErrorData'] != null
        ? ErrorDataE.fromJson(json['ErrorData'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data!.toJson();
    _data['ErrorData'] = ErrorData!.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.Package,
  });
  late final PackageD Package;

  Data.fromJson(Map<String, dynamic> json) {
    Package = PackageD.fromJson(json['Package']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Package'] = Package.toJson();
    return _data;
  }
}

class PackageD {
  PackageD({
    required this.attributes,
    required this.ZipOrigination,
    required this.ZipDestination,
    required this.Pounds,
    required this.Ounces,
    required this.Container,
    required this.Zone,
    required this.Postage,
  });
  late final Attributes attributes;
  late final ZipOriginationD ZipOrigination;
  late final ZipDestinationD ZipDestination;
  late final PoundsD Pounds;
  late final OuncesD Ounces;
  late final ContainerD Container;
  late final ZoneD Zone;
  late final PostageD Postage;

  PackageD.fromJson(Map<String, dynamic> json) {
    attributes = Attributes.fromJson(json['_attributes']);
    ZipOrigination = ZipOriginationD.fromJson(json['ZipOrigination']);
    ZipDestination = ZipDestinationD.fromJson(json['ZipDestination']);
    Pounds = PoundsD.fromJson(json['Pounds']);
    Ounces = OuncesD.fromJson(json['Ounces']);
    Container = ContainerD.fromJson(json['Container']);
    Zone = ZoneD.fromJson(json['Zone']);
    Postage = PostageD.fromJson(json['Postage']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_attributes'] = attributes.toJson();
    _data['ZipOrigination'] = ZipOrigination.toJson();
    _data['ZipDestination'] = ZipDestination.toJson();
    _data['Pounds'] = Pounds.toJson();
    _data['Ounces'] = Ounces.toJson();
    _data['Container'] = Container.toJson();
    _data['Zone'] = Zone.toJson();
    _data['Postage'] = Postage.toJson();
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

class ZipOriginationD {
  ZipOriginationD({
    required this.text,
  });
  late final String text;

  ZipOriginationD.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class ZipDestinationD {
  ZipDestinationD({
    required this.text,
  });
  late final String text;

  ZipDestinationD.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class PoundsD {
  PoundsD({
    required this.text,
  });
  late final String text;

  PoundsD.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class OuncesD {
  OuncesD({
    required this.text,
  });
  late final String text;

  OuncesD.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class ContainerD {
  ContainerD({
    required this.text,
  });
  late final String text;

  ContainerD.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class ZoneD {
  ZoneD({
    required this.text,
  });
  late final String text;

  ZoneD.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class PostageD {
  PostageD({
    required this.attributes,
    required this.MailService,
    required this.Rate,
    required this.SpecialServices,
  });
  late final Attributes attributes;
  late final MailServiceD MailService;
  late final RateD Rate;
  late final SpecialServicesD SpecialServices;

  PostageD.fromJson(Map<String, dynamic> json) {
    //attributes = Attributes.fromJson(json['_attributes']);
    MailService = MailServiceD.fromJson(json['MailService']);
    Rate = RateD.fromJson(json['Rate']);
    SpecialServices = SpecialServicesD.fromJson(json['SpecialServices']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_attributes'] = attributes.toJson();
    _data['MailService'] = MailService.toJson();
    _data['Rate'] = Rate.toJson();
    _data['SpecialServices'] = SpecialServices.toJson();
    return _data;
  }
}

class MailServiceD {
  MailServiceD({
    required this.text,
  });
  late final String text;

  MailServiceD.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class RateD {
  RateD({
    required this.text,
  });
  late final String text;

  RateD.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class SpecialServicesD {
  SpecialServicesD({
    required this.SpecialService,
  });
  late final List<SpecialServiceD> SpecialService;

  SpecialServicesD.fromJson(Map<String, dynamic> json) {
    SpecialService = List.from(json['SpecialService'])
        .map((e) => SpecialServiceD.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['SpecialService'] = SpecialService.map((e) => e.toJson()).toList();
    return _data;
  }
}

class SpecialServiceD {
  SpecialServiceD({
    required this.ServiceID,
    required this.ServiceName,
    required this.Available,
    required this.Price,
  });
  late final ServiceIDD ServiceID;
  late final ServiceNameD ServiceName;
  late final AvailableD Available;
  late final PriceD Price;

  SpecialServiceD.fromJson(Map<String, dynamic> json) {
    ServiceID = ServiceIDD.fromJson(json['ServiceID']);
    ServiceName = ServiceNameD.fromJson(json['ServiceName']);
    Available = AvailableD.fromJson(json['Available']);
    Price = PriceD.fromJson(json['Price']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ServiceID'] = ServiceID.toJson();
    _data['ServiceName'] = ServiceName.toJson();
    _data['Available'] = Available.toJson();
    _data['Price'] = Price.toJson();
    return _data;
  }
}

class ServiceIDD {
  ServiceIDD({
    required this.text,
  });
  late final String text;

  ServiceIDD.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class ServiceNameD {
  ServiceNameD({
    required this.text,
  });
  late final String text;

  ServiceNameD.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class AvailableD {
  AvailableD({
    required this.text,
  });
  late final String text;

  AvailableD.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class PriceD {
  PriceD({
    required this.text,
  });
  late final String text;

  PriceD.fromJson(Map<String, dynamic> json) {
    text = json['_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_text'] = text;
    return _data;
  }
}

class ErrorDataE {
  ErrorDataE({
    required this.declaration,
    required this.RateV4Response,
  });
  late final DeclarationE declaration;
  late final RateV4ResponseE RateV4Response;

  ErrorDataE.fromJson(Map<String, dynamic> json) {
    declaration = DeclarationE.fromJson(json['_declaration']);
    RateV4Response = RateV4ResponseE.fromJson(json['RateV4Response']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_declaration'] = declaration.toJson();
    _data['RateV4Response'] = RateV4Response.toJson();
    return _data;
  }
}

class DeclarationE {
  DeclarationE({
    required this.attributes,
  });
  late final AttributesE attributes;

  DeclarationE.fromJson(Map<String, dynamic> json) {
    attributes = AttributesE.fromJson(json['_attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_attributes'] = attributes.toJson();
    return _data;
  }
}

class AttributesE {
  AttributesE({
    required this.version,
    required this.encoding,
  });
  late final String version;
  late final String encoding;

  AttributesE.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    encoding = json['encoding'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['version'] = version;
    _data['encoding'] = encoding;
    return _data;
  }
}

class RateV4ResponseE {
  RateV4ResponseE({
    required this.Package,
  });
  late final PackageE Package;

  RateV4ResponseE.fromJson(Map<String, dynamic> json) {
    Package = PackageE.fromJson(json['Package']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Package'] = Package.toJson();
    return _data;
  }
}

class PackageE {
  PackageE({
    required this.attributes,
    required this.Error,
  });
  late final AttributesE attributes;
  late final ErrorE Error;

  PackageE.fromJson(Map<String, dynamic> json) {
    attributes = AttributesE.fromJson(json['_attributes']);
    Error = ErrorE.fromJson(json['Error']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_attributes'] = attributes.toJson();
    _data['Error'] = Error.toJson();
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

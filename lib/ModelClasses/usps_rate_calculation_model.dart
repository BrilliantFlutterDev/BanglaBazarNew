class UspsRateCalculationModel {
  UspsRateCalculationModel({
    required this.originationZip,
    required this.destinationZip,
    required this.pounds,
    required this.ounces,
    required this.height,
    required this.width,
    required this.length,
  });
  late final int originationZip;
  late final int destinationZip;
  late final int pounds;
  late final int ounces;
  late final int height;
  late final int width;
  late final int length;

  UspsRateCalculationModel.fromJson(Map<String, dynamic> json) {
    originationZip = json['originationZip'];
    destinationZip = json['destinationZip'];
    pounds = json['pounds'];
    ounces = json['ounces'];
    height = json['height'];
    width = json['width'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['originationZip'] = originationZip;
    _data['destinationZip'] = destinationZip;
    _data['pounds'] = pounds;
    _data['ounces'] = ounces;
    _data['height'] = height;
    _data['width'] = width;
    _data['length'] = length;
    return _data;
  }
}

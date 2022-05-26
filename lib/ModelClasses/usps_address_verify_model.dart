class UspsAddressVerifyModel {
  UspsAddressVerifyModel({
    required this.address1,
    required this.address2,
    required this.state,
    required this.zip,
  });
  late final String address1;
  late final String address2;
  late final String state;
  late final String zip;

  UspsAddressVerifyModel.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    state = json['state'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address1'] = address1;
    _data['address2'] = address2;
    _data['state'] = state;
    _data['zip'] = zip;
    return _data;
  }
}

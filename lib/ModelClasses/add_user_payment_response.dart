class AddUserPaymentResponse {
  AddUserPaymentResponse({
    required this.status,
    required this.message,
    required this.UserPaymentID,
    required this.UserAddressID,
  });
  late final bool status;
  late final String message;
  late final int UserPaymentID;
  late final int UserAddressID;

  AddUserPaymentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    UserPaymentID = json['UserPaymentID'];
    UserAddressID = json['UserAddressID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['UserPaymentID'] = UserPaymentID;
    _data['UserAddressID'] = UserAddressID;
    return _data;
  }
}

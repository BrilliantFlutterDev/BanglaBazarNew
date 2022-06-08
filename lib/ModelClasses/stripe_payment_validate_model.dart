class StripePaymentValidateModel {
  StripePaymentValidateModel({
    required this.OrderNumber,
    required this.PaymentSuccessResponse,
  });
  late final String OrderNumber;
  late final String PaymentSuccessResponse;

  StripePaymentValidateModel.fromJson(Map<String, dynamic> json) {
    OrderNumber = json['OrderNumber'];
    PaymentSuccessResponse = json['PaymentSuccessResponse'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['OrderNumber'] = OrderNumber;
    _data['PaymentSuccessResponse'] = PaymentSuccessResponse;
    return _data;
  }
}

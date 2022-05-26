class PathaoPriceCalculationResponse {
  PathaoPriceCalculationResponse({
    required this.status,
    required this.saveResponse,
  });
  late final bool status;
  late final List<SaveResponse> saveResponse;

  PathaoPriceCalculationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    saveResponse = List.from(json['saveResponse'])
        .map((e) => SaveResponse.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['saveResponse'] = saveResponse.map((e) => e.toJson()).toList();
    return _data;
  }
}

class SaveResponse {
  SaveResponse({
    required this.message,
    required this.type,
    required this.code,
    required this.data,
  });
  late final String message;
  late final String type;
  late final int code;
  late final Data data;

  SaveResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    type = json['type'];
    code = json['code'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['type'] = type;
    _data['code'] = code;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.price,
    required this.discount,
    required this.promoDiscount,
    required this.planId,
    required this.codEnabled,
    required this.additionalCharge,
  });
  late final int price;
  late final int discount;
  late final int promoDiscount;
  late final int planId;
  late final int codEnabled;
  late final int additionalCharge;

  Data.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    discount = json['discount'];
    promoDiscount = json['promo_discount'];
    planId = json['plan_id'];
    codEnabled = json['cod_enabled'];
    additionalCharge = json['additional_charge'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['price'] = price;
    _data['discount'] = discount;
    _data['promo_discount'] = promoDiscount;
    _data['plan_id'] = planId;
    _data['cod_enabled'] = codEnabled;
    _data['additional_charge'] = additionalCharge;
    return _data;
  }
}

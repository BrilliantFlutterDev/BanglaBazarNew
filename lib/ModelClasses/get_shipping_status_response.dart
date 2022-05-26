class GetShippingDetailsResponse {
  GetShippingDetailsResponse({
    required this.status,
    required this.banglaBazarPickup,
    required this.pickUpByUser,
  });
  late final bool status;
  late final bool banglaBazarPickup;
  late final bool pickUpByUser;

  GetShippingDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    banglaBazarPickup = json['banglaBazarPickup'];
    pickUpByUser = json['pickUpByUser'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['banglaBazarPickup'] = banglaBazarPickup;
    _data['pickUpByUser'] = pickUpByUser;
    return _data;
  }
}

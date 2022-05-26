class DashBoardModel {
  DashBoardModel({
    required this.DeliveryDriverID,
    required this.filter,
  });
  late final String DeliveryDriverID;
  late final String filter;

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    DeliveryDriverID = json['DeliveryDriverID'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['DeliveryDriverID'] = DeliveryDriverID;
    _data['filter'] = filter;
    return _data;
  }
}

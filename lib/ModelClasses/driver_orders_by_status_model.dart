class DriverOrdersByStatusModel {
  DriverOrdersByStatusModel({
    required this.sort,
    required this.status,
    required this.limit,
    required this.offset,
    required this.DeliveryDriverID,
  });
  late final String sort;
  late final String status;
  late final String limit;
  late final String offset;
  late final String DeliveryDriverID;

  DriverOrdersByStatusModel.fromJson(Map<String, dynamic> json) {
    sort = json['sort'];
    status = json['status'];
    limit = json['limit'];
    offset = json['offset'];
    DeliveryDriverID = json['DeliveryDriverID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sort'] = sort;
    _data['status'] = status;
    _data['limit'] = limit;
    _data['offset'] = offset;
    _data['DeliveryDriverID'] = DeliveryDriverID;
    return _data;
  }
}

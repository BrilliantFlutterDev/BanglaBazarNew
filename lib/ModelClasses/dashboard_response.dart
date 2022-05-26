class DashBoardResponse {
  DashBoardResponse({
    required this.status,
    required this.driverOrderStatusCount,
    required this.getDriverCollectedAmout,
  });
  late final bool status;
  late final DriverOrderStatusCount driverOrderStatusCount;
  late final GetDriverCollectedAmout getDriverCollectedAmout;

  DashBoardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    driverOrderStatusCount =
        DriverOrderStatusCount.fromJson(json['driverOrderStatusCount']);
    getDriverCollectedAmout =
        GetDriverCollectedAmout.fromJson(json['getDriverCollectedAmout']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['driverOrderStatusCount'] = driverOrderStatusCount.toJson();
    _data['getDriverCollectedAmout'] = getDriverCollectedAmout.toJson();
    return _data;
  }
}

class DriverOrderStatusCount {
  DriverOrderStatusCount({
    required this.DeliveredOrders,
    required this.AssignedOrders,
    required this.ReturnedOrders,
    required this.PickedOrders,
    required this.CancelledOrders,
    required this.TobeReturnedOrders,
    required this.OntheWayOrders,
  });
  late final int DeliveredOrders;
  late final int AssignedOrders;
  late final int ReturnedOrders;
  late final int PickedOrders;
  late final int CancelledOrders;
  late final int TobeReturnedOrders;
  late final int OntheWayOrders;

  DriverOrderStatusCount.fromJson(Map<String, dynamic> json) {
    DeliveredOrders = json['DeliveredOrders'];
    AssignedOrders = json['AssignedOrders'];
    ReturnedOrders = json['ReturnedOrders'];
    PickedOrders = json['PickedOrders'];
    CancelledOrders = json['CancelledOrders'];
    TobeReturnedOrders = json['TobeReturnedOrders'];
    OntheWayOrders = json['OntheWayOrders'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['DeliveredOrders'] = DeliveredOrders;
    _data['AssignedOrders'] = AssignedOrders;
    _data['ReturnedOrders'] = ReturnedOrders;
    _data['PickedOrders'] = PickedOrders;
    _data['CancelledOrders'] = CancelledOrders;
    _data['TobeReturnedOrders'] = TobeReturnedOrders;
    _data['OntheWayOrders'] = OntheWayOrders;
    return _data;
  }
}

class GetDriverCollectedAmout {
  GetDriverCollectedAmout({
    this.TotalCollected,
  });
  String? TotalCollected;

  GetDriverCollectedAmout.fromJson(Map<String, dynamic> json) {
    TotalCollected = json['TotalCollected'] ?? '0';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['TotalCollected'] = TotalCollected;
    return _data;
  }
}

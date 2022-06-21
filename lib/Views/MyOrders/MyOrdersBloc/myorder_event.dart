part of 'myorder_bloc.dart';

abstract class MyOrdersEvent {}

class GetMyOrders extends MyOrdersEvent {
  final String search;
  final int offset;
  GetMyOrders({required this.offset, required this.search});
}

class GetOrderDetails extends MyOrdersEvent {
  final String orderNumber;
  GetOrderDetails({required this.orderNumber});
}

class ReturnOrder extends MyOrdersEvent {
  final OrderReturnModel orderReturnModel;
  ReturnOrder({required this.orderReturnModel});
}

class UserReturnOrder extends MyOrdersEvent {
  final UserRefundFormModel userRefundFormModel;
  UserReturnOrder({required this.userRefundFormModel});
}

class OrderStatusChange extends MyOrdersEvent {
  final OrderStatusChangeModel orderStatusChangeModel;
  OrderStatusChange({required this.orderStatusChangeModel});
}
class OrderStatusChangePic extends MyOrdersEvent {
  final OrderStatusChangeModel orderStatusChangeModel;
  var selectedImage;
  OrderStatusChangePic({required this.orderStatusChangeModel,required this.selectedImage});
}

class DashBoard extends MyOrdersEvent {
  final DashBoardModel dashBoardModel;
  DashBoard({required this.dashBoardModel});
}

class GetDriversOrders extends MyOrdersEvent {
  final int offset;
  final String status;
  GetDriversOrders({required this.offset, required this.status});
}

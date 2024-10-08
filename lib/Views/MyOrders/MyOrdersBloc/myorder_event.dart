part of 'myorder_bloc.dart';

abstract class MyOrdersEvent {}

class GetMyOrders extends MyOrdersEvent {
  GetMyOrders();
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

class DashBoard extends MyOrdersEvent {
  final DashBoardModel dashBoardModel;
  DashBoard({required this.dashBoardModel});
}

class GetDriversOrders extends MyOrdersEvent {
  final int offset;
  final String status;
  GetDriversOrders({required this.offset, required this.status});
}

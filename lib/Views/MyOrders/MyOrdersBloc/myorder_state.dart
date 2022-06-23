part of 'myorder_bloc.dart';

@immutable
abstract class MyOrdersState {}

class MyOrdersInitial extends MyOrdersState {}

class LoadingState extends MyOrdersState {}

class ErrorState extends MyOrdersState {
  final String error;
  ErrorState({required this.error});
}

class InternetErrorState extends MyOrdersState {
  final String error;
  InternetErrorState({required this.error});
}

class GetMyOrdersState extends MyOrdersState {
  final OrderDetailsResponse orderDetailsResponse;
  GetMyOrdersState({required this.orderDetailsResponse});
}

class GetOrderDetailsState extends MyOrdersState {
  final GetOrderDetailsResponse getOrderDetailsResponse;
  GetOrderDetailsState({required this.getOrderDetailsResponse});
}

class OrderStatusChangeState extends MyOrdersState {
  final OrderStatusChangeResponse orderStatusChangeResponse;
  OrderStatusChangeState({required this.orderStatusChangeResponse});
}

class UserOrderReturnState extends MyOrdersState {
  final OrderStatusChangeResponse orderStatusChangeResponse;
  UserOrderReturnState({required this.orderStatusChangeResponse});
}

class DashBoardState extends MyOrdersState {
  final DashBoardResponse dashBoardResponse;
  DashBoardState({required this.dashBoardResponse});
}

class GetDriverOrdersState extends MyOrdersState {
  final GetDriverOrdersByStatusResponse getDriverOrdersByStatusResponse;
  GetDriverOrdersState({required this.getDriverOrdersByStatusResponse});
}

class SetSelectedOrdersMarkAsPaidState extends MyOrdersState {
  final DriverOrderMarkAsPaidResponse orderDetailsResponse;
  SetSelectedOrdersMarkAsPaidState({required this.orderDetailsResponse});
}

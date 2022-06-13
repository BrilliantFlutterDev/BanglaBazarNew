part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class LoadingState extends NotificationState {}

class ErrorState extends NotificationState {
  final String error;
  ErrorState({required this.error});
}

class InternetErrorState extends NotificationState {
  final String error;
  InternetErrorState({required this.error});
}

class InAppNotificationsState extends NotificationState {
  final InAppNotificationsResponse inAppNotificationsResponse;
  InAppNotificationsState({required this.inAppNotificationsResponse});
}

class UpdateInAppNotificationsState extends NotificationState {
  UpdateInAppNotificationsState();
}

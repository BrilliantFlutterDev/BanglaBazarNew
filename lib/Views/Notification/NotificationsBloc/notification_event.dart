part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class GetInAppNotifications extends NotificationEvent {
  GetInAppNotifications();
}

class UpdateInAppNotifications extends NotificationEvent {
  final String id;
  UpdateInAppNotifications({required this.id});
}

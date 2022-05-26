part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class LoginUser extends NotificationEvent {
  final String username;
  final String password;
  LoginUser({required this.username, required this.password});
}

class GetInAppNotifications extends NotificationEvent {
  GetInAppNotifications();
}

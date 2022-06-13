import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bangla_bazar/ModelClasses/in_app_notification_body_type6.dart';
import 'package:bangla_bazar/ModelClasses/in_app_notifications.dart';
import 'package:bangla_bazar/ModelClasses/in_app_notifications_response.dart';
import 'package:bangla_bazar/ModelClasses/sigin_model.dart';
import 'package:bangla_bazar/ModelClasses/update_notification_response.dart';

import 'package:bangla_bazar/Repository/repository.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/common_functions.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is GetInAppNotifications) {
      yield LoadingState();
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getInAppNotifications();
          //print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            InAppNotificationsResponse inAppNotificationsResponse =
                InAppNotificationsResponse.fromJson(
                    jsonDecode(response.toString()));

            for (int i = 0;
                i < inAppNotificationsResponse.notifications.length;
                i++) {
              inAppNotificationsResponse.notifications[i].Body =
                  inAppNotificationsResponse.notifications[i].Body!
                      .replaceAll("\\", "");
              print(inAppNotificationsResponse.notifications[i].Body);

              ///Change Time Format
              inAppNotificationsResponse.notifications[i].formatedTime =
                  DateFormat('HH:mm aa\ndd-MM-yyyy')
                      .format(inAppNotificationsResponse
                          .notifications[i].LastUpdate)
                      .toString();

              ///Change Time Format
              if (inAppNotificationsResponse.notifications[i].TypeID == 6) {
                InAppNotificationBodyTypeID6 inAppNotificationBody =
                    InAppNotificationBodyTypeID6.fromJson(jsonDecode(
                        inAppNotificationsResponse.notifications[i].Body
                            .toString()));

                inAppNotificationsResponse.notifications[i].message =
                    inAppNotificationBody.body;
                inAppNotificationsResponse.notifications[i].orderNumber =
                    inAppNotificationBody.OrderNumber;
              } else {
                InAppNotificationBody inAppNotificationBody =
                    InAppNotificationBody.fromJson(jsonDecode(
                        inAppNotificationsResponse.notifications[i].Body
                            .toString()));

                inAppNotificationsResponse.notifications[i].message =
                    inAppNotificationBody.body;
              }
            }

            print('||||||||||12');

            if (inAppNotificationsResponse.status == true) {
              yield InAppNotificationsState(
                  inAppNotificationsResponse: inAppNotificationsResponse);
            } else {
              yield ErrorState(error: 'Notification error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid credentials');
        }
      }
    } else if (event is UpdateInAppNotifications) {
      yield LoadingState();
      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response =
              await Repository().updateInAppNotifications(id: event.id);
          //print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            UpdateNotificationResponse updateNotificationResponse =
                UpdateNotificationResponse.fromJson(
                    jsonDecode(response.toString()));

            if (updateNotificationResponse.status == true) {
              yield UpdateInAppNotificationsState();
            } else {
              yield ErrorState(error: 'Notification error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid credentials');
        }
      }
    }
  }
}

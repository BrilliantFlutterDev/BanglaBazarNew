class InAppNotificationsResponse {
  InAppNotificationsResponse({
    required this.status,
    required this.notifications,
  });
  late final bool status;
  late final List<Notifications> notifications;

  InAppNotificationsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    notifications = List.from(json['notifications'])
        .map((e) => Notifications.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['notifications'] = notifications.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Notifications {
  Notifications({
    required this.TypeID,
    required this.TypeName,
    required this.Body,
    required this.UserID,
    required this.UserName,
    required this.EmailAddress,
    required this.ProfilePic,
  });
  late final int TypeID;
  late final String TypeName;
  String? Body;
  late final int UserID;
  late final String UserName;
  late final String EmailAddress;
  late final String ProfilePic;
  late final int NotificationID;
  late final DateTime LastUpdate;
  late String NotificationStatus;
  String? message;
  String? orderNumber;
  String? formatedTime;

  Notifications.fromJson(Map<String, dynamic> json) {
    TypeID = json['TypeID'];
    TypeName = json['TypeName'];
    Body = json['Body'];
    UserID = json['UserID'];
    UserName = json['UserName'];
    EmailAddress = json['EmailAddress'];
    ProfilePic = json['ProfilePic'];
    NotificationID = json['NotificationID'];
    LastUpdate = DateTime.parse(json['LastUpdate']);
    NotificationStatus = json['NotificationStatus'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['TypeID'] = TypeID;
    _data['TypeName'] = TypeName;
    _data['Body'] = Body;
    _data['UserID'] = UserID;
    _data['UserName'] = UserName;
    _data['EmailAddress'] = EmailAddress;
    _data['ProfilePic'] = ProfilePic;
    _data['NotificationID'] = NotificationID;
    _data['LastUpdate'] = LastUpdate.toIso8601String();
    _data['NotificationStatus'] = NotificationStatus;
    return _data;
  }
}

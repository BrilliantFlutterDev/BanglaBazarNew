class LogoutModel {
  LogoutModel({
    required this.SessionID,
  });
  late final String SessionID;

  LogoutModel.fromJson(Map<String, dynamic> json) {
    SessionID = json['SessionID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['SessionID'] = SessionID;
    return _data;
  }
}

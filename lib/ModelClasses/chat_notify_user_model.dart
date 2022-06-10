class ChatNotifyUserModel {
  ChatNotifyUserModel({
    required this.senderID,
    required this.receiverID,
  });
  late final String senderID;
  late final String receiverID;

  ChatNotifyUserModel.fromJson(Map<String, dynamic> json) {
    senderID = json['senderID'];
    receiverID = json['receiverID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['senderID'] = senderID;
    _data['receiverID'] = receiverID;
    return _data;
  }
}

class AuthorizedNetPaymentResponse {
  AuthorizedNetPaymentResponse({
    required this.status,
    required this.message,
    required this.OrderNumber,
    required this.data,
  });
  late final bool status;
  late final String message;
  late final String OrderNumber;
  late final Data data;

  AuthorizedNetPaymentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    OrderNumber = json['OrderNumber'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['OrderNumber'] = OrderNumber;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.responseCode,
    required this.authCode,
    required this.avsResultCode,
    required this.cvvResultCode,
    required this.cavvResultCode,
    required this.transId,
    required this.refTransID,
    required this.transHash,
    required this.testRequest,
    required this.accountNumber,
    required this.accountType,
    required this.messages,
    required this.transHashSha2,
    required this.networkTransId,
  });
  late final String responseCode;
  late final String authCode;
  late final String avsResultCode;
  late final String cvvResultCode;
  late final String cavvResultCode;
  late final String transId;
  late final String refTransID;
  late final String transHash;
  late final String testRequest;
  late final String accountNumber;
  late final String accountType;
  late final Messages messages;
  late final String transHashSha2;
  late final String networkTransId;

  Data.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    authCode = json['authCode'];
    avsResultCode = json['avsResultCode'];
    cvvResultCode = json['cvvResultCode'];
    cavvResultCode = json['cavvResultCode'];
    transId = json['transId'];
    refTransID = json['refTransID'];
    transHash = json['transHash'];
    testRequest = json['testRequest'];
    accountNumber = json['accountNumber'];
    accountType = json['accountType'];
    messages = Messages.fromJson(json['messages']);
    transHashSha2 = json['transHashSha2'];
    networkTransId = json['networkTransId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['responseCode'] = responseCode;
    _data['authCode'] = authCode;
    _data['avsResultCode'] = avsResultCode;
    _data['cvvResultCode'] = cvvResultCode;
    _data['cavvResultCode'] = cavvResultCode;
    _data['transId'] = transId;
    _data['refTransID'] = refTransID;
    _data['transHash'] = transHash;
    _data['testRequest'] = testRequest;
    _data['accountNumber'] = accountNumber;
    _data['accountType'] = accountType;
    _data['messages'] = messages.toJson();
    _data['transHashSha2'] = transHashSha2;
    _data['networkTransId'] = networkTransId;
    return _data;
  }
}

class Messages {
  Messages({
    required this.message,
  });
  late final List<Message> message;

  Messages.fromJson(Map<String, dynamic> json) {
    message =
        List.from(json['message']).map((e) => Message.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Message {
  Message({
    required this.code,
    required this.description,
  });
  late final String code;
  late final String description;

  Message.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['description'] = description;
    return _data;
  }
}

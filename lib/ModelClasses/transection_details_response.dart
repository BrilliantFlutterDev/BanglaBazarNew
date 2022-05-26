class TransectionDetailsResponse {
  TransectionDetailsResponse({
    required this.status,
    required this.transcationDetail,
  });
  late final bool status;
  late final TranscationDetail transcationDetail;

  TransectionDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    transcationDetail = TranscationDetail.fromJson(json['transcationDetail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['transcationDetail'] = transcationDetail.toJson();
    return _data;
  }
}

class TranscationDetail {
  TranscationDetail({
    required this.ProcessPaymentID,
    required this.OrderNumber,
    required this.SessionID,
    required this.UserID,
    required this.GatewayID,
    required this.GetawayConfirmation,
    required this.UserPaymentID,
    required this.Name,
    required this.CardNumber,
    required this.ExpirationDate,
    required this.Address1,
    required this.Address2,
    required this.City,
    required this.State,
    required this.ZipCode,
    required this.CountryID,
    required this.PaymentAccount,
    required this.PaymentRouting,
    required this.OrderDate,
    required this.ItemsPrice,
    required this.ShippingHandling,
    required this.TotalBeforeTax,
    required this.EstimatedTax,
    required this.OrderTotal,
    required this.Currency,
  });
  late final int ProcessPaymentID;
  late final String OrderNumber;
  late final String SessionID;
  late final int UserID;
  late final int GatewayID;
  late final String GetawayConfirmation;
  late final int? UserPaymentID;
  late final String Name;
  late final String CardNumber;
  late final String ExpirationDate;
  late final String Address1;
  late final String Address2;
  late final String City;
  late final String State;
  late final String ZipCode;
  late final int CountryID;
  late final String PaymentAccount;
  late final String PaymentRouting;
  late final String OrderDate;
  late final String ItemsPrice;
  late final String ShippingHandling;
  late final String TotalBeforeTax;
  late final String EstimatedTax;
  late final String OrderTotal;
  late final String Currency;

  TranscationDetail.fromJson(Map<String, dynamic> json) {
    ProcessPaymentID = json['ProcessPaymentID'];
    OrderNumber = json['OrderNumber'];
    SessionID = json['SessionID'];
    UserID = json['UserID'];
    GatewayID = json['GatewayID'];
    GetawayConfirmation = json['GetawayConfirmation'];
    UserPaymentID = json['UserPaymentID'];
    Name = json['Name'];
    CardNumber = json['CardNumber'];
    ExpirationDate = json['ExpirationDate'] ?? '';
    Address1 = json['Address1'];
    Address2 = json['Address2'];
    City = json['City'];
    State = json['State'];
    ZipCode = json['ZipCode'];
    CountryID = json['CountryID'];
    PaymentAccount = json['PaymentAccount'] ?? '';
    PaymentRouting = json['PaymentRouting'] ?? '';
    OrderDate = json['OrderDate'];
    ItemsPrice = json['ItemsPrice'];
    ShippingHandling = json['ShippingHandling'];
    TotalBeforeTax = json['TotalBeforeTax'];
    EstimatedTax = json['EstimatedTax'];
    OrderTotal = json['OrderTotal'];
    Currency = json['Currency'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ProcessPaymentID'] = ProcessPaymentID;
    _data['OrderNumber'] = OrderNumber;
    _data['SessionID'] = SessionID;
    _data['UserID'] = UserID;
    _data['GatewayID'] = GatewayID;
    _data['GetawayConfirmation'] = GetawayConfirmation;
    _data['UserPaymentID'] = UserPaymentID;
    _data['Name'] = Name;
    _data['CardNumber'] = CardNumber;
    _data['ExpirationDate'] = ExpirationDate;
    _data['Address1'] = Address1;
    _data['Address2'] = Address2;
    _data['City'] = City;
    _data['State'] = State;
    _data['ZipCode'] = ZipCode;
    _data['CountryID'] = CountryID;
    _data['PaymentAccount'] = PaymentAccount;
    _data['PaymentRouting'] = PaymentRouting;
    _data['OrderDate'] = OrderDate;
    _data['ItemsPrice'] = ItemsPrice;
    _data['ShippingHandling'] = ShippingHandling;
    _data['TotalBeforeTax'] = TotalBeforeTax;
    _data['EstimatedTax'] = EstimatedTax;
    _data['OrderTotal'] = OrderTotal;
    _data['Currency'] = Currency;
    return _data;
  }
}

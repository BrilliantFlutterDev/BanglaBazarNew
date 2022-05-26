class PaymentHistory {
  PaymentHistory({
    required this.status,
    required this.userPaymentHistory,
  });
  late final bool status;
  late final List<UserPaymentHistory> userPaymentHistory;

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userPaymentHistory = List.from(json['userPaymentHistory'])
        .map((e) => UserPaymentHistory.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['userPaymentHistory'] =
        userPaymentHistory.map((e) => e.toJson()).toList();
    return _data;
  }
}

class UserPaymentHistory {
  UserPaymentHistory({
    required this.PaymentType,
    required this.Country,
    required this.ProcessPaymentID,
    required this.OrderNumber,
    required this.SessionID,
    required this.UserID,
    required this.GatewayID,
    this.GetawayConfirmation,
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
    this.PaymentAccount,
    this.PaymentRouting,
    required this.OrderDate,
    required this.ItemsPrice,
    required this.ShippingHandling,
    required this.TotalBeforeTax,
    required this.EstimatedTax,
    required this.OrderTotal,
    required this.Currency,
    required this.PaymentSuccessResponse,
    this.PaymentFailedResponse,
    this.PaymentCancelledResponse,
    required this.PaymentStatus,
    required this.TransactionID,
  });
  late final String PaymentType;
  late final String Country;
  late final int ProcessPaymentID;
  late final String OrderNumber;
  late final String SessionID;
  late final int UserID;
  late final int GatewayID;
  late final Null GetawayConfirmation;
  late final int UserPaymentID;
  late final String Name;
  late final String CardNumber;
  late final String ExpirationDate;
  late final String Address1;
  late final String Address2;
  late final String City;
  late final String State;
  late final String ZipCode;
  late final int CountryID;
  late final Null PaymentAccount;
  late final Null PaymentRouting;
  late final String OrderDate;
  late final String ItemsPrice;
  late final String ShippingHandling;
  late final String TotalBeforeTax;
  late final String EstimatedTax;
  late final String OrderTotal;
  late final String Currency;
  late final String PaymentSuccessResponse;
  late final Null PaymentFailedResponse;
  late final Null PaymentCancelledResponse;
  late final String PaymentStatus;
  late final String TransactionID;

  UserPaymentHistory.fromJson(Map<String, dynamic> json) {
    PaymentType = json['PaymentType'];
    Country = json['Country'];
    ProcessPaymentID = json['ProcessPaymentID'];
    OrderNumber = json['OrderNumber'];
    SessionID = json['SessionID'];
    UserID = json['UserID'];
    GatewayID = json['GatewayID'];
    GetawayConfirmation = null;
    UserPaymentID = json['UserPaymentID'];
    Name = json['Name'];
    CardNumber = json['CardNumber'];
    ExpirationDate = json['ExpirationDate'];
    Address1 = json['Address1'];
    Address2 = json['Address2'];
    City = json['City'];
    State = json['State'];
    ZipCode = json['ZipCode'];
    CountryID = json['CountryID'];
    PaymentAccount = null;
    PaymentRouting = null;
    OrderDate = json['OrderDate'];
    ItemsPrice = json['ItemsPrice'];
    ShippingHandling = json['ShippingHandling'];
    TotalBeforeTax = json['TotalBeforeTax'];
    EstimatedTax = json['EstimatedTax'];
    OrderTotal = json['OrderTotal'];
    Currency = json['Currency'];
    PaymentSuccessResponse = json['PaymentSuccessResponse'];
    PaymentFailedResponse = null;
    PaymentCancelledResponse = null;
    PaymentStatus = json['PaymentStatus'];
    TransactionID = json['TransactionID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['PaymentType'] = PaymentType;
    _data['Country'] = Country;
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
    _data['PaymentSuccessResponse'] = PaymentSuccessResponse;
    _data['PaymentFailedResponse'] = PaymentFailedResponse;
    _data['PaymentCancelledResponse'] = PaymentCancelledResponse;
    _data['PaymentStatus'] = PaymentStatus;
    _data['TransactionID'] = TransactionID;
    return _data;
  }
}

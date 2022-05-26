class AuthorizedNetPaymentModel {
  AuthorizedNetPaymentModel({
    required this.UserPaymentID,
    required this.SessionID,
    required this.GatewayID,
    required this.GetawayConfirmation,
    required this.CardNumber,
    required this.cvv,
    required this.ExpirationDate,
    required this.totalAmount,
    required this.Name,
    required this.CompanyName,
    required this.Address1,
    required this.Address2,
    required this.City,
    required this.State,
    required this.ZipCode,
    required this.Country,
    required this.CountryID,
    required this.OrderDate,
    required this.productName,
    required this.ItemsPrice,
    required this.ShippingHandling,
    required this.TotalBeforeTax,
    required this.EstimatedTax,
    required this.OrderTotal,
    required this.currency,
    required this.PaymentAccount,
    required this.PaymentRouting,
    required this.DefaultPayment,
    required this.UserAddressID,
    required this.DeliveryName,
    required this.DeliveryPhoneNumber,
    required this.DeliveryAddress1,
    required this.DeliveryAddress2,
    required this.DeliveryState,
    required this.DeliveryCity,
    required this.cusCountry,
    required this.DeliveryZoneID,
    required this.DeliveryAreaID,
    required this.DeliveryZipCode,
    required this.DesireDeliveryDate,
    required this.DeliveryUserNote,
  });
  late final String UserPaymentID;
  late final String SessionID;
  late final String GatewayID;
  late final String GetawayConfirmation;
  late final String CardNumber;
  late final String cvv;
  late final String ExpirationDate;
  late final String totalAmount;
  late final String Name;
  late final String CompanyName;
  late final String Address1;
  late final String Address2;
  late final String City;
  late final String State;
  late final String ZipCode;
  late final String Country;
  late final String CountryID;
  late final String OrderDate;
  late final String productName;
  late final String ItemsPrice;
  late final String ShippingHandling;
  late final String TotalBeforeTax;
  late final String EstimatedTax;
  late final String OrderTotal;
  late final String currency;
  late final String PaymentAccount;
  late final String PaymentRouting;
  late final String DefaultPayment;
  late final int UserAddressID;
  late final String DeliveryName;
  late final String DeliveryPhoneNumber;
  late final String DeliveryAddress1;
  late final String DeliveryAddress2;
  late final String DeliveryState;
  late final String DeliveryCity;
  late final String cusCountry;
  late final String DeliveryZoneID;
  late final String DeliveryAreaID;
  late final String DeliveryZipCode;
  late final String DesireDeliveryDate;
  late final String DeliveryUserNote;

  AuthorizedNetPaymentModel.fromJson(Map<String, dynamic> json) {
    UserPaymentID = json['UserPaymentID'];
    SessionID = json['SessionID'];
    GatewayID = json['GatewayID'];
    GetawayConfirmation = json['GetawayConfirmation'];
    CardNumber = json['CardNumber'];
    cvv = json['cvv'];
    ExpirationDate = json['ExpirationDate'];
    totalAmount = json['total_amount'];
    Name = json['Name'];
    CompanyName = json['CompanyName'];
    Address1 = json['Address1'];
    Address2 = json['Address2'];
    City = json['City'];
    State = json['State'];
    ZipCode = json['ZipCode'];
    Country = json['Country'];
    CountryID = json['CountryID'];
    OrderDate = json['OrderDate'];
    productName = json['product_name'];
    ItemsPrice = json['ItemsPrice'];
    ShippingHandling = json['ShippingHandling'];
    TotalBeforeTax = json['TotalBeforeTax'];
    EstimatedTax = json['EstimatedTax'];
    OrderTotal = json['OrderTotal'];
    currency = json['currency'];
    PaymentAccount = json['PaymentAccount'];
    PaymentRouting = json['PaymentRouting'];
    DefaultPayment = json['DefaultPayment'];
    UserAddressID = json['UserAddressID'];
    DeliveryName = json['DeliveryName'];
    DeliveryPhoneNumber = json['DeliveryPhoneNumber'];
    DeliveryAddress1 = json['DeliveryAddress1'];
    DeliveryAddress2 = json['DeliveryAddress2'];
    DeliveryState = json['DeliveryState'];
    DeliveryCity = json['DeliveryCity'];
    cusCountry = json['cus_country'];
    DeliveryZoneID = json['DeliveryZoneID'];
    DeliveryAreaID = json['DeliveryAreaID'];
    DeliveryZipCode = json['DeliveryZipCode'];
    DesireDeliveryDate = json['DesireDeliveryDate'];
    DeliveryUserNote = json['DeliveryUserNote'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['UserPaymentID'] = UserPaymentID;
    _data['SessionID'] = SessionID;
    _data['GatewayID'] = GatewayID;
    _data['GetawayConfirmation'] = GetawayConfirmation;
    _data['CardNumber'] = CardNumber;
    _data['cvv'] = cvv;
    _data['ExpirationDate'] = ExpirationDate;
    _data['total_amount'] = totalAmount;
    _data['Name'] = Name;
    _data['CompanyName'] = CompanyName;
    _data['Address1'] = Address1;
    _data['Address2'] = Address2;
    _data['City'] = City;
    _data['State'] = State;
    _data['ZipCode'] = ZipCode;
    _data['Country'] = Country;
    _data['CountryID'] = CountryID;
    _data['OrderDate'] = OrderDate;
    _data['product_name'] = productName;
    _data['ItemsPrice'] = ItemsPrice;
    _data['ShippingHandling'] = ShippingHandling;
    _data['TotalBeforeTax'] = TotalBeforeTax;
    _data['EstimatedTax'] = EstimatedTax;
    _data['OrderTotal'] = OrderTotal;
    _data['currency'] = currency;
    _data['PaymentAccount'] = PaymentAccount;
    _data['PaymentRouting'] = PaymentRouting;
    _data['DefaultPayment'] = DefaultPayment;
    _data['UserAddressID'] = UserAddressID;
    _data['DeliveryName'] = DeliveryName;
    _data['DeliveryPhoneNumber'] = DeliveryPhoneNumber;
    _data['DeliveryAddress1'] = DeliveryAddress1;
    _data['DeliveryAddress2'] = DeliveryAddress2;
    _data['DeliveryState'] = DeliveryState;
    _data['DeliveryCity'] = DeliveryCity;
    _data['cus_country'] = cusCountry;
    _data['DeliveryZoneID'] = DeliveryZoneID;
    _data['DeliveryAreaID'] = DeliveryAreaID;
    _data['DeliveryZipCode'] = DeliveryZipCode;
    _data['DesireDeliveryDate'] = DesireDeliveryDate;
    _data['DeliveryUserNote'] = DeliveryUserNote;
    return _data;
  }
}

class AppGlobal {
  static String rememberMe = 'false';
  static String rememberMeEmail = '';
  static String rememberMePassword = '';

  ///Office IP
  static String baseURL = 'http://192.168.100.25:3001/api/';
  static String photosBaseURL = 'http://192.168.100.25:3001/';

  ///Flat Ip
  // static String baseURL = 'http://192.168.100.9:3001/api/';
  // static String photosBaseURL = 'http://192.168.100.9:3001/';

  ///Live IP
  // static String baseURL = 'https://api.banglabazar.com/api/';
  // static String photosBaseURL = 'https://api.banglabazar.com/';

  static int userID = 0;
  static String userName = '';
  static String birthDay = '';
  static String userPhone = '';
  static String userEmail = '';
  static String gender = '';
  static String profilePic = '';
  static String userAddress = '';
  static String secretQuestion = '';
  static String answer = '';
  static String emailAddress = '';
  static String phoneNumber = '';
  static String password = '';
  static String accessCodeEmail = '';
  static String accessCodePhone = '';
  static String emailVerified = '';
  static String phoneVerified = '';
  static String customer = '';
  static String deliveryPerson = '';
  static String admin = '';
  static String superAdmin = '';
  static String createdDate = '';
  static String iPAddress = '';
  static String active = '';
  static String region = 'Bangladesh';
  static String lastUpdate = '';
  static String adminNote = '';
  static String token = '';
  static String ipAddress = '';
  static String currentCountry = '';
  static String deviceToken = '';
  static String notificationId = '';

  ///For email and phone verification
  static bool phoneChangeVerify = true;
  static bool emailChangeVerified = true;

  /// User Card Info
  static String nameOnCard = '';
  static String cardNumber = '';
  static String expiryDate = '';
  static int cardUserID = 0;

  /// User Address Info
  static String address1 = '';
  static String address2 = '';
  static String zipCode = '';
  static String userAddressCity = '';
  static String userAddressState = '';
  static int countryId = -1;
  static String defaultPayment = 'N';

  static bool switchToDriverAccount = false;

  ///Drivers data variables

  static int deliveryDriverID = -1;
  static String governmentIDDriver = "";
  static String governmentIDPicDriver = '';
  static String address1Driver = "";
  static String address2Driver = '';
  static int cityIDDriver = -1;
  static String cityDiver = '';
  static String stateDriver = '';
  static String zipCodeDriver = '';
  static int countryIDDriver = -1;
  static String paymentAccountDriver = '';
  static String paymentRoutingDriver = '';
  static String businessEmailDriver = '';
  static String businessPhoneDriver = '';
  static String businessURLDriver = '';
  static String reviewedByAdminDriver = '';
  static int gatewayIDDriver = 0;
}

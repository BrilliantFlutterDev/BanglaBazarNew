import 'dart:collection';
import 'dart:io';

import 'package:bangla_bazar/ModelClasses/AddNewBusinessPage2Model.dart';
import 'package:bangla_bazar/ModelClasses/AddNewBussinessPage1Model.dart';
import 'package:bangla_bazar/ModelClasses/add_driver_model.dart';
import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/ModelClasses/check_delivery_driver_model.dart';
import 'package:bangla_bazar/ModelClasses/logout_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_area_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_price_calculation_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_token_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_zone_model.dart';
import 'package:bangla_bazar/ModelClasses/usps_address_verify_model.dart';
import 'package:bangla_bazar/ModelClasses/usps_rate_calculation_model.dart';
import 'package:bangla_bazar/Providers/base_provider.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/web_services.dart';
import 'package:image_picker/image_picker.dart';

class LoginProvider extends BaseProvider {
  static Future login(
      {required String username,
      required String password,
      required String rememberMe}) async {
    try {
      String url = '${AppGlobal.baseURL}user/login';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('EmailAddress', () => username.toString());

      params.putIfAbsent('Password', () => password.toString());
      params.putIfAbsent('deviceID', () => AppGlobal.deviceToken);
      params.putIfAbsent('hashPassword', () => password.toString());
      params.putIfAbsent('signIn', () => rememberMe);

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future signup({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}user/register';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('UserName', () => username.toString());
      params.putIfAbsent('Password', () => password.toString());
      params.putIfAbsent('EmailAddress', () => email.toString());
      params.putIfAbsent('IPAddress', () => AppGlobal.ipAddress);

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future updateUser({
    required String username,
    required String email,
    required String birthday,
    required String gender,
    required String phoneNumber,
    required String emailVerified,
    required String phoneVerified,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}user/update/${AppGlobal.userID}';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('UserName', () => username.toString());
      params.putIfAbsent('Birthday', () => birthday.toString());
      params.putIfAbsent('EmailAddress', () => email.toString());
      params.putIfAbsent('Gender', () => gender.toString());
      params.putIfAbsent('PhoneNumber', () => phoneNumber.toString());
      params.putIfAbsent('EmailVerified', () => emailVerified.toString());
      params.putIfAbsent('PhoneVerified', () => phoneVerified.toString());

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPut(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future newPassword({
    required String email,
    required String password,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}user/update-password';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('password', () => password.toString());
      params.putIfAbsent('email_address', () => email.toString());

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future signupVerifyOTP({
    required String otp,
    required String email,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}user/verify';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('otp', () => otp.toString());

      params.putIfAbsent('email', () => email.toString());

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future forgetPasswordVerifyOTP({
    required String otp,
    required String email,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}user/verify-otp';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('OTP', () => otp.toString());

      params.putIfAbsent('email_address', () => email.toString());

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future resendVerifyOTP({
    required String email,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}user/resend';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('email', () => email.toString());

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future forgetPasswordSendOTP({
    required String email,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}user/forgot';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('email_address', () => email.toString());

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future submitBusinessRegistrationPage1Data({
    required AddBusinessPage1Data addBusinessPage1Data,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}store-management/vendor';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('CompanyName', () => addBusinessPage1Data.name);
      params.putIfAbsent('Address1', () => addBusinessPage1Data.address1);
      params.putIfAbsent('Address2', () => addBusinessPage1Data.address2);
      params.putIfAbsent('CityID', () => addBusinessPage1Data.cityID);
      params.putIfAbsent('State', () => addBusinessPage1Data.state);
      params.putIfAbsent('ZipCode', () => addBusinessPage1Data.zipCode);
      params.putIfAbsent('GoogleMapID', () => 1);
      params.putIfAbsent('CountryID', () => addBusinessPage1Data.countryID);
      params.putIfAbsent(
          'PaymentAccount', () => addBusinessPage1Data.paymentAc);
      params.putIfAbsent(
          'PaymentRouting', () => addBusinessPage1Data.paymentRout);
      params.putIfAbsent(
          'BusinessEmail', () => addBusinessPage1Data.businessEmail);
      params.putIfAbsent(
          'BusinessPhone',
          () =>
              addBusinessPage1Data.phoneCode +
              addBusinessPage1Data.phoneNumber);
      params.putIfAbsent('BusinessURL', () => addBusinessPage1Data.businessURL);
      params.putIfAbsent('PageURL', () => 'banglabazar.com');
      params.putIfAbsent('ReviewedByAdmin', () => 'N');
      params.putIfAbsent(
          'AllowDelivery', () => addBusinessPage1Data.allowDelivery);
      params.putIfAbsent('GatewayID', () => addBusinessPage1Data.gatewayID);
      params.putIfAbsent(
          'AllowStorePickup', () => addBusinessPage1Data.allowStorePickup);
      params.putIfAbsent(
          'ProductApproval', () => addBusinessPage1Data.productApproval);
      params.putIfAbsent('AdminNote', () => addBusinessPage1Data.adminNote);
      params.putIfAbsent('VendorID', () => AppGlobal.userID);
      params.putIfAbsent('TaxID', () => addBusinessPage1Data.textID);
      params.putIfAbsent('City', () => addBusinessPage1Data.city);
      params.putIfAbsent('GovernmentID', () => addBusinessPage1Data.gatewayID);

      print('|||||||||Service class is going to hit api');

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response =
          await WebServices.apiPostBusiness(url, params, addBusinessPage1Data);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future registerDriver({
    required AddDriverModel addDriverModel,
  }) async {
    try {
      String url;
      if (addDriverModel.registerAc == true) {
        url = '${AppGlobal.baseURL}deliveryDriver/register-driver';
      } else {
        url = '${AppGlobal.baseURL}deliveryDriver/update-driverDetails';
      }
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('Address1', () => addDriverModel.address1);
      params.putIfAbsent('Address2', () => addDriverModel.address2);
      params.putIfAbsent('CityID', () => addDriverModel.cityID);
      params.putIfAbsent('State', () => addDriverModel.state);
      params.putIfAbsent('ZipCode', () => addDriverModel.zipCode);

      params.putIfAbsent('CountryID', () => addDriverModel.countryID);
      params.putIfAbsent('PaymentAccount', () => addDriverModel.paymentAc);
      params.putIfAbsent('PaymentRouting', () => addDriverModel.paymentRout);
      params.putIfAbsent('BusinessEmail', () => addDriverModel.businessEmail);
      params.putIfAbsent('BusinessPhone',
          () => addDriverModel.phoneCode + addDriverModel.phoneNumber);
      params.putIfAbsent('BusinessURL', () => 'banglabazardriver@gmail.com');

      params.putIfAbsent('GatewayID', () => addDriverModel.gatewayID);

      params.putIfAbsent('City', () => addDriverModel.city);
      params.putIfAbsent('GovernmentID', () => addDriverModel.gatewayID);

      print('|||||||||Service class is going to hit api');

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPostDriverTokenBarer(
          url, params, addDriverModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future submitBusinessRegistrationPage2Data({
    required AddBusinessPage2Data addBusinessPage2Data,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}store-management/vendor-store';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('VendorID', () => AppGlobal.userID);
      params.putIfAbsent('StoreName', () => addBusinessPage2Data.storeName);
      params.putIfAbsent('Address1', () => addBusinessPage2Data.storeAddress1);
      params.putIfAbsent('Address2', () => addBusinessPage2Data.storeAddress2);
      params.putIfAbsent('CityID', () => addBusinessPage2Data.dbPathaoCityId);
      params.putIfAbsent('City', () => addBusinessPage2Data.storeCity);
      params.putIfAbsent('State', () => addBusinessPage2Data.storeState);
      params.putIfAbsent('ZipCode', () => addBusinessPage2Data.storeZipCode);
      params.putIfAbsent('CountryID',
          () => addBusinessPage2Data.storeCountry == 'Bangladesh' ? 16 : 226);
      params.putIfAbsent('StoreEmail', () => addBusinessPage2Data.storeEmail);
      params.putIfAbsent(
          'StorePhone', () => addBusinessPage2Data.storephoneNumber);
      params.putIfAbsent('StoreFAX', () => addBusinessPage2Data.storeFax);
      params.putIfAbsent('StoreURL', () => addBusinessPage2Data.storeURL);
      params.putIfAbsent('GoogleMapID', () => 1);
      params.putIfAbsent('ExceptDropOff', () => 'N');
      params.putIfAbsent('Active', () => addBusinessPage2Data.active);
      params.putIfAbsent(
          'AdminNote', () => addBusinessPage2Data.storeAdminNote);
      params.putIfAbsent('EmailVerified', () => 'Y');
      params.putIfAbsent('PhoneVerified', () => 'Y');
      params.putIfAbsent('city_id', () => addBusinessPage2Data.pathaoCityId);
      params.putIfAbsent('zone_id', () => addBusinessPage2Data.pathaoZoneId);
      params.putIfAbsent('area_id', () => addBusinessPage2Data.pathaoAreaId);
      params.putIfAbsent(
          'pathaoToken', () => addBusinessPage2Data.pathaoAccessToken);

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future checkEmailAvailability({
    required String email,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}user/update-email';
      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('EmailAddress', () => email.toString());

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiPut(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getDeliveryDriversDetails() async {
    try {
      String url =
          '${AppGlobal.baseURL}deliveryDriver/get-driverDetails/${AppGlobal.deliveryDriverID}';

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiGet(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getPaymentHistory() async {
    try {
      String url = '${AppGlobal.baseURL}payment/payment-history';

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiGetAuthenticationBearerToken(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getVendorAllowedCountries() async {
    try {
      String url = '${AppGlobal.baseURL}location/get-vendorAllowedCountries';

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiGet(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getUserCardDetails() async {
    try {
      String url = '${AppGlobal.baseURL}user/user-cardDetails';

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiGet(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getPathaoAccessToken() async {
    try {
      String url = '${AppGlobal.baseURL}pathao/get-access-token';

      // params.putIfAbsent('device_token', () => AppGlobal.deviceToken);

      dynamic response = await WebServices.apiGet(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getVendorAllowedStates({
    required int id,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}location/get-vendorAllowedStates';

      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('CountryID', () => id);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getUserBusiness({
    required int id,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}store-management/buisness-details/$id';

      dynamic response = await WebServices.apiGet(url);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getVendorAllowedCities({
    required int id,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}location/get-vendorAllowedCities';

      Map params = HashMap<String, dynamic>();

      params.putIfAbsent('CountryID', () => id);

      dynamic response = await WebServices.apiPost(url, params);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getPathaoCities({
    required PathaoTokenModel pathaoTokenModel,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}pathao/get-pathao-cities';

      dynamic response = await WebServices.apiPostToJson(url, pathaoTokenModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getPathaoZones({
    required PathaoZoneModel pathaoZoneModel,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}pathao/get-pathao-zone';

      dynamic response = await WebServices.apiPostToJson(url, pathaoZoneModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getPathaoAreas({
    required PathaoAreaModel pathaoAreaModel,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}pathao/get-pathao-area';

      dynamic response = await WebServices.apiPostToJson(url, pathaoAreaModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future logout({
    required LogoutModel logoutModel,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}user/logout';

      dynamic response = await WebServices.apiPostToJson(url, logoutModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future pathaoPriceCalculation({
    required PathaoPriceCalculationModel pathaoPriceCalculationModel,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}pathao/price-plan';

      dynamic response = await WebServices.apiPostToJsonWithoutBearerToken(
          url, pathaoPriceCalculationModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future checkInventory({
    required CartDetailsResponse cartDetailsResponseTemp,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}wish-list/get-inventory';

      dynamic response =
          await WebServices.apiPost(url, cartDetailsResponseTemp);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getInventory({
    required CartDetailsResponse cartDetailsResponseTemp,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}wish-list/get-inventory';

      dynamic response =
          await WebServices.apiPost(url, cartDetailsResponseTemp);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future checkDriverAvailability({
    required CheckDeliveryDriverModel checkDeliveryDriverModel,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}deliveryDriver/check-availability';

      dynamic response =
          await WebServices.apiPostToJson(url, checkDeliveryDriverModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future verifyUspsAddress({
    required UspsAddressVerifyModel uspsAddressVerifyModel,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}usps/Verify';

      dynamic response =
          await WebServices.apiPostToJson(url, uspsAddressVerifyModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future uspsCalculateRate({
    required UspsRateCalculationModel uspsRateCalculationModel,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}usps/rate';

      dynamic response =
          await WebServices.apiPostToJson(url, uspsRateCalculationModel);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<dynamic> imageUpload({
    required String userId,
    required var selectedImage,
  }) async {
    try {
      String url = '${AppGlobal.baseURL}user/uploadForm';
      Map params = HashMap<String, dynamic>();
      params.putIfAbsent('UserID', () => userId);
      dynamic response = await WebServices.updateProfilePic(
        url,
        params,
        selectedImage,
      );
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

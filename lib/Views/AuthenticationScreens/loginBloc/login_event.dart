part of 'login_bloc.dart';

abstract class LoginEvent {}

class RefreshEvent extends LoginEvent {
  RefreshEvent();
}

class LoginUser extends LoginEvent {
  final String username;
  final String password;
  String? rememberMe = 'n';
  LoginUser({required this.username, required this.password, this.rememberMe});
}

class SignUpUser extends LoginEvent {
  final String username;
  final String email;
  final String password;
  SignUpUser(
      {required this.username, required this.email, required this.password});
}

class UploadProfilePic extends LoginEvent {
  final String userid;
  var selectedImage;

  UploadProfilePic({
    required this.userid,
    required this.selectedImage,
  });
}

class UpdateUser extends LoginEvent {
  final String username;
  final String email;
  final String birthday;
  final String gender;
  final String phoneNumber;
  final String emailVerified;
  final String phoneVerified;
  UpdateUser({
    required this.username,
    required this.email,
    required this.birthday,
    required this.gender,
    required this.phoneNumber,
    required this.emailVerified,
    required this.phoneVerified,
  });
}

class NewPassword extends LoginEvent {
  final String email;
  final String password;
  NewPassword({required this.email, required this.password});
}

class VerifyOTPSignUpUser extends LoginEvent {
  final String otp;
  final String email;

  VerifyOTPSignUpUser({required this.otp, required this.email});
}

class VerifyOTPForgetPassword extends LoginEvent {
  final String otp;
  final String email;

  VerifyOTPForgetPassword({required this.otp, required this.email});
}

class VerifyChangeEmailEditProfile extends LoginEvent {
  final String otp;
  final String email;

  VerifyChangeEmailEditProfile({required this.otp, required this.email});
}

class ResendOTPSignUpUser extends LoginEvent {
  final String email;

  ResendOTPSignUpUser({required this.email});
}

class ForgetPasswordSendOTP extends LoginEvent {
  final String email;

  ForgetPasswordSendOTP({required this.email});
}

class SubmitBusinessRegistrationPage1Data extends LoginEvent {
  final AddBusinessPage1Data addBusinessPage1Data;

  SubmitBusinessRegistrationPage1Data({required this.addBusinessPage1Data});
}

class RegisterDriver extends LoginEvent {
  final AddDriverModel addDriverModel;

  RegisterDriver({required this.addDriverModel});
}

class SubmitBusinessRegistrationPage2Data extends LoginEvent {
  final AddBusinessPage2Data addBusinessPage2Data;

  SubmitBusinessRegistrationPage2Data({required this.addBusinessPage2Data});
}

class CheckEmailAvailability extends LoginEvent {
  final String email;

  CheckEmailAvailability({required this.email});
}

class SendEmailOTP extends LoginEvent {
  final String email;
  SendEmailOTP({required this.email});
}

class GetDeliveryDriversDetails extends LoginEvent {
  GetDeliveryDriversDetails();
}

class GetVendorAllowedCountries extends LoginEvent {
  GetVendorAllowedCountries();
}

class GetVendorAllowedStates extends LoginEvent {
  final int id;
  GetVendorAllowedStates({required this.id});
}

class CheckUserBusiness extends LoginEvent {
  final int id;
  CheckUserBusiness({required this.id});
}

class GetVendorAllowedCities extends LoginEvent {
  final int id;
  GetVendorAllowedCities({required this.id});
}

class GetPathaoAccessToken extends LoginEvent {
  GetPathaoAccessToken();
}

class GetPathaoCities extends LoginEvent {
  final PathaoTokenModel pathaoTokenModel;
  GetPathaoCities({required this.pathaoTokenModel});
}

class GetPathaoZones extends LoginEvent {
  final PathaoZoneModel pathaoZoneModel;
  GetPathaoZones({required this.pathaoZoneModel});
}

class GetPathaoAreas extends LoginEvent {
  final PathaoAreaModel pathaoAreaModel;
  GetPathaoAreas({required this.pathaoAreaModel});
}

class Logout extends LoginEvent {
  final LogoutModel logoutModel;
  Logout({required this.logoutModel});
}

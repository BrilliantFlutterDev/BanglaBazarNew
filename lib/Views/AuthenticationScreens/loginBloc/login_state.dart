part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class SignUpSuccess extends LoginState {}

class SignUpVerifyOTP extends LoginState {}

class ChangeEmailVerified extends LoginState {}

class ForgetPasswordOTPSendSuccess extends LoginState {}

class RegisterBusinessStep1Submitted extends LoginState {}

class RegisterBusinessStep2Submitted extends LoginState {}

class EmailCheckedSuccess extends LoginState {}

class GetDeliveryDriversDetailsState extends LoginState {}

class VendorAllowedCountries extends LoginState {
  final AllowedCountriesResponse allowedCountriesResponse;
  VendorAllowedCountries({required this.allowedCountriesResponse});
}

class SendEmailOTPState extends LoginState {
  final SendOTPResponse sendOTPResponse;
  SendEmailOTPState({required this.sendOTPResponse});
}

class VerifyEmailState extends LoginState {
  final SendOTPResponse sendOTPResponse;
  VerifyEmailState({required this.sendOTPResponse});
}

class AddDriverState extends LoginState {
  final AddDriverResponse addDriverResponse;
  AddDriverState({required this.addDriverResponse});
}

class VendorAllowedStates extends LoginState {
  final AllowedVendorStatesResponse allowedVendorStatesResponse;
  VendorAllowedStates({required this.allowedVendorStatesResponse});
}

class VendorAllowedCities extends LoginState {
  final AllowedVendorCityResponse allowedVendorCityResponse;
  VendorAllowedCities({required this.allowedVendorCityResponse});
}

class ProfileUpdatedSuccessfully extends LoginState {}

class LoadingState extends LoginState {}

class BusinessNotExist extends LoginState {}

class ErrorState extends LoginState {
  final String error;
  ErrorState({required this.error});
}

class InternetErrorState extends LoginState {
  final String error;
  InternetErrorState({required this.error});
}

class PathaoGetAccessTokenState extends LoginState {
  final PathaoAccessTokenResponse pathaoAccessTokenResponse;
  PathaoGetAccessTokenState({required this.pathaoAccessTokenResponse});
}

class PathaoCitiesState extends LoginState {
  final PathaoCitiesResponse pathaoCitiesResponse;
  PathaoCitiesState({required this.pathaoCitiesResponse});
}

class PathaoZonesState extends LoginState {
  final PathaoZonesResponse pathaoZonesResponse;
  PathaoZonesState({required this.pathaoZonesResponse});
}

class PathaoAreasState extends LoginState {
  final PathaoAreaResponse pathaoAreaResponse;
  PathaoAreasState({required this.pathaoAreaResponse});
}

class LogoutState extends LoginState {
  final OrderStatusChangeResponse orderStatusChangeResponse;
  LogoutState({required this.orderStatusChangeResponse});
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bangla_bazar/ModelClasses/AddNewBusinessPage2Model.dart';
import 'package:bangla_bazar/ModelClasses/AddNewBussinessPage1Model.dart';
import 'package:bangla_bazar/ModelClasses/add_driver_model.dart';
import 'package:bangla_bazar/ModelClasses/add_driver_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_countries_list_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_city_response.dart';
import 'package:bangla_bazar/ModelClasses/allowed_vendor_states_response.dart';
import 'package:bangla_bazar/ModelClasses/check_already_have_business_response.dart';
import 'package:bangla_bazar/ModelClasses/delivery_driver_details_response.dart';
import 'package:bangla_bazar/ModelClasses/logout_model.dart';
import 'package:bangla_bazar/ModelClasses/order_status_change_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_access_token_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_area_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_area_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_cities_response.dart';
import 'package:bangla_bazar/ModelClasses/pathao_token_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_zone_model.dart';
import 'package:bangla_bazar/ModelClasses/pathao_zones_response.dart';
import 'package:bangla_bazar/ModelClasses/profile_image_response.dart';
import 'package:bangla_bazar/ModelClasses/register_business_step1.dart';
import 'package:bangla_bazar/ModelClasses/register_store_step2.dart';
import 'package:bangla_bazar/ModelClasses/sigin_model.dart';
import 'package:bangla_bazar/ModelClasses/signup_model.dart';
import 'package:bangla_bazar/Repository/repository.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/common_functions.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUser) {
      yield LoadingState();
      if (event.username.isEmpty) {
        yield ErrorState(error: '');
      } else if (event.password.isEmpty) {
        yield ErrorState(error: '');
      } else {
        var isInternetConnected = await checkInternetConnectivity();
        if (isInternetConnected == false) {
          yield InternetErrorState(error: 'Internet not connected');
        } else {
          try {
            dynamic response = await Repository().login(
                username: event.username,
                password: event.password,
                rememberMe: event.rememberMe == 'Y' ? 'Y' : 'N');
            //print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              SigninResponse loginResponse =
                  SigninResponse.fromJson(jsonDecode(response.toString()));

              if (loginResponse.status == true) {
                FlutterSecureStorage storage = const FlutterSecureStorage();

                AppGlobal.userID = loginResponse.user.UserID;
                if (loginResponse.user.UserName != '') {
                  AppGlobal.userName = loginResponse.user.UserName.capitalize();
                } else {
                  AppGlobal.userName = loginResponse.user.UserName;
                }

                AppGlobal.birthDay = loginResponse.user.BirthDay!;
                AppGlobal.userPhone = loginResponse.user.PhoneNumber;

                AppGlobal.userEmail = loginResponse.user.EmailAddress;
                if (loginResponse.user.Gender != '') {
                  AppGlobal.gender = loginResponse.user.Gender.capitalize();
                } else {
                  AppGlobal.gender = loginResponse.user.Gender;
                }

                AppGlobal.profilePic = loginResponse.user.ProfilePic;

                AppGlobal.secretQuestion = loginResponse.user.SecretQuestion!;
                AppGlobal.answer = loginResponse.user.Answer!;
                AppGlobal.emailAddress = loginResponse.user.EmailAddress;
                AppGlobal.phoneNumber = loginResponse.user.PhoneNumber;
                AppGlobal.password = loginResponse.user.Password;
                AppGlobal.accessCodeEmail = loginResponse.user.AccessCodeEmail;
                AppGlobal.accessCodePhone = loginResponse.user.AccessCodePhone!;
                AppGlobal.emailVerified = loginResponse.user.EmailVerified;
                AppGlobal.phoneVerified = loginResponse.user.PhoneVerified!;
                AppGlobal.customer = loginResponse.user.Customer;
                AppGlobal.deliveryPerson = loginResponse.user.DeliveryPerson!;
                AppGlobal.admin = loginResponse.user.Admin!;
                AppGlobal.superAdmin = loginResponse.user.SuperAdmin!;
                AppGlobal.createdDate = loginResponse.user.CreatedDate!;
                AppGlobal.iPAddress = loginResponse.user.IPAddress;
                AppGlobal.active = loginResponse.user.Active;
                AppGlobal.lastUpdate = loginResponse.user.LastUpdate!;
                AppGlobal.adminNote = loginResponse.user.AdminNote!;
                AppGlobal.token = loginResponse.token;

                if (loginResponse.userCardDetails != null) {
                  ///Save card info
                  AppGlobal.nameOnCard =
                      loginResponse.userCardDetails!.Name.capitalize();
                  AppGlobal.cardNumber =
                      loginResponse.userCardDetails!.CardNumber;
                  AppGlobal.expiryDate =
                      loginResponse.userCardDetails!.ExpirationDate;
                  AppGlobal.cardUserID = loginResponse.userCardDetails!.UserID;

                  /// Save user address info
                  AppGlobal.address1 =
                      loginResponse.userCardDetails!.Address1.capitalize();
                  AppGlobal.address2 =
                      loginResponse.userCardDetails!.Address2.capitalize();
                  AppGlobal.userAddressCity =
                      loginResponse.userCardDetails!.City;
                  AppGlobal.userAddressState =
                      loginResponse.userCardDetails!.State;
                  AppGlobal.countryId =
                      loginResponse.userCardDetails!.CountryID;
                  AppGlobal.defaultPayment =
                      loginResponse.userCardDetails!.DefaultPayment;
                  AppGlobal.zipCode = loginResponse.userCardDetails!.ZipCode;
                }

                if (loginResponse.deliveryDriverDetails != null) {
                  AppGlobal.deliveryDriverID =
                      loginResponse.deliveryDriverDetails!.DeliveryDriverID;
                  AppGlobal.governmentIDDriver =
                      loginResponse.deliveryDriverDetails!.GovernmentID;
                  // AppGlobal.governmentIDPicDriver =
                  //     loginResponse.deliveryDriverDetails!.GovernmentIDPic!;
                  AppGlobal.address1Driver = loginResponse
                      .deliveryDriverDetails!.Address1
                      .capitalize();
                  AppGlobal.address2Driver = loginResponse
                      .deliveryDriverDetails!.Address2
                      .capitalize();
                  AppGlobal.cityIDDriver =
                      loginResponse.deliveryDriverDetails!.CityID;
                  AppGlobal.cityDiver =
                      loginResponse.deliveryDriverDetails!.City;
                  AppGlobal.stateDriver =
                      loginResponse.deliveryDriverDetails!.State;
                  AppGlobal.zipCodeDriver =
                      loginResponse.deliveryDriverDetails!.ZipCode;
                  AppGlobal.countryIDDriver =
                      loginResponse.deliveryDriverDetails!.CountryID;
                  AppGlobal.paymentAccountDriver =
                      loginResponse.deliveryDriverDetails!.PaymentAccount;
                  AppGlobal.paymentRoutingDriver =
                      loginResponse.deliveryDriverDetails!.PaymentRouting;
                  AppGlobal.businessEmailDriver =
                      loginResponse.deliveryDriverDetails!.BusinessEmail;
                  AppGlobal.businessPhoneDriver =
                      loginResponse.deliveryDriverDetails!.BusinessPhone;

                  AppGlobal.gatewayIDDriver =
                      loginResponse.deliveryDriverDetails!.GatewayID!;
                }

                await storage.write(
                    key: 'emailAddress',
                    value: loginResponse.user.EmailAddress);
                await storage.write(
                    key: 'pass', value: loginResponse.user.Password);
                await storage.write(
                    key: 'rememberMe', value: AppGlobal.rememberMe);

                yield LoginSuccess();
              } else {
                yield ErrorState(error: loginResponse.message);
              }
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'Invalid credentials');
          }
        }
      }
    } else if (event is SignUpUser) {
      yield LoadingState();
      if (event.username.isEmpty) {
        yield ErrorState(error: '');
      } else if (event.password.isEmpty) {
        yield ErrorState(error: '');
      } else {
        var isInternetConnected = await checkInternetConnectivity();
        if (isInternetConnected == false) {
          yield InternetErrorState(error: 'Internet not connected');
        } else {
          try {
            dynamic response = await Repository().signup(
              username: event.username,
              password: event.password,
              email: event.email,
            );
            print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              SignUpResponse signUpResponse =
                  SignUpResponse.fromJson(jsonDecode(response.toString()));

              if (signUpResponse.status == true) {
                yield SignUpSuccess();
              } else {
                yield ErrorState(error: signUpResponse.message);
              }
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'Error');
          }
        }
      }
    } else if (event is UploadProfilePic) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield ErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().imageUpload(
            userId: event.userid,
            selectedImage: event.selectedImage,
          );
          if (response != null) {
            ProfileImageResponse registerResponse =
                ProfileImageResponse.fromJson(response.data);

            if (registerResponse.status == true) {
              AppGlobal.profilePic = registerResponse.path.toString();
              yield ProfileUpdatedSuccessfully();
            } else {
              yield ErrorState(error: registerResponse.message);
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          print(e.toString());
        }
      }
    } else if (event is UpdateUser) {
      yield LoadingState();
      if (event.username.isEmpty) {
        yield ErrorState(error: '');
      } else {
        var isInternetConnected = await checkInternetConnectivity();
        if (isInternetConnected == false) {
          yield InternetErrorState(error: 'Internet not connected');
        } else {
          try {
            dynamic response = await Repository().updateUser(
              username: event.username,
              birthday: event.birthday,
              email: event.email,
              gender: event.gender,
              phoneVerified: event.phoneVerified,
              phoneNumber: event.phoneNumber,
              emailVerified: event.emailVerified,
            );
            print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              SignUpResponse signUpResponse =
                  SignUpResponse.fromJson(jsonDecode(response.toString()));

              if (signUpResponse.status == true) {
                AppGlobal.userName = event.username;
                AppGlobal.emailAddress = event.email;
                AppGlobal.birthDay = event.birthday;
                AppGlobal.gender = event.gender;
                AppGlobal.phoneVerified = event.phoneVerified;
                AppGlobal.phoneNumber = event.phoneNumber;
                AppGlobal.emailVerified = event.emailVerified;
                yield SignUpSuccess();
              } else {
                yield ErrorState(error: signUpResponse.message);
              }
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'Error');
          }
        }
      }
    } else if (event is NewPassword) {
      yield LoadingState();
      if (event.password.isEmpty) {
        yield ErrorState(error: '');
      } else {
        var isInternetConnected = await checkInternetConnectivity();
        if (isInternetConnected == false) {
          yield InternetErrorState(error: 'Internet not connected');
        } else {
          try {
            dynamic response = await Repository().newPassword(
              password: event.password,
              email: event.email,
            );
            print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              SignUpResponse signUpResponse =
                  SignUpResponse.fromJson(jsonDecode(response.toString()));

              if (signUpResponse.status == true) {
                yield SignUpSuccess();
              } else {
                yield ErrorState(error: signUpResponse.message);
              }
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'Error');
          }
        }
      }
    } else if (event is VerifyOTPSignUpUser) {
      yield LoadingState();
      if (event.email.isEmpty) {
        yield ErrorState(error: '');
      } else if (event.otp.isEmpty) {
        yield ErrorState(error: '');
      } else {
        var isInternetConnected = await checkInternetConnectivity();
        if (isInternetConnected == false) {
          yield InternetErrorState(error: 'Internet not connected');
        } else {
          try {
            dynamic response = await Repository().signupVerifyOTP(
              otp: event.otp,
              email: event.email,
            );
            print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              SignUpResponse signUpResponse =
                  SignUpResponse.fromJson(jsonDecode(response.toString()));

              if (signUpResponse.status == true) {
                yield SignUpVerifyOTP();
              } else {
                yield ErrorState(error: signUpResponse.message);
              }
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'OTP Invalid');
          }
        }
      }
    } else if (event is VerifyOTPForgetPassword) {
      yield LoadingState();
      if (event.email.isEmpty) {
        yield ErrorState(error: '');
      } else if (event.otp.isEmpty) {
        yield ErrorState(error: '');
      } else {
        var isInternetConnected = await checkInternetConnectivity();
        if (isInternetConnected == false) {
          yield InternetErrorState(error: 'Internet not connected');
        } else {
          try {
            dynamic response = await Repository().forgetPasswordVerifyOTP(
              otp: event.otp,
              email: event.email,
            );
            print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              SignUpResponse signUpResponse =
                  SignUpResponse.fromJson(jsonDecode(response.toString()));

              if (signUpResponse.status == true) {
                yield SignUpVerifyOTP();
              } else {
                yield ErrorState(error: signUpResponse.message);
              }
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'OTP Invalid');
          }
        }
      }
    } else if (event is VerifyChangeEmailEditProfile) {
      yield LoadingState();
      if (event.email.isEmpty) {
        yield ErrorState(error: '');
      } else if (event.otp.isEmpty) {
        yield ErrorState(error: '');
      } else {
        var isInternetConnected = await checkInternetConnectivity();
        if (isInternetConnected == false) {
          yield InternetErrorState(error: 'Internet not connected');
        } else {
          try {
            dynamic response = await Repository().forgetPasswordVerifyOTP(
              otp: event.otp,
              email: event.email,
            );
            print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              SignUpResponse signUpResponse =
                  SignUpResponse.fromJson(jsonDecode(response.toString()));

              if (signUpResponse.status == true) {
                yield ChangeEmailVerified();
              } else {
                yield ErrorState(error: signUpResponse.message);
              }
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'OTP Invalid');
          }
        }
      }
    } else if (event is ResendOTPSignUpUser) {
      yield LoadingState();
      if (event.email.isEmpty) {
        yield ErrorState(error: '');
      } else {
        var isInternetConnected = await checkInternetConnectivity();
        if (isInternetConnected == false) {
          yield InternetErrorState(error: 'Internet not connected');
        } else {
          try {
            dynamic response = await Repository().resendVerifyOTP(
              email: event.email,
            );
            print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              SignUpResponse signUpResponse =
                  SignUpResponse.fromJson(jsonDecode(response.toString()));

              if (signUpResponse.status == true) {
                yield ErrorState(error: signUpResponse.message);
              } else {
                yield ErrorState(error: signUpResponse.message);
              }
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'OTP Invalid');
          }
        }
      }
    } else if (event is ForgetPasswordSendOTP) {
      yield LoadingState();
      if (event.email.isEmpty) {
        yield ErrorState(error: '');
      } else {
        var isInternetConnected = await checkInternetConnectivity();
        if (isInternetConnected == false) {
          yield InternetErrorState(error: 'Internet not connected');
        } else {
          try {
            dynamic response = await Repository().forgetPasswordSendOTP(
              email: event.email,
            );
            print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              SignUpResponse signUpResponse =
                  SignUpResponse.fromJson(jsonDecode(response.toString()));

              if (signUpResponse.status == true) {
                yield ForgetPasswordOTPSendSuccess();
              } else {
                yield ErrorState(error: signUpResponse.message);
              }
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'Invalid');
          }
        }
      }
    } else if (event is SubmitBusinessRegistrationPage1Data) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response =
              await Repository().submitBusinessRegistrationPage1Data(
            addBusinessPage1Data: event.addBusinessPage1Data,
          );
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            RegisterBusinessStep1Response registerBusinessStep1 =
                RegisterBusinessStep1Response.fromJson(
                    jsonDecode(response.toString()));

            if (registerBusinessStep1.status == true) {
              print('||||123');
              yield RegisterBusinessStep1Submitted();
            } else {
              print('||||456');
              yield ErrorState(error: registerBusinessStep1.message);
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is SubmitBusinessRegistrationPage2Data) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response =
              await Repository().submitBusinessRegistrationPage2Data(
            addBusinessPage2Data: event.addBusinessPage2Data,
          );
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            RegisterStoreStep2Response registerStoreStep2Response =
                RegisterStoreStep2Response.fromJson(
                    jsonDecode(response.toString()));

            if (registerStoreStep2Response.status == true) {
              yield RegisterBusinessStep2Submitted();
            } else {
              yield ErrorState(error: registerStoreStep2Response.message);
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is CheckEmailAvailability) {
      yield LoadingState();
      if (event.email.isEmpty) {
        yield ErrorState(error: '');
      } else {
        var isInternetConnected = await checkInternetConnectivity();
        if (isInternetConnected == false) {
          yield InternetErrorState(error: 'Internet not connected');
        } else {
          try {
            dynamic response = await Repository().checkEmailAvailability(
              email: event.email,
            );
            print('Bloc Response: ${jsonDecode(response.toString())}');

            if (response != null) {
              SignUpResponse signUpResponse =
                  SignUpResponse.fromJson(jsonDecode(response.toString()));

              if (signUpResponse.status == true) {
                yield EmailCheckedSuccess();
              } else {
                yield ErrorState(error: signUpResponse.message);
              }
            } else {
              yield ErrorState(error: 'Timeout');
            }
          } catch (e) {
            yield ErrorState(error: 'Invalid');
          }
        }
      }
    } else if (event is RegisterDriver) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().registerDriver(
            addDriverModel: event.addDriverModel,
          );
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AddDriverResponse addDriverResponse =
                AddDriverResponse.fromJson(jsonDecode(response.toString()));

            if (addDriverResponse.status == true) {
              yield AddDriverState(addDriverResponse: addDriverResponse);
            } else {
              yield ErrorState(error: addDriverResponse.message);
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is GetDeliveryDriversDetails) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getDeliveryDriversDetails();
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            DeliveryDetailsResponse deliveryDetailsResponse =
                DeliveryDetailsResponse.fromJson(
                    jsonDecode(response.toString()));

            if (deliveryDetailsResponse.status == true) {
              AppGlobal.businessEmailDriver =
                  deliveryDetailsResponse.driverDetails.BusinessEmail;
              AppGlobal.address1Driver =
                  deliveryDetailsResponse.driverDetails.Address1;
              AppGlobal.address2Driver =
                  deliveryDetailsResponse.driverDetails.Address2;
              AppGlobal.cityDiver = deliveryDetailsResponse.driverDetails.City;
              AppGlobal.cityIDDriver =
                  deliveryDetailsResponse.driverDetails.CityID;

              AppGlobal.stateDriver =
                  deliveryDetailsResponse.driverDetails.State;

              AppGlobal.governmentIDDriver =
                  deliveryDetailsResponse.driverDetails.GovernmentID;
              AppGlobal.countryIDDriver =
                  deliveryDetailsResponse.driverDetails.CountryID;
              AppGlobal.zipCodeDriver =
                  deliveryDetailsResponse.driverDetails.ZipCode;
              AppGlobal.paymentAccountDriver =
                  deliveryDetailsResponse.driverDetails.PaymentAccount;
              AppGlobal.paymentRoutingDriver =
                  deliveryDetailsResponse.driverDetails.PaymentRouting;
              AppGlobal.gatewayIDDriver =
                  deliveryDetailsResponse.driverDetails.GatewayID;
              yield GetDeliveryDriversDetailsState();
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is GetVendorAllowedCountries) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getVendorAllowedCountries();
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AllowedCountriesResponse allowedCountriesResponse =
                AllowedCountriesResponse.fromJson(
                    jsonDecode(response.toString()));

            if (allowedCountriesResponse.status == true) {
              yield VendorAllowedCountries(
                  allowedCountriesResponse: allowedCountriesResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is GetVendorAllowedStates) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response =
              await Repository().getVendorAllowedStates(id: event.id);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AllowedVendorStatesResponse allowedVendorStatesResponse =
                AllowedVendorStatesResponse.fromJson(
                    jsonDecode(response.toString()));

            if (allowedVendorStatesResponse.status == true) {
              yield VendorAllowedStates(
                  allowedVendorStatesResponse: allowedVendorStatesResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is CheckUserBusiness) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getUserBusiness(id: event.id);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AlreadyHaveBusinessResponse alreadyHaveBusinessResponse =
                AlreadyHaveBusinessResponse.fromJson(
                    jsonDecode(response.toString()));

            if (alreadyHaveBusinessResponse.status == false) {
              yield BusinessNotExist();
            } else {
              yield ErrorState(error: alreadyHaveBusinessResponse.message);
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is GetVendorAllowedCities) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response =
              await Repository().getVendorAllowedCities(id: event.id);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            AllowedVendorCityResponse allowedVendorCityResponse =
                AllowedVendorCityResponse.fromJson(
                    jsonDecode(response.toString()));

            if (allowedVendorCityResponse.status == true) {
              yield VendorAllowedCities(
                  allowedVendorCityResponse: allowedVendorCityResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is GetPathaoAccessToken) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository().getPathaoAccessToken();
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            PathaoAccessTokenResponse pathaoAccessTokenResponse =
                PathaoAccessTokenResponse.fromJson(
                    jsonDecode(response.toString()));

            //log(pathaoAccessTokenResponse.token);

            if (pathaoAccessTokenResponse.status == true) {
              yield PathaoGetAccessTokenState(
                  pathaoAccessTokenResponse: pathaoAccessTokenResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is GetPathaoCities) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .getPathaoCities(pathaoTokenModel: event.pathaoTokenModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            PathaoCitiesResponse pathaoCitiesResponse =
                PathaoCitiesResponse.fromJson(jsonDecode(response.toString()));

            if (pathaoCitiesResponse.status == true) {
              yield PathaoCitiesState(
                  pathaoCitiesResponse: pathaoCitiesResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is GetPathaoZones) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .getPathaoZones(pathaoZoneModel: event.pathaoZoneModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            PathaoZonesResponse pathaoZonesResponse =
                PathaoZonesResponse.fromJson(jsonDecode(response.toString()));

            if (pathaoZonesResponse.status == true) {
              yield PathaoZonesState(pathaoZonesResponse: pathaoZonesResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is GetPathaoAreas) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response = await Repository()
              .getPathaoAreas(pathaoAreaModel: event.pathaoAreaModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            PathaoAreaResponse pathaoAreaResponse =
                PathaoAreaResponse.fromJson(jsonDecode(response.toString()));

            if (pathaoAreaResponse.status == true) {
              yield PathaoAreasState(pathaoAreaResponse: pathaoAreaResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    } else if (event is Logout) {
      yield LoadingState();

      var isInternetConnected = await checkInternetConnectivity();
      if (isInternetConnected == false) {
        yield InternetErrorState(error: 'Internet not connected');
      } else {
        try {
          dynamic response =
              await Repository().logout(logoutModel: event.logoutModel);
          print('Bloc Response: ${jsonDecode(response.toString())}');

          if (response != null) {
            OrderStatusChangeResponse orderStatusChangeResponse =
                OrderStatusChangeResponse.fromJson(
                    jsonDecode(response.toString()));

            if (orderStatusChangeResponse.status == true) {
              yield LogoutState(
                  orderStatusChangeResponse: orderStatusChangeResponse);
            } else {
              yield ErrorState(error: 'Error');
            }
          } else {
            yield ErrorState(error: 'Timeout');
          }
        } catch (e) {
          yield ErrorState(error: 'Invalid');
        }
      }
    }
  }
}

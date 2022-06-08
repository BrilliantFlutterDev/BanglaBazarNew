part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class LoadingState extends CartState {}

class ErrorState extends CartState {
  final String error;
  ErrorState({required this.error});
}

class CartDetailsState extends CartState {
  final CartDetailsResponse cartDetailsResponse;
  CartDetailsState({required this.cartDetailsResponse});
}

class UsersHistoryAddressesState extends CartState {
  final UsersHistoryAddresses usersHistoryAddresses;
  UsersHistoryAddressesState({required this.usersHistoryAddresses});
}

class CartDetailsLocalDBState extends CartState {
  final RequestUserCartProducts requestUserCartProducts;
  CartDetailsLocalDBState({required this.requestUserCartProducts});
}

class CartCombinationDetailsLocalDBState extends CartState {
  final RequestUserCartProductsCombinations requestUserCartProductsCombinations;
  CartCombinationDetailsLocalDBState(
      {required this.requestUserCartProductsCombinations});
}

class InternetErrorState extends CartState {
  final String error;
  InternetErrorState({required this.error});
}

class GetPaymentHistoryState extends CartState {
  final PaymentHistory paymentHistory;
  GetPaymentHistoryState({required this.paymentHistory});
}

class VendorAllowedCountries extends CartState {
  final AllowedCountriesResponse allowedCountriesResponse;
  VendorAllowedCountries({required this.allowedCountriesResponse});
}

class CardDetailsState extends CartState {
  final CardDetailsResponse cardDetailsResponse;
  CardDetailsState({required this.cardDetailsResponse});
}

class PathaoGetAccessTokenState extends CartState {
  final PathaoAccessTokenResponse pathaoAccessTokenResponse;
  PathaoGetAccessTokenState({required this.pathaoAccessTokenResponse});
}

class VendorAllowedStates extends CartState {
  final AllowedVendorStatesResponse allowedVendorStatesResponse;
  VendorAllowedStates({required this.allowedVendorStatesResponse});
}

class VendorAllowedCities extends CartState {
  final AllowedVendorCityResponse allowedVendorCityResponse;
  VendorAllowedCities({required this.allowedVendorCityResponse});
}

class PathaoCitiesState extends CartState {
  final PathaoCitiesResponse pathaoCitiesResponse;
  PathaoCitiesState({required this.pathaoCitiesResponse});
}

class PathaoZonesState extends CartState {
  final PathaoZonesResponse pathaoZonesResponse;
  PathaoZonesState({required this.pathaoZonesResponse});
}

class PathaoAreasState extends CartState {
  final PathaoAreaResponse pathaoAreaResponse;
  PathaoAreasState({required this.pathaoAreaResponse});
}

class PathaoPriceCalculationState extends CartState {
  final PathaoPriceCalculationResponse pathaoPriceCalculationResponse;
  PathaoPriceCalculationState({required this.pathaoPriceCalculationResponse});
}

class CheckInventoryState extends CartState {
  final GetInventoryCountResponse getInventoryCountResponse;
  CheckInventoryState({required this.getInventoryCountResponse});
}

class GetInventoryState extends CartState {
  final GetInventoryCountResponse getInventoryCountResponse;
  GetInventoryState({required this.getInventoryCountResponse});
}

class CheckDriverAvailabilityState extends CartState {
  final CheckDeliveryDriverResponse checkDeliveryDriverResponse;
  CheckDriverAvailabilityState({required this.checkDeliveryDriverResponse});
}

class VerifyUspsAddressState extends CartState {
  final UspsAddressVerifyResponse uspsAddressVerifyResponse;
  VerifyUspsAddressState({required this.uspsAddressVerifyResponse});
}

class UspsCalculateRateState extends CartState {
  final UspsRateCalculationResponse uspsRateCalculationResponse;
  UspsCalculateRateState({required this.uspsRateCalculationResponse});
}

class GetTransectionDetailsState extends CartState {
  final TransectionDetailsResponse transectionDetailsResponse;
  GetTransectionDetailsState({required this.transectionDetailsResponse});
}

class ProductRemoveFromCartState extends CartState {
  final AddOrderProcessResponse addOrderProcessResponse;
  ProductRemoveFromCartState({required this.addOrderProcessResponse});
}

class CartUpdatedState extends CartState {
  final AddOrderProcessResponse addOrderProcessResponse;
  CartUpdatedState({required this.addOrderProcessResponse});
}

class TransectionInitializedState extends CartState {
  final SSLCommerzInitResponse sslCommerzInitResponse;
  TransectionInitializedState({required this.sslCommerzInitResponse});
}

class TransectionInitStripeState extends CartState {
  final StripInitResponse stripInitResponse;
  TransectionInitStripeState({required this.stripInitResponse});
}

class TransectionInitStripeValidateState extends CartState {
  final StripePaymentValidateResponse stripePaymentValidateResponse;
  TransectionInitStripeValidateState(
      {required this.stripePaymentValidateResponse});
}

class AuthNetTransectionInitializedState extends CartState {
  final AuthorizedNetPaymentResponse authorizedNetPaymentResponse;
  AuthNetTransectionInitializedState(
      {required this.authorizedNetPaymentResponse});
}

class CashOnDeliveryInitState extends CartState {
  final CODInitResponse cashOnDeliveryInitResponse;
  CashOnDeliveryInitState({required this.cashOnDeliveryInitResponse});
}

class AddUserPaymentState extends CartState {
  final AddUserPaymentResponse addUserPaymentResponse;
  AddUserPaymentState({required this.addUserPaymentResponse});
}

class GetShippingStatusState extends CartState {
  final GetShippingDetailsResponse getShippingDetailsResponse;
  GetShippingStatusState({required this.getShippingDetailsResponse});
}

class OrderPlacedSuccessfullyState extends CartState {
  OrderPlacedSuccessfullyState();
}

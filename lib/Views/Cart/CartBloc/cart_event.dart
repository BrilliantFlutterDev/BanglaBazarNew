part of 'cart_bloc.dart';

abstract class CartEvent {}

class GetCartDetails extends CartEvent {
  GetCartDetails();
}

class GetUserAddressHistory extends CartEvent {
  GetUserAddressHistory();
}

class GetLocalCartDetails extends CartEvent {
  GetLocalCartDetails();
}

class GetLocalCartCombinationDetails extends CartEvent {
  GetLocalCartCombinationDetails();
}

class DeleteCartLocalProduct extends CartEvent {
  String uniqueNumber;
  DeleteCartLocalProduct({required this.uniqueNumber});
}

class GetPaymentHistory extends CartEvent {
  GetPaymentHistory();
}

class GetVendorAllowedCountries extends CartEvent {
  GetVendorAllowedCountries();
}

class GetVendorAllowedStates extends CartEvent {
  final int id;
  GetVendorAllowedStates({required this.id});
}

class GetVendorAllowedCities extends CartEvent {
  final int id;
  GetVendorAllowedCities({required this.id});
}

class GetPathaoCities extends CartEvent {
  final PathaoTokenModel pathaoTokenModel;
  GetPathaoCities({required this.pathaoTokenModel});
}

class GetPathaoZones extends CartEvent {
  final PathaoZoneModel pathaoZoneModel;
  GetPathaoZones({required this.pathaoZoneModel});
}

class GetPathaoAreas extends CartEvent {
  final PathaoAreaModel pathaoAreaModel;
  GetPathaoAreas({required this.pathaoAreaModel});
}

class PathaoPriceCalculation extends CartEvent {
  final PathaoPriceCalculationModel pathaoPriceCalculationModel;
  PathaoPriceCalculation({required this.pathaoPriceCalculationModel});
}

class CheckDriverAvailability extends CartEvent {
  final CheckDeliveryDriverModel checkDeliveryDriverModel;
  CheckDriverAvailability({required this.checkDeliveryDriverModel});
}

class VerifyUspsAddress extends CartEvent {
  final UspsAddressVerifyModel uspsAddressVerifyModel;
  VerifyUspsAddress({required this.uspsAddressVerifyModel});
}

class UspsCalculateRate extends CartEvent {
  final UspsRateCalculationModel uspsRateCalculationModel;
  UspsCalculateRate({required this.uspsRateCalculationModel});
}

class GetUserCardDetails extends CartEvent {
  GetUserCardDetails();
}

class GetPathaoAccessToken extends CartEvent {
  GetPathaoAccessToken();
}

class TransectionInitSSLCommerce extends CartEvent {
  final SSLCommerceTransInitModel transInitModel;
  TransectionInitSSLCommerce({required this.transInitModel});
}
class TransectionInitStripe extends CartEvent {
  final  StripeTransInitModel stripeTransInitModel;
  TransectionInitStripe({required this.stripeTransInitModel});
}

class AuthNetTransectionInit extends CartEvent {
  final AuthorizedNetPaymentModel transInitModel;
  AuthNetTransectionInit({required this.transInitModel});
}

class CashOnDeliveryInitEvent extends CartEvent {
  final CODInitModel cashOnDeliveryInit;
  CashOnDeliveryInitEvent({required this.cashOnDeliveryInit});
}

class AddUserPayment extends CartEvent {
  final AddUserPaymentModel addUserPaymentModel;
  AddUserPayment({required this.addUserPaymentModel});
}

class AddProcessOrder extends CartEvent {
  final AddProcessOrderModel addProcessOrderModel;
  AddProcessOrder({required this.addProcessOrderModel});
}

class GetShippingStatus extends CartEvent {
  final DeliveryProductsCheckModel deliveryProductsCheckModel;
  GetShippingStatus({required this.deliveryProductsCheckModel});
}

class GetTransectionDetails extends CartEvent {
  final SSLGetDetailsModel sslGetDetailsModel;
  GetTransectionDetails({required this.sslGetDetailsModel});
}

class RemoveProductFromCart extends CartEvent {
  final String id;
  final RemoveFromCartModel removeFromCartModel;
  RemoveProductFromCart({required this.id, required this.removeFromCartModel});
}

class UpdateCart extends CartEvent {
  final UpdateCartModel productDetail;
  UpdateCart({required this.productDetail});
}

class UpdatePaymentStatus extends CartEvent {
  final String id;
  final String status;
  UpdatePaymentStatus({required this.id, required this.status});
}

class GetInventory extends CartEvent {
  final CartDetailsResponse cartDetailsResponseTemp;
  GetInventory({required this.cartDetailsResponseTemp});
}

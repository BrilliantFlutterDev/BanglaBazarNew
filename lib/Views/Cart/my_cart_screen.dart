import 'package:bangla_bazar/ModelClasses/cart_details_response.dart';
import 'package:bangla_bazar/ModelClasses/get_inventory_count_model.dart'
    as inventory;
import 'package:bangla_bazar/ModelClasses/get_inventory_count_response.dart';
import 'package:bangla_bazar/ModelClasses/remove_from_cart_model.dart'
    as removeCart;
import 'package:bangla_bazar/ModelClasses/add_to_cart_model.dart' as cart;
import 'package:bangla_bazar/ModelClasses/update_cart_model.dart' as updateCart;
import 'package:bangla_bazar/Utils/add_to_cart_local_db.dart' as localDB;
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/loginscreen.dart';
import 'package:bangla_bazar/Views/Cart/CartBloc/cart_bloc.dart';
import 'package:bangla_bazar/Views/Cart/checkout_address_Screen.dart';
import 'package:bangla_bazar/Views/Cart/checkout_country_selection.dart';
import 'package:bangla_bazar/Views/Cart/checkout_summary_screen.dart';
import 'package:bangla_bazar/Views/Cart/previous_address_selection_screen.dart';
import 'package:bangla_bazar/Views/main_home_page.dart';
import 'package:bangla_bazar/Widgets/my_cart_product_widget.dart';
import 'package:bangla_bazar/Widgets/photo_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyCartScreen extends StatefulWidget {
  //static const String id = 'chatscreen';
  //final GlobalKey<ScaffoldState> parentScaffoldKey;

  const MyCartScreen({
    Key? key,
  }) : super(key: key);
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  TextEditingController searchController = TextEditingController();
  late CartBloc _cartBloc;
  CartDetailsResponse? cartDetailsResponse;
  CartDetailsResponse? cartDetailsResponseTemp;
  removeCart.RemoveFromCartModel? removeFromCartModel;
  cart.ProductDetail? productDetail;
  updateCart.UpdateCartModel? updateCartModel;
  localDB.RequestUserCartProducts? requestUserCartProducts;
  localDB.RequestUserCartProductsCombinations?
      requestUserCartProductsCombinations;

  //inventory.GetInventoryCountModel? getInventoryCountModel;

  GetInventoryCountResponse? getInventoryCountResponse;

  @override
  void initState() {
    super.initState();
    _cartBloc = BlocProvider.of<CartBloc>(context);
    if (AppGlobal.userID != -1) {
      _cartBloc.add(GetCartDetails());
    } else {
      _cartBloc.add(GetLocalCartDetails());
    }
    cartDetailsResponseTemp =
        CartDetailsResponse(status: true, productCartList: []);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<CartBloc, CartState>(listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is ErrorState) {
        if (state.error == 'Product Deleted (L)') {
          _cartBloc.add(GetLocalCartDetails());
        }
        Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
      } else if (state is InternetErrorState) {
        Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
      } else if (state is CartDetailsState) {
        cartDetailsResponse = state.cartDetailsResponse;
        cartDetailsResponseTemp!.productCartList.clear();
        cartDetailsResponseTemp!.cartTotalPrice = 0.0;
      } else if (state is ProductRemoveFromCartState) {
        cartDetailsResponseTemp!.productCartList.clear();
        cartDetailsResponseTemp!.cartTotalPrice = 0.0;
        if (AppGlobal.userID != -1) {
          _cartBloc.add(GetCartDetails());
        }
      } else if (state is CartUpdatedState) {
        cartDetailsResponseTemp!.productCartList.clear();
        cartDetailsResponseTemp!.cartTotalPrice = 0.0;
        cartDetailsResponseTemp!.totalTax = 0.0;
        if (AppGlobal.userID != -1) {
          _cartBloc.add(GetCartDetails());
        }
      } else if (state is CartDetailsLocalDBState) {
        requestUserCartProducts = state.requestUserCartProducts;

        _cartBloc.add(GetLocalCartCombinationDetails());
      } else if (state is GetInventoryState) {
        getInventoryCountResponse = state.getInventoryCountResponse;
        if (getInventoryCountResponse!.outOfStockProducts.isEmpty) {
          if (cartDetailsResponseTemp != null) {
            if (cartDetailsResponseTemp!.productCartList.isNotEmpty) {
              bool countriesAreSame = true;
              for (int i = 0;
                  i < cartDetailsResponseTemp!.productCartList.length;
                  i++) {
                if (cartDetailsResponseTemp!
                        .productCartList[0].ProductCountry !=
                    cartDetailsResponseTemp!
                        .productCartList[i].ProductCountry) {
                  countriesAreSame = false;
                  break;
                }
              }
              if (countriesAreSame == false) {
                DialogUtils.showCustomDialog(
                  context,
                  title: "Delivery Issue",
                  message:
                      'Country of origin is not same of these products. Kindly, proceed checkout one by one.',
                );
              } else {
                //getInventoryCountModel = GetInventoryCountModel(productDetail: productDetail)
                bool globalShipping = true;
                bool shippingAvailable = true;
                String shippingAvailableCity = '';
                int shippingAvailableCountryID = -1;
                String globalShippingCountry = '';

                ///Check Global Shipping and Shipping Availability
                for (int i = 0;
                    i < cartDetailsResponseTemp!.productCartList.length;
                    i++) {
                  ///Global Shipping Available
                  if ((cartDetailsResponseTemp!
                              .productCartList[i].ShippingGlobal ==
                          'N') &&
                      (cartDetailsResponseTemp!
                              .productCartList[i].ShippingAvailable ==
                          'N')) {
                    globalShipping = false;
                    shippingAvailable = false;
                    shippingAvailableCity =
                        cartDetailsResponseTemp!.productCartList[i].City!;
                    shippingAvailableCountryID = cartDetailsResponseTemp!
                        .productCartList[i].ProductCountry!;
                    break;
                  }

                  ///Shipping with in the same country in all cities
                  else if ((cartDetailsResponseTemp!
                              .productCartList[i].ShippingGlobal ==
                          'N') &&
                      (cartDetailsResponseTemp!
                              .productCartList[i].ShippingAvailable ==
                          'Y')) {
                    globalShipping = false;
                    shippingAvailable = true;
                    shippingAvailableCity =
                        cartDetailsResponseTemp!.productCartList[i].City!;
                    shippingAvailableCountryID = cartDetailsResponseTemp!
                        .productCartList[i].ProductCountry!;
                    break;
                  } else if ((cartDetailsResponseTemp!
                              .productCartList[i].ShippingGlobal ==
                          'Y') &&
                      (cartDetailsResponseTemp!
                              .productCartList[i].ShippingAvailable ==
                          'N')) {
                    globalShipping = true;
                    shippingAvailable = false;
                    shippingAvailableCity =
                        cartDetailsResponseTemp!.productCartList[i].City!;
                    shippingAvailableCountryID = cartDetailsResponseTemp!
                        .productCartList[i].ProductCountry!;
                    break;
                  }
                }

                // if (shippingAvailable == false && globalShipping == false) {
                // } else if (shippingAvailable == false &&
                //     globalShipping == true) {
                // } else if (shippingAvailable == true &&
                //     globalShipping == false) {
                // } else if (shippingAvailable == true &&
                //     globalShipping == true) {}

                bool citiesOfAllProductsSame = true;
                for (int i = 0;
                    i < cartDetailsResponseTemp!.productCartList.length;
                    i++) {
                  if (cartDetailsResponseTemp!.productCartList[i].City !=
                      shippingAvailableCity) {
                    citiesOfAllProductsSame = false;
                    break;
                  }
                }

                ///Delivery Custom Checks

                if (shippingAvailable == false && globalShipping == false) {
                  if (citiesOfAllProductsSame == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutCountrySelection(
                            cartDetailsResponse: cartDetailsResponseTemp!,
                            countriesAreSame: countriesAreSame,
                            globalShipping: globalShipping,
                            shippingAvailable: shippingAvailable,
                            shippingAvailableCity: shippingAvailableCity,
                            shippingAvailableCountryID:
                                shippingAvailableCountryID,
                            globalShippingCountry: globalShippingCountry),
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Cities of all the products should be same.',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey.shade400,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                } else if (shippingAvailable == false &&
                    globalShipping == true) {
                  if (citiesOfAllProductsSame == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutCountrySelection(
                            cartDetailsResponse: cartDetailsResponseTemp!,
                            countriesAreSame: countriesAreSame,
                            globalShipping: globalShipping,
                            shippingAvailable: shippingAvailable,
                            shippingAvailableCity: shippingAvailableCity,
                            shippingAvailableCountryID:
                                shippingAvailableCountryID,
                            globalShippingCountry: globalShippingCountry),
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Cities of all the products should be same.',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey.shade400,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                } else if (shippingAvailable == true &&
                    globalShipping == false) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutCountrySelection(
                          cartDetailsResponse: cartDetailsResponseTemp!,
                          countriesAreSame: countriesAreSame,
                          globalShipping: globalShipping,
                          shippingAvailable: shippingAvailable,
                          shippingAvailableCity: shippingAvailableCity,
                          shippingAvailableCountryID:
                              shippingAvailableCountryID,
                          globalShippingCountry: globalShippingCountry),
                    ),
                  );
                  print(
                      '>>>>>>>>Condition 3(a): Country Should be same and can choose any city, cities product should,shouldn\'t be same on next page');
                } else if (shippingAvailable == true &&
                    globalShipping == true) {
                  shippingAvailableCity =
                      cartDetailsResponseTemp!.productCartList[0].City!;
                  shippingAvailableCountryID = cartDetailsResponseTemp!
                      .productCartList[0].ProductCountry!;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutCountrySelection(
                          cartDetailsResponse: cartDetailsResponseTemp!,
                          countriesAreSame: countriesAreSame,
                          globalShipping: globalShipping,
                          shippingAvailable: shippingAvailable,
                          shippingAvailableCity: shippingAvailableCity,
                          shippingAvailableCountryID:
                              shippingAvailableCountryID,
                          globalShippingCountry: globalShippingCountry),
                    ),
                  );
                  print(
                      '>>>>>>>>Condition 4(a): User can choose any city and any country');
                }

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           PreviousAddressSelectionScreen(
                //             cartDetailsResponse:
                //                 cartDetailsResponseTemp!,
                //           )),
                // );
              }
            } else {
              Fluttertoast.showToast(
                  msg: 'Please select products to checkout',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey.shade400,
                  textColor: Colors.white,
                  fontSize: 12.0);
            }
          } else {
            Fluttertoast.showToast(
                msg: 'Please select products to checkout',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade400,
                textColor: Colors.white,
                fontSize: 12.0);
          }
        } else {
          for (int i = 0;
              i < getInventoryCountResponse!.outOfStockProducts.length;
              i++) {
            for (int j = 0;
                j <
                    getInventoryCountResponse!
                        .outOfStockProducts[i].productDetail.length;
                j++) {
              if (getInventoryCountResponse!
                      .outOfStockProducts[i].productDetail[j].Inventory ==
                  0) {
                Fluttertoast.showToast(
                    msg:
                        "${getInventoryCountResponse!.outOfStockProducts[i].productDetail[j].Title} >>> Variant : ${getInventoryCountResponse!.outOfStockProducts[i].productDetail[j].OptionValue} is not available.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey.shade400,
                    textColor: Colors.white,
                    fontSize: 12.0);
              }
            }
          }
        }
      } else if (state is CartCombinationDetailsLocalDBState) {
        requestUserCartProductsCombinations =
            state.requestUserCartProductsCombinations;

        cartDetailsResponse =
            CartDetailsResponse(status: true, productCartList: []);
        for (int i = 0;
            i < requestUserCartProducts!.cartProducts!.length;
            i++) {
          cartDetailsResponse!.productCartList.add(ProductCartList(
              ProductID: requestUserCartProducts!.cartProducts![i].ProductID,
              Title: requestUserCartProducts!.cartProducts![i].Title,
              CompanyName:
                  requestUserCartProducts!.cartProducts![i].CompanyName,
              VendorID: requestUserCartProducts!.cartProducts![i].VendorID,
              City: requestUserCartProducts!.cartProducts![i].City,
              Native: requestUserCartProducts!.cartProducts![i].Native,
              // BasePrice: requestUserCartProducts!.cartProducts![i].BasePrice,
              Currency: requestUserCartProducts!.cartProducts![i].Currency,
              UserID: requestUserCartProducts!.cartProducts![i].UserID,
              TotalQuantity: int.parse(
                  requestUserCartProducts!.cartProducts![i].TotalQuantity!),
              Small: requestUserCartProducts!.cartProducts![i].Small,
              Medium: requestUserCartProducts!.cartProducts![i].Medium,
              Large: requestUserCartProducts!.cartProducts![i].Large,
              MainImage: requestUserCartProducts!.cartProducts![i].MainImage,
              REVIEWCOUNT:
                  requestUserCartProducts!.cartProducts![i].REVIEWCOUNT,
              AllowStorePickup:
                  requestUserCartProducts!.cartProducts![i].AllowStorePickup,
              productCombinations: [],
              ProductCityID:
                  requestUserCartProducts!.cartProducts![i].ProductCityID,
              ProductCountry:
                  requestUserCartProducts!.cartProducts![i].ProductCityID,
              uniqueNumber:
                  requestUserCartProducts!.cartProducts![i].uniqueNumber,
              calculateTotalProductPrice: double.parse(
                  requestUserCartProducts!.cartProducts![i].BasePrice),
              Width: '1',
              Weight: '1',
              Length: '1',
              Height: '1'));
          for (int j = 0;
              j <
                  requestUserCartProductsCombinations!
                      .cartProductsCombinations!.length;
              j++) {
            if (requestUserCartProductsCombinations!
                    .cartProductsCombinations![j].uniqueNumber ==
                requestUserCartProducts!.cartProducts![i].uniqueNumber) {
              cartDetailsResponse!.productCartList[i].productCombinations.add(
                  ProductCombinations(
                      ProductID: requestUserCartProductsCombinations!
                          .cartProductsCombinations![j].ProductID,
                      ProductVariantCombinationID:
                          requestUserCartProductsCombinations!
                              .cartProductsCombinations![j]
                              .ProductVariantCombinationID,
                      uniqueNumber: requestUserCartProductsCombinations!
                          .cartProductsCombinations![j].uniqueNumber,
                      ProductCombinationPrice: '0.0',
                      AvailableInventory: 1,
                      OptionID: 0,
                      VendorStoreID: 0,
                      OptionName: '',
                      OptionValue: '',
                      OptionValueID: 0));
            }
          }
        }
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
            backgroundColor: kColorWhite,
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: screenSize.height,
                    width: screenSize.width,
                    color: kColorWhite,

                    ///This is the body
                    child: cartDetailsResponse != null
                        ? cartDetailsResponse!.productCartList.isNotEmpty
                            ? SingleChildScrollView(
                                child: Column(
                                children: [
                                  Container(
                                    // color: Colors.red,
                                    width: screenSize.width,
                                    height: screenSize.height * 0.13,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Products',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          HomePage()),
                                              (Route<dynamic> route) => false);
                                        },
                                        child: Container(
                                          height: screenSize.height * 0.05,
                                          width: screenSize.width * 0.25,
                                          decoration: const BoxDecoration(
                                            color: kColorWidgetBackgroundColor,
                                            // border: Border.all(
                                            //     color: kColorWidgetBackgroundColor, // Set border color
                                            //     width: 0.0),   // Set border width
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    35.0)), // Set rounded corner radius
                                            // Make rounded corner of border
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.add,
                                                size: 15,
                                                color: kColorPrimary,
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                'Add Item',
                                                style: TextStyle(
                                                    color: kColorPrimary,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: screenSize.width,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: cartDetailsResponse != null
                                            ? cartDetailsResponse!
                                                .productCartList.length
                                            : 0,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Theme(
                                                      data: ThemeData(
                                                          unselectedWidgetColor:
                                                              Colors.grey),
                                                      child: Checkbox(
                                                        value: cartDetailsResponse!
                                                            .productCartList[
                                                                index]
                                                            .selectedForCheckout,
                                                        onChanged: (state) {
                                                          cartDetailsResponse!
                                                                  .productCartList[
                                                                      index]
                                                                  .selectedForCheckout =
                                                              state!;
                                                          if (cartDetailsResponse!
                                                              .productCartList[
                                                                  index]
                                                              .selectedForCheckout) {
                                                            cartDetailsResponseTemp!
                                                                .productCartList
                                                                .add(cartDetailsResponse!
                                                                        .productCartList[
                                                                    index]);
                                                            cartDetailsResponseTemp!
                                                                .cartTotalPrice = cartDetailsResponseTemp!
                                                                    .cartTotalPrice +
                                                                cartDetailsResponse!
                                                                    .productCartList[
                                                                        index]
                                                                    .calculateTotalProductPrice!;
                                                            String
                                                                cartTotalPrice =
                                                                cartDetailsResponseTemp!
                                                                    .cartTotalPrice
                                                                    .toStringAsFixed(
                                                                        2);
                                                            cartDetailsResponseTemp!
                                                                    .cartTotalPrice =
                                                                double.parse(
                                                                    cartTotalPrice);
                                                            cartDetailsResponseTemp!
                                                                .totalTax = cartDetailsResponseTemp!
                                                                    .totalTax +
                                                                cartDetailsResponse!
                                                                    .productCartList[
                                                                        index]
                                                                    .perProductTax!;
                                                          } else {
                                                            cartDetailsResponseTemp!
                                                                .cartTotalPrice = cartDetailsResponseTemp!
                                                                    .cartTotalPrice -
                                                                cartDetailsResponse!
                                                                    .productCartList[
                                                                        index]
                                                                    .calculateTotalProductPrice!;
                                                            cartDetailsResponseTemp!
                                                                .productCartList
                                                                .remove(cartDetailsResponse!
                                                                        .productCartList[
                                                                    index]);

                                                            cartDetailsResponseTemp!
                                                                .totalTax = cartDetailsResponseTemp!
                                                                    .totalTax -
                                                                cartDetailsResponse!
                                                                    .productCartList[
                                                                        index]
                                                                    .perProductTax!;
                                                          }

                                                          cartDetailsResponseTemp!
                                                                  .cartTotalPrice =
                                                              double.parse(
                                                                  cartDetailsResponseTemp!
                                                                      .cartTotalPrice
                                                                      .toStringAsFixed(
                                                                          2));

                                                          cartDetailsResponseTemp!
                                                                  .totalTax =
                                                              double.parse(
                                                                  cartDetailsResponseTemp!
                                                                      .totalTax
                                                                      .toStringAsFixed(
                                                                          2));
                                                          setState(() {});
                                                        },
                                                        activeColor:
                                                            kColorPrimary,
                                                        checkColor:
                                                            Colors.white,
                                                        materialTapTargetSize:
                                                            MaterialTapTargetSize
                                                                .padded,
                                                      )),
                                                  cartDetailsResponse!
                                                              .productCartList[
                                                                  index]
                                                              .ShippingByVendor ==
                                                          "Y"
                                                      ? Text(
                                                          'Shipping By ${cartDetailsResponse!.productCartList[index].CompanyName!}')
                                                      : const SizedBox(),
                                                  cartDetailsResponse!
                                                              .productCartList[
                                                                  index]
                                                              .ShippingByAdmin ==
                                                          "Y"
                                                      ? const Text(
                                                          'Shipping By BanglaBazar')
                                                      : const SizedBox(),
                                                  cartDetailsResponse!
                                                              .productCartList[
                                                                  index]
                                                              .ShippingByVendor ==
                                                          "Y"
                                                      ? const Text(' /')
                                                      : const SizedBox(),
                                                  cartDetailsResponse!
                                                              .productCartList[
                                                                  index]
                                                              .ShippingByAdmin ==
                                                          "Y"
                                                      ? const Text(' /')
                                                      : const SizedBox(),
                                                  SizedBox(
                                                    child: Text(
                                                      ' Pickup city : ${cartDetailsResponse!.productCartList[index].StoreCity}',
                                                      style: const TextStyle(
                                                          color:
                                                              kColorOrangeText),
                                                      maxLines: 2,
                                                    ),
                                                    width:
                                                        screenSize.width * 0.4,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              MyCartProductWidget(
                                                screenSize: screenSize,
                                                productCartList:
                                                    cartDetailsResponse!
                                                        .productCartList[index],
                                                onDeletePress: () {
                                                  if (AppGlobal.userID != -1) {
                                                    removeFromCartModel = removeCart
                                                        .RemoveFromCartModel(
                                                            productVariantCombinationDetail: [
                                                          removeCart.ProductVariantCombinationDetail(
                                                              ProductVariantCombinationID:
                                                                  cartDetailsResponse!
                                                                      .productCartList[
                                                                          index]
                                                                      .productCombinations[
                                                                          0]
                                                                      .ProductVariantCombinationID
                                                                      .toString())
                                                        ]);
                                                    for (int k = 1;
                                                        k <
                                                            cartDetailsResponse!
                                                                .productCartList[
                                                                    index]
                                                                .productCombinations
                                                                .length;
                                                        k++) {
                                                      removeFromCartModel!
                                                          .productVariantCombinationDetail!
                                                          .add(removeCart.ProductVariantCombinationDetail(
                                                              ProductVariantCombinationID: cartDetailsResponse!
                                                                  .productCartList[
                                                                      index]
                                                                  .productCombinations[
                                                                      k]
                                                                  .ProductVariantCombinationID
                                                                  .toString()));
                                                    }
                                                    _cartBloc.add(RemoveProductFromCart(
                                                        id: cartDetailsResponse!
                                                            .productCartList[
                                                                index]
                                                            .ProductID
                                                            .toString(),
                                                        removeFromCartModel:
                                                            removeFromCartModel!));
                                                  } else {
                                                    _cartBloc.add(DeleteCartLocalProduct(
                                                        uniqueNumber:
                                                            cartDetailsResponse!
                                                                .productCartList[
                                                                    index]
                                                                .uniqueNumber!));
                                                  }
                                                },
                                                onPlusButtonPress: () {
                                                  if (AppGlobal.userID != -1) {
                                                    int quantityTemp =
                                                        cartDetailsResponse!
                                                            .productCartList[
                                                                index]
                                                            .TotalQuantity!;
                                                    quantityTemp++;
                                                    cartDetailsResponse!
                                                            .productCartList[index]
                                                            .TotalQuantity =
                                                        quantityTemp;
                                                    updateCartModel = updateCart
                                                        .UpdateCartModel(
                                                            productDetail: [
                                                          updateCart.ProductDetail(
                                                              ProductID:
                                                                  cartDetailsResponse!
                                                                      .productCartList[
                                                                          index]
                                                                      .ProductID
                                                                      .toString(),
                                                              Quantity: '1',
                                                              productVariantCombinationDetail: [
                                                                updateCart.ProductVariantCombinationDetail(
                                                                    ProductVariantCombinationID: cartDetailsResponse!
                                                                        .productCartList[
                                                                            index]
                                                                        .productCombinations[
                                                                            0]
                                                                        .ProductVariantCombinationID
                                                                        .toString())
                                                              ])
                                                        ]);

                                                    for (int k = 1;
                                                        k <
                                                            cartDetailsResponse!
                                                                .productCartList[
                                                                    index]
                                                                .productCombinations
                                                                .length;
                                                        k++) {
                                                      updateCartModel!
                                                          .productDetail[0]
                                                          .productVariantCombinationDetail!
                                                          .add(updateCart.ProductVariantCombinationDetail(
                                                              ProductVariantCombinationID: cartDetailsResponse!
                                                                  .productCartList[
                                                                      index]
                                                                  .productCombinations[
                                                                      k]
                                                                  .ProductVariantCombinationID
                                                                  .toString()));
                                                    }
                                                    _cartBloc.add(UpdateCart(
                                                        productDetail:
                                                            updateCartModel!));
                                                  }
                                                },
                                                onMinusButtonPress: () {
                                                  if (AppGlobal.userID != -1) {
                                                    int quantityTemp =
                                                        cartDetailsResponse!
                                                            .productCartList[
                                                                index]
                                                            .TotalQuantity!;
                                                    if (quantityTemp > 1) {
                                                      quantityTemp--;

                                                      updateCartModel = updateCart
                                                          .UpdateCartModel(
                                                              productDetail: [
                                                            updateCart.ProductDetail(
                                                                ProductID: cartDetailsResponse!
                                                                    .productCartList[
                                                                        index]
                                                                    .ProductID
                                                                    .toString(),
                                                                Quantity: '-1',
                                                                productVariantCombinationDetail: [
                                                                  updateCart.ProductVariantCombinationDetail(
                                                                      ProductVariantCombinationID: cartDetailsResponse!
                                                                          .productCartList[
                                                                              index]
                                                                          .productCombinations[
                                                                              0]
                                                                          .ProductVariantCombinationID
                                                                          .toString())
                                                                ])
                                                          ]);

                                                      for (int k = 1;
                                                          k <
                                                              cartDetailsResponse!
                                                                  .productCartList[
                                                                      index]
                                                                  .productCombinations
                                                                  .length;
                                                          k++) {
                                                        updateCartModel!
                                                            .productDetail[0]
                                                            .productVariantCombinationDetail!
                                                            .add(updateCart.ProductVariantCombinationDetail(
                                                                ProductVariantCombinationID: cartDetailsResponse!
                                                                    .productCartList[
                                                                        index]
                                                                    .productCombinations[
                                                                        k]
                                                                    .ProductVariantCombinationID
                                                                    .toString()));
                                                      }
                                                      _cartBloc.add(UpdateCart(
                                                          productDetail:
                                                              updateCartModel!));
                                                    }
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                  const Text(
                                    'Pickup Note : Pick up will be only allowed if all the selected products are from same city and user selected that same city in address section.',
                                    style: TextStyle(color: kColorOrangeText),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Order Summary',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Subtotal',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: kColorFieldsBorders),
                                      ),
                                      Text(
                                        '${cartDetailsResponseTemp != null ? cartDetailsResponseTemp!.productCartList.length > 0 ? cartDetailsResponseTemp!.productCartList[0].Currency : '\$' : '\$'} ${cartDetailsResponseTemp != null ? cartDetailsResponseTemp!.cartTotalPrice : 0}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Discount',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: kColorFieldsBorders),
                                      ),
                                      Text(
                                        cartDetailsResponseTemp != null
                                            ? cartDetailsResponseTemp!
                                                    .productCartList.isNotEmpty
                                                ? cartDetailsResponseTemp!
                                                        .productCartList[0]
                                                        .Currency! +
                                                    ' 0'
                                                : '\$' ' 0'
                                            : '\$' ' 0',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'TAX/VAT',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: kColorFieldsBorders),
                                      ),
                                      Text(
                                        cartDetailsResponseTemp != null
                                            ? cartDetailsResponseTemp!
                                                    .productCartList.isNotEmpty
                                                ? cartDetailsResponseTemp!
                                                        .productCartList[0]
                                                        .Currency! +
                                                    ' ${cartDetailsResponseTemp!.totalTax}'
                                                : '\$'
                                                    ' ${cartDetailsResponseTemp!.totalTax}'
                                            : '\$'
                                                ' ${cartDetailsResponseTemp!.totalTax}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 1,
                                    width: screenSize.width,
                                    color: kColorFieldsBorders,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total Price',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        '${cartDetailsResponseTemp != null ? cartDetailsResponseTemp!.productCartList.length > 0 ? cartDetailsResponseTemp!.productCartList[0].Currency : '\$' : '\$'} ${cartDetailsResponseTemp != null ? (cartDetailsResponseTemp!.cartTotalPrice + cartDetailsResponseTemp!.totalTax).toStringAsFixed(2) : 0}',
                                        style: const TextStyle(
                                            fontSize: 18, color: kColorPrimary),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.1,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      ///
                                      if (AppGlobal.token != '' &&
                                          AppGlobal.userID != -1) {
                                        // for (int p = 0;
                                        //     p <
                                        //         cartDetailsResponse!
                                        //             .productCartList.length;
                                        //     p++) {
                                        //   if (cartDetailsResponse!
                                        //       .productCartList[p]
                                        //       .selectedForCheckout) {
                                        //     cartDetailsResponseTemp!
                                        //         .productCartList
                                        //         .add(cartDetailsResponse!
                                        //             .productCartList[p]);
                                        //   }
                                        // }
                                        /// Check inventory
                                        _cartBloc.add(GetInventory(
                                            cartDetailsResponseTemp:
                                                cartDetailsResponseTemp!));
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Login first',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                Colors.grey.shade400,
                                            textColor: Colors.white,
                                            fontSize: 12.0);
                                        Navigator.of(
                                                context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      }
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           CheckoutAddressScreen(
                                      //             cartDetailsResponse:
                                      //                 cartDetailsResponse!,
                                      //           )),
                                      // );
                                    },
                                    child: Container(
                                        height: 55,
                                        width: screenSize.width,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: kColorPrimary,
                                        ),
                                        child: const Center(
                                            child: Text(
                                          'Proceed to Checkout',
                                          style: TextStyle(
                                              color: kColorWhite, fontSize: 16),
                                        ))),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.1,
                                  ),
                                ],
                              ))
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/cart_empty_pic.png',
                                    scale: 3,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    'Your cart is empty',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: kColorFieldsBorders),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Container(
                                      height: screenSize.height * 0.05,
                                      width: screenSize.width * 0.43,
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kColorPrimary,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Continue Shopping',
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: kColorWhite, fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                        : const SizedBox(),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      color: kColorWhite,
                      width: screenSize.width,
                      height: screenSize.height * 0.042,
                    ),
                    Container(
                        color: kColorWhite,
                        width: screenSize.width,
                        height: screenSize.height * 0.09,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/BanglaBazarLogo.png',
                                width: screenSize.width * 0.50,
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ],
            )),
      );
    });
  }
}

class DialogUtils {
  static DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Center(
                child: Text(
              title,
              style: TextStyle(color: Colors.red),
            )),
            content: Text(message),
            actions: <Widget>[
              Center(
                child: FlatButton(
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: kColorPrimary,
                    onPressed: () => Navigator.pop(context)),
              )
            ],
          );
        });
  }
}

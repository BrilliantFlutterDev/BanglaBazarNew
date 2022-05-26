import 'package:bangla_bazar/ModelClasses/add_to_cart_model.dart' as cart;
import 'package:bangla_bazar/ModelClasses/allowed_countries_list_response.dart';
import 'package:bangla_bazar/ModelClasses/home_page_api_reponse.dart';
import 'package:bangla_bazar/ModelClasses/product_details_response.dart';

import 'package:bangla_bazar/ModelClasses/store_response.dart' as product;
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';

import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/Chat/personal_chat_screen.dart';

import 'package:bangla_bazar/Views/Product/ProductBloc/product_bloc.dart';
import 'package:bangla_bazar/Views/Product/store_screen.dart';
import 'package:bangla_bazar/Views/main_home_page.dart';
import 'package:bangla_bazar/Widgets/photo_avatar.dart';
import 'package:bangla_bazar/Widgets/product_user_review_widget.dart';
import 'package:bangla_bazar/Widgets/product_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productID;
  final String previousPage;
  HomePageApiResponse? homePageApiResponse;

  ProductDetailsScreen(
      {Key? key,
      required this.previousPage,
      required this.productID,
      this.homePageApiResponse})
      : super(key: key);
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late ProductBloc _productBloc;
  int activeTabNo = 3;
  TextEditingController reviewController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<String> topReviewList = ['Top Reviews', 'Best Reviews'];
  late String statusValueChoose;
  ProductDetailsResponse? productDetailsResponse;
  double productPrice = 0.0;
  int quantity = 0;
  double vendorRating = 0;
  double productRating = 0;
  double fiveRatingCount = 0;
  double fourRatingCount = 0;
  double threeRatingCount = 0;
  double twoRatingCount = 0;
  double oneRatingCount = 0;
  int availableInventory = -1;

  String stock = 'Stock';
  List<String> variantPic = [''];

  String totalPrice = '0.0';
  String currency = '\$';

  int _current = 0;
  int userProductRating = 0;
  double reviewStarsInitialValue = 0;

  int variantId = 0;

  late cart.AddToCartModel addToCartModel = cart.AddToCartModel();

  bool buyNow = false;

  List<String> allowedCountriesISO2List = [];
  AllowedCountriesResponse? allowedCountriesResponse;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc.add(GetProductDetails(id: widget.productID));
    _productBloc.add(AddClickToAProduct(id: widget.productID));
    _productBloc.add(GetVendorAllowedCountries());

    statusValueChoose = '';
    if (AppGlobal.token != '') {
      addToCartModel.sessionID = AppGlobal.token;
    }
    addToCartModel.productDetail = [
      cart.ProductDetail(
          productID: 0, quantity: 0, productVariantCombinationDetail: [])
    ];
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is ProductClickAddedToLocalDBState) {
      } else if (state is ErrorState) {
        Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
        userProductRating = 0;
        reviewStarsInitialValue = 0;
        reviewController.text = '';
      } else if (state is InternetErrorState) {
        Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
      } else if (state is VendorAllowedCountries) {
        allowedCountriesResponse = state.allowedCountriesResponse;
        // for (int i = 0; i < allowedCountriesResponse.countries.length; i++) {
        //   allowedCountriesISO2List
        //       .add(allowedCountriesResponse.countries[i].ISO2);
        // }
      } else if (state is ClickAddedToProduct) {
      } else if (state is AddedToCart) {
        if (buyNow == false) {
          Fluttertoast.showToast(
              msg: 'Product Added to cart',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey.shade400,
              textColor: Colors.white,
              fontSize: 12.0);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(
                        currentTab: 2,
                      )),
              (Route<dynamic> route) => false);
        }
      } else if (state is ReviewAdded) {
        Fluttertoast.showToast(
            msg: state.addReviewResponse.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
        userProductRating = 0;
        reviewStarsInitialValue = 0;
        reviewController.text = '';
        if (state.addReviewResponse.status == true) {
          _productBloc.add(GetProductDetails(id: widget.productID));
        }
      } else if (state is AddedInWishList) {
        Fluttertoast.showToast(
            msg: state.addToWishListResponse.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.white,
            fontSize: 12.0);
        if (state.addToWishListResponse.status == true) {
          if (productDetailsResponse != null) {
            if (productDetailsResponse!.inWishList == false) {
              productDetailsResponse!.inWishList = true;
            } else {
              productDetailsResponse!.inWishList = false;
            }
          }
        }
      } else if (state is ProductDetailsFetched) {
        productDetailsResponse = state.productDetailsResponse;
        productPrice =
            double.parse(productDetailsResponse!.productDetail.Price);
        vendorRating = double.parse(productDetailsResponse!
            .buisnessDetail.VendorRating
            .substring(0, 3));
        if (productDetailsResponse!
                .productAverageRatingAndReviews.ProductAverageRating !=
            '') {
          productRating = double.parse(productDetailsResponse!
              .productAverageRatingAndReviews.ProductAverageRating!
              .substring(0, 3));
        } else {
          productRating = 0;
        }
        //fiveRatingCount = productRating.toInt();
        if (productDetailsResponse!.productRatingCount.rating_5 != 0) {
          fiveRatingCount =
              ((productDetailsResponse!.productRatingCount.rating_5 /
                          productRating) *
                      100)
                  .toDouble();
        }
        if (productDetailsResponse!.productRatingCount.rating_4 != 0) {
          fourRatingCount =
              ((productDetailsResponse!.productRatingCount.rating_4 /
                          productRating) *
                      100)
                  .toDouble();
        }
        if (productDetailsResponse!.productRatingCount.rating_3 != 0) {
          threeRatingCount =
              ((productDetailsResponse!.productRatingCount.rating_3 /
                          productRating) *
                      100)
                  .toDouble();
        }
        if (productDetailsResponse!.productRatingCount.rating_2 != 0) {
          twoRatingCount =
              ((productDetailsResponse!.productRatingCount.rating_2 /
                          productRating) *
                      100)
                  .toDouble();
        }
        if (productDetailsResponse!.productRatingCount.rating_1 != 0) {
          oneRatingCount =
              ((productDetailsResponse!.productRatingCount.rating_1 /
                          productRating) *
                      100)
                  .toDouble();
        }

        productDetailsResponse!.MainImage =
            productDetailsResponse!.MainImage.replaceAll('\\', '/');

        stock = 'Stock';

        variantId = productDetailsResponse!
            .variantDetails[0].values[0].ProductVariantCombinationID;

        variantPic.clear();
        variantPic.add(productDetailsResponse!.MainImage);
        currency = productDetailsResponse!.productDetail.Currency;
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
                ///This is the body
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        // color: Colors.yellow,
                        width: screenSize.width,
                        height: screenSize.height * 0.125,
                      ),
                      Container(
                        height: screenSize.height * 0.30,
                        width: screenSize.width,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: screenSize.height * 0.30,
                                enableInfiniteScroll: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 6),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                    //print("${_current}");
                                  });
                                },
                              ),
                              items: variantPic.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: screenSize.height * 0.3,
                                      width: screenSize.width,
                                      child: CachedNetworkImage(
                                        imageUrl: productDetailsResponse != null
                                            ? AppGlobal.photosBaseURL + i
                                            : '',
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              color: kColorPrimary,
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            variantPic.length > 1
                                ? DotsIndicator(
                                    dotsCount: variantPic.length,
                                    position: _current.toDouble(),
                                    decorator: const DotsDecorator(
                                      spacing: EdgeInsets.all(6.0),
                                      activeColor: kColorPrimary,
                                    ))
                                : const SizedBox(),
                            // Container(
                            //   height: screenSize.height * 0.3,
                            //   width: screenSize.width,
                            //   color: kColorWidgetBackgroundColor,
                            //   child: ListView.builder(
                            //     itemCount: variantPic.length,
                            //     scrollDirection: Axis.horizontal,
                            //     itemBuilder: (context, i) {
                            //       return Container(
                            //         height: screenSize.height * 0.3,
                            //         width: screenSize.width,
                            //         child: CachedNetworkImage(
                            //           imageUrl: productDetailsResponse != null
                            //               ? AppGlobal.photosBaseURL +
                            //                   variantPic[i]
                            //               : '',
                            //           progressIndicatorBuilder:
                            //               (context, url, downloadProgress) =>
                            //                   Center(
                            //             child: CircularProgressIndicator(
                            //                 color: kColorPrimary,
                            //                 value: downloadProgress.progress),
                            //           ),
                            //           errorWidget: (context, url, error) =>
                            //               Icon(Icons.error),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    if (productDetailsResponse!.inWishList !=
                                        true) {
                                      _productBloc.add(AddToWishList(
                                          productId: widget.productID,
                                          variantId: variantId));
                                    } else {
                                      _productBloc.add(RemoveFromWishList(
                                          productId: widget.productID));
                                    }
                                  },
                                  child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kColorPrimary,
                                        // border: Border.all(
                                        //     color: kColorDarkGreyText, width: 3),
                                        // image: DecorationImage(
                                        //   image: Image.asset("assets/icons/eyeicon.png",),
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                      child: Icon(
                                        productDetailsResponse != null
                                            ? productDetailsResponse!
                                                        .inWishList ==
                                                    false
                                                ? MyFlutterApp.wishlist
                                                : MyFlutterApp.heart_icon
                                            : MyFlutterApp.wishlist,
                                        color: kColorWhite,
                                        size: 15,
                                      )),
                                ),
                              ),
                            ),

                            ///Uncomment this
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 15, vertical: 15),
                            //   child: Align(
                            //     alignment: Alignment.bottomRight,
                            //     child: InkWell(
                            //       onTap: () {
                            //         // Navigator.push(
                            //         //   context,
                            //         //   MaterialPageRoute(
                            //         //       builder: (context) => EditProfileScreen(
                            //         //             previousPage: '',
                            //         //           )),
                            //         // );
                            //       },
                            //       child: Container(
                            //           width: 50,
                            //           height: 25,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(20),
                            //             color: kColorDarkGreyIcon,
                            //             // border: Border.all(
                            //             //     color: kColorDarkGreyText, width: 3),
                            //             // image: DecorationImage(
                            //             //   image: Image.asset("assets/icons/eyeicon.png",),
                            //             //   fit: BoxFit.cover,
                            //             // ),
                            //           ),
                            //           child: Center(
                            //             child: Text(
                            //               '1 of 4',
                            //               style: TextStyle(
                            //                   color: kColorWhite, fontSize: 12),
                            //             ),
                            //           )),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  productDetailsResponse != null
                                      ? productDetailsResponse!
                                          .productDetail.Title
                                      : '',
                                  style: TextStyle(fontSize: 24),
                                ),
                                Text(
                                  stock,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: stock == 'In Stock'
                                          ? kColorPrimary
                                          : kColorOrangeText),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${productDetailsResponse != null ? productDetailsResponse!.productDetail.Category : 'Category'}  ',
                                  style: const TextStyle(
                                      fontSize: 12, color: kColorBlueText),
                                ),
                                Container(
                                  height: 10,
                                  width: 1,
                                  color: kColorFieldsBorders,
                                ),
                                Text(
                                  '  ${productDetailsResponse != null ? productDetailsResponse!.productDetail.SubCategory : 'Subcategory'} ',
                                  style: const TextStyle(
                                      fontSize: 12, color: kColorBlueText),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 55,
                                    height: 27,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: kColorYellow,
                                      // border: Border.all(
                                      //     color: kColorDarkGreyText, width: 3),
                                      // image: DecorationImage(
                                      //   image: Image.asset("assets/icons/eyeicon.png",),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        productDetailsResponse != null
                                            ? Text(
                                                '${productDetailsResponse!.productAverageRatingAndReviews.ProductAverageRating != '' ? productDetailsResponse!.productAverageRatingAndReviews.ProductAverageRating!.substring(0, 3) : 0} ',
                                                style: TextStyle(
                                                    color: kColorWhite,
                                                    fontSize: 14),
                                              )
                                            : SizedBox(),
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: kColorWhite,
                                        )
                                      ],
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '  ${productDetailsResponse != null ? productDetailsResponse!.productAverageRatingAndReviews.TotalRating : 0} Ratings & ${productDetailsResponse != null ? productDetailsResponse!.productAverageRatingAndReviews.TotalReviews : 0} Reviews',
                                  style: const TextStyle(
                                      fontSize: 12, color: kColorDarkGreyText),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 1,
                              width: screenSize.width,
                              color: kColorFieldsBorders,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${currency} ${productPrice}',
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  '& Free Returns',
                                  style: TextStyle(
                                      fontSize: 14, color: kColorFieldsBorders),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.done,
                                  size: 16,
                                  color: kColorPrimary,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Ultrices eros in cursus turpis massa tincidunt cursus.',
                                  style: TextStyle(
                                      fontSize: 12, color: kColorFieldsBorders),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.done,
                                  size: 16,
                                  color: kColorPrimary,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Volutpat ac tincidunt vitae semper quis lectus.',
                                  style: TextStyle(
                                      fontSize: 12, color: kColorFieldsBorders),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.done,
                                  size: 16,
                                  color: kColorPrimary,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Aliquam id diam maecenas ultricies mi eget mauris.',
                                  style: TextStyle(
                                      fontSize: 12, color: kColorFieldsBorders),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Quantity:',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorDarkGreyText
                                              .withOpacity(0.2),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '-',
                                            style: TextStyle(
                                                color: kColorPrimary,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        if (quantity > 1) {
                                          quantity--;
                                          setState(() {});
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      ' ${quantity.toString()} ',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorDarkGreyText
                                              .withOpacity(0.2),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: kColorPrimary,
                                          size: 10,
                                        ),
                                      ),
                                      onTap: () {
                                        if (availableInventory != -1) {
                                          if (quantity < availableInventory) {
                                            quantity++;
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Total Inventory present in store is $availableInventory',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    Colors.grey.shade400,
                                                textColor: Colors.white,
                                                fontSize: 12.0);
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: 'Please select a variant.',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Colors.grey.shade400,
                                              textColor: Colors.white,
                                              fontSize: 12.0);
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: productDetailsResponse == null
                                    ? 0
                                    : productDetailsResponse!
                                        .variantDetails.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${productDetailsResponse!.variantDetails[i].Name}:',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          height: 80,
                                          width: screenSize.width * 0.70,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                productDetailsResponse == null
                                                    ? 0
                                                    : productDetailsResponse!
                                                        .variantDetails[i]
                                                        .values
                                                        .length,
                                            itemBuilder: (context, j) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: productDetailsResponse!
                                                                  .variantDetails[
                                                                      i]
                                                                  .selectedVariant ==
                                                              productDetailsResponse!
                                                                  .variantDetails[
                                                                      i]
                                                                  .values[j]
                                                                  .ProductVariantCombinationID
                                                          ? kColorPrimary
                                                          : kColorFieldsBorders,
                                                      style: BorderStyle.solid,
                                                      width: 2.0,
                                                    ),
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    child: InkWell(
                                                      onTap: () {
                                                        variantPic.clear();
                                                        variantPic.add(
                                                            productDetailsResponse!
                                                                .variantDetails[
                                                                    i]
                                                                .values[j]
                                                                .Large
                                                                .replaceAll(
                                                                    '\\', '/'));
                                                        variantPic.add(
                                                            productDetailsResponse!
                                                                .variantDetails[
                                                                    i]
                                                                .values[j]
                                                                .Medium
                                                                .replaceAll(
                                                                    '\\', '/'));
                                                        variantPic.add(
                                                            productDetailsResponse!
                                                                .variantDetails[
                                                                    i]
                                                                .values[j]
                                                                .Small
                                                                .replaceAll(
                                                                    '\\', '/'));
                                                        productPrice = productPrice -
                                                            productDetailsResponse!
                                                                .variantDetails[
                                                                    i]
                                                                .lastPriceAdded;
                                                        productDetailsResponse!
                                                                .variantDetails[i]
                                                                .lastPriceAdded =
                                                            double.parse(
                                                                productDetailsResponse!
                                                                    .variantDetails[
                                                                        i]
                                                                    .values[j]
                                                                    .VariantPrice);

                                                        productPrice = productPrice +
                                                            double.parse(
                                                                productDetailsResponse!
                                                                    .variantDetails[
                                                                        i]
                                                                    .values[j]
                                                                    .VariantPrice);

                                                        String price =
                                                            productPrice
                                                                .toStringAsFixed(
                                                                    2);
                                                        productPrice =
                                                            double.parse(price);

                                                        if (availableInventory ==
                                                            -1) {
                                                          availableInventory =
                                                              productDetailsResponse!
                                                                  .variantDetails[
                                                                      i]
                                                                  .values[j]
                                                                  .AvailableInventory;
                                                          print(
                                                              '>>>>>>Available Inventory: $availableInventory');
                                                        }
                                                        if (availableInventory >
                                                            productDetailsResponse!
                                                                .variantDetails[
                                                                    i]
                                                                .values[j]
                                                                .AvailableInventory) {
                                                          availableInventory =
                                                              productDetailsResponse!
                                                                  .variantDetails[
                                                                      i]
                                                                  .values[j]
                                                                  .AvailableInventory;
                                                          print(
                                                              '>>>>>>Available Inventory: $availableInventory');
                                                        }
                                                        if (availableInventory >
                                                            0) {
                                                          stock = 'In Stock';
                                                        } else {
                                                          stock =
                                                              'Out of Stock';
                                                        }
                                                        if (quantity >
                                                            availableInventory) {
                                                          quantity =
                                                              availableInventory;
                                                        }
                                                        // productDetailsResponse!
                                                        //         .variantDetails[i]
                                                        //         .selectedVariant =
                                                        //     productDetailsResponse!
                                                        //         .variantDetails[
                                                        //             i]
                                                        //         .values[j]
                                                        //         .ProductVariantCombinationID;

                                                        bool duplicateEntry =
                                                            false;
                                                        if (productDetailsResponse!
                                                                .variantDetails[
                                                                    i]
                                                                .selectedVariant !=
                                                            -1) {
                                                          for (int k = 0;
                                                              k <
                                                                  addToCartModel
                                                                      .productDetail![
                                                                          0]
                                                                      .productVariantCombinationDetail!
                                                                      .length;
                                                              k++) {
                                                            print(
                                                                '>>>>>>>>>>>>>>123');
                                                            print(addToCartModel
                                                                    .productDetail![
                                                                        0]
                                                                    .productVariantCombinationDetail![
                                                                        k]
                                                                    .productVariantCombinationID +
                                                                productDetailsResponse!
                                                                    .variantDetails[
                                                                        i]
                                                                    .values[j]
                                                                    .ProductVariantCombinationID);
                                                            if ((addToCartModel
                                                                        .productDetail![
                                                                            0]
                                                                        .productVariantCombinationDetail![
                                                                            k]
                                                                        .productVariantCombinationID ==
                                                                    productDetailsResponse!
                                                                        .variantDetails[
                                                                            i]
                                                                        .values[
                                                                            j]
                                                                        .ProductVariantCombinationID) ||
                                                                (addToCartModel
                                                                        .productDetail![
                                                                            0]
                                                                        .productVariantCombinationDetail![
                                                                            k]
                                                                        .productVariantCombinationID ==
                                                                    productDetailsResponse!
                                                                        .variantDetails[
                                                                            i]
                                                                        .selectedVariant)) {
                                                              addToCartModel
                                                                      .productDetail![
                                                                          0]
                                                                      .productVariantCombinationDetail![
                                                                          k]
                                                                      .productVariantCombinationID =
                                                                  productDetailsResponse!
                                                                      .variantDetails[
                                                                          i]
                                                                      .values[j]
                                                                      .ProductVariantCombinationID;
                                                              productDetailsResponse!
                                                                      .variantDetails[
                                                                          i]
                                                                      .selectedVariant =
                                                                  productDetailsResponse!
                                                                      .variantDetails[
                                                                          i]
                                                                      .values[j]
                                                                      .ProductVariantCombinationID;
                                                              duplicateEntry =
                                                                  true;
                                                              break;
                                                            }
                                                          }
                                                        }

                                                        if (duplicateEntry ==
                                                            false) {
                                                          productDetailsResponse!
                                                                  .variantDetails[i]
                                                                  .selectedVariant =
                                                              productDetailsResponse!
                                                                  .variantDetails[
                                                                      i]
                                                                  .values[j]
                                                                  .ProductVariantCombinationID;
                                                          addToCartModel
                                                                  .productDetail![0]
                                                                  .productID =
                                                              productDetailsResponse!
                                                                  .productDetail
                                                                  .ProductID;
                                                          addToCartModel
                                                              .productDetail![0]
                                                              .quantity = quantity;
                                                          addToCartModel
                                                              .productDetail![0]
                                                              .productVariantCombinationDetail!
                                                              .add(cart.ProductVariantCombinationDetail(
                                                                  productVariantCombinationID: productDetailsResponse!
                                                                          .variantDetails[
                                                                              i]
                                                                          .selectedVariant =
                                                                      productDetailsResponse!
                                                                          .variantDetails[
                                                                              i]
                                                                          .values[
                                                                              j]
                                                                          .ProductVariantCombinationID));
                                                        }
                                                        print('>>>>>>>>>>>');
                                                        print(addToCartModel
                                                            .toJson());

                                                        setState(() {});
                                                      },
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            width: 40,
                                                            color:
                                                                kColorWidgetBackgroundColor,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: productDetailsResponse !=
                                                                      null
                                                                  ? AppGlobal
                                                                          .photosBaseURL +
                                                                      productDetailsResponse!
                                                                          .variantDetails[
                                                                              i]
                                                                          .values[
                                                                              j]
                                                                          .Medium
                                                                          .replaceAll(
                                                                              '\\',
                                                                              '/')
                                                                  : '',
                                                              progressIndicatorBuilder:
                                                                  (context, url,
                                                                          downloadProgress) =>
                                                                      Center(
                                                                child: CircularProgressIndicator(
                                                                    color:
                                                                        kColorPrimary,
                                                                    value: downloadProgress
                                                                        .progress),
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            productDetailsResponse!
                                                                .variantDetails[
                                                                    i]
                                                                .values[j]
                                                                .VariantValue,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        10),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () {
                                buyNow = false;
                                addToCartModel.productDetail![0].quantity =
                                    quantity;
                                bool everyVariantSelected = true;

                                ///To check that every variant is selected
                                for (int x = 0;
                                    x <
                                        productDetailsResponse!
                                            .variantDetails.length;
                                    x++) {
                                  if (productDetailsResponse!
                                          .variantDetails[x].selectedVariant ==
                                      -1) {
                                    everyVariantSelected = false;
                                    break;
                                  }
                                }
                                if (everyVariantSelected == true) {
                                  if (addToCartModel
                                          .productDetail![0].quantity !=
                                      0) {
                                    print(addToCartModel.toJson());
                                    _productBloc.add(AddToCart(
                                        addToCartModel: addToCartModel,
                                        productDetailsResponse:
                                            productDetailsResponse!,
                                        productPrice: productPrice));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Please select a quantity',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey.shade400,
                                        textColor: Colors.white,
                                        fontSize: 12.0);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Select one from every variant',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey.shade400,
                                      textColor: Colors.white,
                                      fontSize: 12.0);
                                }
                              },
                              child: Container(
                                height: screenSize.height * 0.060,
                                width: screenSize.width * 0.95,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                      Border.all(color: kColorFieldsBorders),
                                  color: kColorWhite,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Add to Cart',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: kColorDarkGreyText,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                buyNow = true;
                                addToCartModel.productDetail![0].quantity =
                                    quantity;
                                bool everyVariantSelected = true;

                                ///To check that every variant is selected
                                for (int x = 0;
                                    x <
                                        productDetailsResponse!
                                            .variantDetails.length;
                                    x++) {
                                  if (productDetailsResponse!
                                          .variantDetails[x].selectedVariant ==
                                      -1) {
                                    everyVariantSelected = false;
                                    break;
                                  }
                                }
                                if (everyVariantSelected == true) {
                                  if (addToCartModel
                                          .productDetail![0].quantity !=
                                      0) {
                                    print(addToCartModel.toJson());
                                    _productBloc.add(AddToCart(
                                        addToCartModel: addToCartModel,
                                        productDetailsResponse:
                                            productDetailsResponse!,
                                        productPrice: productPrice));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Please select a quantity',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey.shade400,
                                        textColor: Colors.white,
                                        fontSize: 12.0);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Select one from every variant',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey.shade400,
                                      textColor: Colors.white,
                                      fontSize: 12.0);
                                }
                              },
                              child: Container(
                                  height: screenSize.height * 0.060,
                                  width: screenSize.width * 0.95,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: kColorPrimary,
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'Buy Now',
                                    style: TextStyle(
                                        color: kColorWhite, fontSize: 18),
                                  ))),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery Options',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  Icons.info_outline,
                                  size: 18,
                                  color: kColorFieldsBorders,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 1,
                              width: screenSize.width,
                              color: kColorFieldsBorders,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  MyFlutterApp.ic_location_on,
                                  size: 18,
                                  color: kColorFieldsBorders,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Shipping Available in: ',
                                  style: TextStyle(
                                      fontSize: 14, color: kColorBlueText),
                                ),
                                allowedCountriesResponse != null
                                    ? Container(
                                        width: screenSize.width * 0.45,
                                        height: 20,
                                        child: ListView.builder(
                                          itemCount: allowedCountriesResponse!
                                                  .countries.isNotEmpty
                                              ? allowedCountriesResponse!
                                                  .countries.length
                                              : 0,
                                          // physics:
                                          //     const NeverScrollableScrollPhysics(),
                                          // shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, i) {
                                            return Text(
                                              allowedCountriesResponse!
                                                      .countries[i].Country +
                                                  '${i != allowedCountriesResponse!.countries.length - 1 ? ', ' : ''} ',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: kColorBlueText),
                                            );
                                          },
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      MyFlutterApp.homeicon,
                                      size: 18,
                                      color: kColorFieldsBorders,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Home Delivery',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '7 - 11 days',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorFieldsBorders),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Text(
                                //   '\$5',
                                //   style: TextStyle(
                                //       fontSize: 18, color: Colors.black),
                                // ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  MyFlutterApp.ic_local_shipping_filled,
                                  size: 18,
                                  color: kColorFieldsBorders,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  'Product Base City : ',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                productDetailsResponse != null
                                    ? Text(
                                        productDetailsResponse!
                                                .productDetail.ProductCity +
                                            ', ' +
                                            productDetailsResponse!
                                                .productDetail.ProductCountry,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 15,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kColorOrangeText,
                                    ),
                                    child: const Icon(
                                      Icons.done,
                                      color: kColorWhite,
                                      size: 10,
                                    )),
                                const SizedBox(
                                  width: 15,
                                ),
                                productDetailsResponse != null
                                    ? Text(
                                        productDetailsResponse!.productDetail
                                                    .AllowStorePickup ==
                                                'Y'
                                            ? 'Store Pickup Available'
                                            : 'Store Pickup Not Available',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Return & Warranty',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 1,
                              width: screenSize.width,
                              color: kColorFieldsBorders,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  MyFlutterApp.truck_border,
                                  size: 18,
                                  color: kColorPrimary,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Free Shipping & Returns',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'For all orders over \$99',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: kColorFieldsBorders),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  MyFlutterApp.secure_payment,
                                  size: 18,
                                  color: kColorPrimary,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Secure Payment',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'We ensure secure payment',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: kColorFieldsBorders),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  MyFlutterApp.money_back,
                                  size: 18,
                                  color: kColorPrimary,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Money Back Guarantee',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Any back within 30 days',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: kColorFieldsBorders),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  MyFlutterApp.customer_support,
                                  size: 18,
                                  color: kColorPrimary,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Customer Support',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Call or email us 24/7',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: kColorFieldsBorders),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Seller: ${productDetailsResponse != null ? productDetailsResponse!.buisnessDetail.CompanyName : 'Vendor'}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (productDetailsResponse != null) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChatPersonalScreen(
                                            senderName: productDetailsResponse!
                                                .buisnessDetail.CompanyName,
                                            senderPic: productDetailsResponse!
                                                .buisnessDetail.CompanyLogo,
                                            receiverUserId:
                                                productDetailsResponse!
                                                    .buisnessDetail.VendorID,
                                            documnetIndex: 0,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(
                                        MyFlutterApp.chat_ic,
                                        size: 16,
                                        color: kColorPrimary,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Chat now',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: kColorDarkGreyText),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 1,
                              width: screenSize.width,
                              color: kColorFieldsBorders,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Seller Rating',
                                  style: TextStyle(
                                      fontSize: 16, color: kColorFieldsBorders),
                                ),
                                Text(
                                  '\%88',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Ship on time',
                                  style: TextStyle(
                                      fontSize: 16, color: kColorFieldsBorders),
                                ),
                                Text(
                                  '\%95',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Chat Response Rate',
                                  style: TextStyle(
                                      fontSize: 16, color: kColorFieldsBorders),
                                ),
                                Text(
                                  '\%97',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StoreScreen(
                                            previousPage: '',
                                            storeName:
                                                productDetailsResponse != null
                                                    ? productDetailsResponse!
                                                        .buisnessDetail
                                                        .CompanyName
                                                    : '',
                                          )),
                                );
                              },
                              child: Container(
                                  height: screenSize.height * 0.060,
                                  width: screenSize.width * 0.95,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: kColorWidgetBackgroundColor,
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'Go to Store',
                                    style: TextStyle(
                                        color: kColorPrimary, fontSize: 18),
                                  ))),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            // Example 5
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      activeTabNo = 1;
                                    });
                                  },
                                  child: Text(
                                    'Description',
                                    style: TextStyle(
                                        color: activeTabNo == 1
                                            ? kColorPrimary
                                            : kColorDarkGreyText,
                                        decoration: activeTabNo == 1
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                        fontSize: 14),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      activeTabNo = 2;
                                    });
                                  },
                                  child: Text(
                                    'Vendor Info',
                                    style: TextStyle(
                                        color: activeTabNo == 2
                                            ? kColorPrimary
                                            : kColorDarkGreyText,
                                        decoration: activeTabNo == 2
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                        fontSize: 14),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      activeTabNo = 3;
                                    });
                                  },
                                  child: Text(
                                    'Reviews',
                                    style: TextStyle(
                                        color: activeTabNo == 3
                                            ? kColorPrimary
                                            : kColorDarkGreyText,
                                        decoration: activeTabNo == 3
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 1,
                              width: screenSize.width,
                              color: kColorFieldsBorders,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Visibility(
                                visible: activeTabNo == 1 ? true : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                        child: Text(
                                          productDetailsResponse != null
                                              ? productDetailsResponse!
                                                  .productDetail.Description
                                              : '',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: kColorDarkGreyText),
                                        ),
                                        alignment: Alignment.centerLeft),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Icon(
                                    //       Icons.done,
                                    //       size: 16,
                                    //       color: kColorPrimary,
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Text(
                                    //       'Ultrices eros in cursus turpis massa tincidunt cursus.',
                                    //       style: const TextStyle(
                                    //           fontSize: 12,
                                    //           color: kColorDarkGreyText),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Icon(
                                    //       Icons.done,
                                    //       size: 16,
                                    //       color: kColorPrimary,
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Text(
                                    //       'Ultrices eros in cursus turpis massa tincidunt cursus.',
                                    //       style: const TextStyle(
                                    //           fontSize: 12,
                                    //           color: kColorDarkGreyText),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Icon(
                                    //       Icons.done,
                                    //       size: 16,
                                    //       color: kColorPrimary,
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Text(
                                    //       'Ultrices eros in cursus turpis massa tincidunt cursus.',
                                    //       style: const TextStyle(
                                    //           fontSize: 12,
                                    //           color: kColorDarkGreyText),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Icon(
                                    //       Icons.done,
                                    //       size: 16,
                                    //       color: kColorPrimary,
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Text(
                                    //       'Ultrices eros in cursus turpis massa tincidunt cursus.',
                                    //       style: const TextStyle(
                                    //           fontSize: 12,
                                    //           color: kColorDarkGreyText),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Icon(
                                    //       Icons.done,
                                    //       size: 16,
                                    //       color: kColorPrimary,
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Text(
                                    //       'Ultrices eros in cursus turpis massa tincidunt cursus.',
                                    //       style: const TextStyle(
                                    //           fontSize: 12,
                                    //           color: kColorDarkGreyText),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 15,
                                    // ),
                                    // Text(
                                    //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt arcu cursus vitae congue mauris. Sagittis id consectetur purus ut.',
                                    //   style: const TextStyle(
                                    //       fontSize: 12,
                                    //       color: kColorDarkGreyText),
                                    // ),
                                  ],
                                )),
                            Visibility(
                                visible: activeTabNo == 2 ? true : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                width: 65,
                                                height: 65,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: kColorDarkGreyText
                                                      .withOpacity(0.2),
                                                  border: Border.all(
                                                      color: kColorOrangeText,
                                                      width: 2),
                                                  // image: DecorationImage(
                                                  //   image: Image.asset("assets/icons/eyeicon.png",),
                                                  //   fit: BoxFit.cover,
                                                  // ),
                                                ),
                                                child: PhotoAvatar(
                                                  photoLink:
                                                      '${AppGlobal.photosBaseURL}${productDetailsResponse != null ? productDetailsResponse!.buisnessDetail.CompanyLogo.replaceAll('\\', '/') : ''}',
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  productDetailsResponse != null
                                                      ? productDetailsResponse!
                                                          .buisnessDetail
                                                          .CompanyName
                                                      : '',
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                RatingBar.builder(
                                                  initialRating: vendorRating,
                                                  ignoreGestures: true,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemSize: 14,
                                                  itemCount: 5,
                                                  //itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      productDetailsResponse !=
                                                              null
                                                          ? productDetailsResponse!
                                                              .buisnessDetail
                                                              .VendorRating
                                                              .substring(0, 3)
                                                          : '0',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '(${productDetailsResponse != null ? productDetailsResponse!.buisnessDetail.TotalVendorReview : '0'} Reviews)',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              kColorFieldsBorders),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StoreScreen(
                                                        previousPage: '',
                                                        storeName: productDetailsResponse !=
                                                                null
                                                            ? productDetailsResponse!
                                                                .buisnessDetail
                                                                .CompanyName
                                                            : '',
                                                      )),
                                            );
                                          },
                                          child: Container(
                                              height: screenSize.height * 0.04,
                                              width: screenSize.width * 0.25,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color:
                                                    kColorWidgetBackgroundColor,
                                              ),
                                              child: const Center(
                                                  child: Text(
                                                'View store',
                                                style: TextStyle(fontSize: 12),
                                              ))),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    const Text(
                                      'Address',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                          ),
                                          child: const Icon(
                                            MyFlutterApp.ic_location_on,
                                            color: kColorPrimary,
                                            size: 10,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          productDetailsResponse != null
                                              ? productDetailsResponse!
                                                  .buisnessDetail.Address1
                                              : '',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: kColorDarkGreyText),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'Phone No',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                          ),
                                          child: const Icon(
                                            Icons.phone,
                                            color: kColorPrimary,
                                            size: 10,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          productDetailsResponse != null
                                              ? productDetailsResponse!
                                                  .buisnessDetail.BusinessPhone
                                              : '',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: kColorDarkGreyText),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'Email Address',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                          ),
                                          child: const Icon(
                                            Icons.email,
                                            color: kColorPrimary,
                                            size: 10,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          productDetailsResponse != null
                                              ? productDetailsResponse!
                                                  .buisnessDetail.BusinessEmail
                                              : '',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: kColorDarkGreyText),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                            Visibility(
                                visible: activeTabNo == 3 ? true : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Customer Reviews',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: productRating,
                                          ignoreGestures: true,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemSize: 16,
                                          itemCount: 5,
                                          //itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Based on ${productDetailsResponse != null ? productDetailsResponse!.productAverageRatingAndReviews.TotalReviews : '0'} reviews',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: kColorDarkGreyText),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          '5 ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                        const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: kColorYellow,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        // Container(
                                        //   width: screenSize.width * .60,
                                        //   height: 8,
                                        //   decoration: BoxDecoration(
                                        //     borderRadius:
                                        //         BorderRadius.circular(20),
                                        //     color: kColorWhite,
                                        //     border: Border.all(
                                        //         color: kColorWhite, width: 1),
                                        //   ),
                                        //   child: LinearProgressIndicator(
                                        //     backgroundColor:
                                        //         kColorWidgetBackgroundColor,
                                        //     valueColor:
                                        //         AlwaysStoppedAnimation<Color>(
                                        //       kColorYellow,
                                        //     ),
                                        //     value: 0.8,
                                        //   ),
                                        // ),
                                        LinearPercentIndicator(
                                          width: screenSize.width * 0.6,
                                          lineHeight: 8.0,
                                          percent: fiveRatingCount / 100,
                                          progressColor: kColorYellow,
                                          backgroundColor:
                                              kColorWidgetBackgroundColor,
                                        ),
                                        const SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          '${fiveRatingCount.round()}%',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          '4 ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                        const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: kColorYellow,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        // Container(
                                        //   width: screenSize.width * .60,
                                        //   height: 8,
                                        //   decoration: BoxDecoration(
                                        //     borderRadius:
                                        //         BorderRadius.circular(20),
                                        //     color: kColorWhite,
                                        //     border: Border.all(
                                        //         color: kColorWhite, width: 1),
                                        //   ),
                                        //   child: LinearProgressIndicator(
                                        //     backgroundColor:
                                        //         kColorWidgetBackgroundColor,
                                        //     valueColor:
                                        //         AlwaysStoppedAnimation<Color>(
                                        //       kColorYellow,
                                        //     ),
                                        //     value: 0.8,
                                        //   ),
                                        // ),
                                        LinearPercentIndicator(
                                          width: screenSize.width * 0.6,
                                          lineHeight: 8.0,
                                          percent: fourRatingCount / 100,
                                          progressColor: kColorYellow,
                                          backgroundColor:
                                              kColorWidgetBackgroundColor,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          '${fourRatingCount.round()}%',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          '3 ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                        const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: kColorYellow,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        // Container(
                                        //   width: screenSize.width * .60,
                                        //   height: 8,
                                        //   decoration: BoxDecoration(
                                        //     borderRadius:
                                        //         BorderRadius.circular(20),
                                        //     color: kColorWhite,
                                        //     border: Border.all(
                                        //         color: kColorWhite, width: 1),
                                        //   ),
                                        //   child: LinearProgressIndicator(
                                        //     backgroundColor:
                                        //         kColorWidgetBackgroundColor,
                                        //     valueColor:
                                        //         AlwaysStoppedAnimation<Color>(
                                        //       kColorYellow,
                                        //     ),
                                        //     value: 0.8,
                                        //   ),
                                        // ),
                                        LinearPercentIndicator(
                                          width: screenSize.width * 0.6,
                                          lineHeight: 8.0,
                                          percent: threeRatingCount / 100,
                                          progressColor: kColorYellow,
                                          backgroundColor:
                                              kColorWidgetBackgroundColor,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          '${threeRatingCount.round()}%',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          '2 ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                        const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: kColorYellow,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        // Container(
                                        //   width: screenSize.width * .60,
                                        //   height: 8,
                                        //   decoration: BoxDecoration(
                                        //     borderRadius:
                                        //         BorderRadius.circular(20),
                                        //     color: kColorWhite,
                                        //     border: Border.all(
                                        //         color: kColorWhite, width: 1),
                                        //   ),
                                        //   child: LinearProgressIndicator(
                                        //     backgroundColor:
                                        //         kColorWidgetBackgroundColor,
                                        //     valueColor:
                                        //         AlwaysStoppedAnimation<Color>(
                                        //       kColorYellow,
                                        //     ),
                                        //     value: 0.8,
                                        //   ),
                                        // ),
                                        LinearPercentIndicator(
                                          width: screenSize.width * 0.6,
                                          lineHeight: 8.0,
                                          percent: twoRatingCount / 100,
                                          progressColor: kColorYellow,
                                          backgroundColor:
                                              kColorWidgetBackgroundColor,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          '${twoRatingCount.round()}%',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          '1 ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                        const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: kColorYellow,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        // Container(
                                        //   width: screenSize.width * .60,
                                        //   height: 8,
                                        //   decoration: BoxDecoration(
                                        //     borderRadius:
                                        //         BorderRadius.circular(20),
                                        //     color: kColorWhite,
                                        //     border: Border.all(
                                        //         color: kColorWhite, width: 1),
                                        //   ),
                                        //   child: LinearProgressIndicator(
                                        //     backgroundColor:
                                        //         kColorWidgetBackgroundColor,
                                        //     valueColor:
                                        //         AlwaysStoppedAnimation<Color>(
                                        //       kColorYellow,
                                        //     ),
                                        //     value: 0.8,
                                        //   ),
                                        // ),
                                        LinearPercentIndicator(
                                          width: screenSize.width * 0.6,
                                          lineHeight: 8.0,
                                          percent: oneRatingCount / 100,
                                          progressColor: kColorYellow,
                                          backgroundColor:
                                              kColorWidgetBackgroundColor,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          '${oneRatingCount.round()}%',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const Text(
                                      'Review this product',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Ultrices eros in cursus turpis massa tincidunt cursus.',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: kColorDarkGreyText),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Your Rating: ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        RatingBar.builder(
                                          initialRating:
                                              reviewStarsInitialValue,
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          // allowHalfRating: true,
                                          itemSize: 18,
                                          itemCount: 5,
                                          //itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                            userProductRating = rating.toInt();
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: screenSize.height * 0.3,
                                      width: screenSize.width,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: kColorWhite,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: TextField(
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          keyboardType: TextInputType.text,
                                          controller: reviewController,
                                          //focusNode: fObservation,
                                          // maxLength: 200,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          // onChanged: (value) {
                                          //   setState(() {
                                          //     //charLength = value.length;
                                          //   });
                                          //   //print('$value,$charLength');
                                          // },
                                          maxLines: 8,
                                          cursorColor: kColorPrimary,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            // hintText: getTranslated(context,
                                            //     'typeherestartdictation'),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    10, 20, 40, 0),
                                            hintText: 'Write your review here',
                                            hintStyle: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade400),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: kColorFieldsBorders,
                                                  width: 1),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: kColorFieldsBorders,
                                                  width: 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          if (userProductRating > 0) {
                                            _productBloc.add(AddUserReview(
                                                productID: widget.productID,
                                                rating: userProductRating,
                                                review: reviewController.text));
                                          }
                                        },
                                        child: Container(
                                            height: screenSize.height * 0.055,
                                            width: screenSize.width * 0.35,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: kColorPrimary,
                                            ),
                                            child: const Center(
                                                child: Text(
                                              'Submit Review',
                                              style: TextStyle(
                                                  color: kColorWhite,
                                                  fontSize: 14),
                                            ))),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 35,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Top Reviews',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Sort by:  ',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Container(
                                              width: screenSize.width * 0.35,
                                              height: 35,
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                border: Border.all(
                                                  width: 1,
                                                  color:
                                                      kColorFieldsBorders, //                   <--- border width here
                                                ),
                                              ),
                                              child: DropdownButton(
                                                hint: Text(
                                                  statusValueChoose,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      color: kColorDarkGreyText,
                                                      fontSize: 12),
                                                ),
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                dropdownColor:
                                                    kColorWidgetBackgroundColor,
                                                icon: const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: kColorDarkGreyIcon,
                                                  size: 15,
                                                ),
                                                iconSize: 36,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                onChanged: (valueItem) {},
                                                items: topReviewList
                                                    .map((valueItem) {
                                                  return DropdownMenuItem(
                                                    child: Text(valueItem),
                                                    value: valueItem,
                                                    onTap: () {
                                                      setState(() {
                                                        statusValueChoose =
                                                            valueItem;
                                                      });
                                                    },
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    ListView.builder(
                                      itemCount: productDetailsResponse != null
                                          ? productDetailsResponse!
                                              .usersProductReviewAndRating
                                              .length
                                          : 0,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        return ProductUserReviewWidget(
                                          screenSize: screenSize,
                                          usersProductReviewAndRating:
                                              productDetailsResponse!
                                                  .usersProductReviewAndRating[i],
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Have a question?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Find answers in product info, Q&As, reviews',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: kColorDarkGreyText),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      //padding: const EdgeInsets.all(10),
                                      height: screenSize.height * 0.06,
                                      child: TextField(
                                        controller: searchController,
                                        decoration: InputDecoration(
                                          floatingLabelStyle: const TextStyle(
                                              color: kColorPrimary),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: kColorFieldsBorders,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                color: kColorPrimary,
                                              )),
                                          prefixIcon: const Icon(
                                            Icons.search,
                                            size: 18,
                                            color: kColorFieldsBorders,
                                          ),
                                          labelStyle: TextStyle(
                                              color: kColorFieldsBorders,
                                              fontSize: 12),
                                          labelText:
                                              'Type your question or keyword',
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height:
                                  widget.homePageApiResponse != null ? 35 : 0,
                            ),
                            widget.homePageApiResponse != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Most Popular Products',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: const Text(
                                          'See all',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: kColorDarkGreyText),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            SizedBox(
                              height:
                                  widget.homePageApiResponse != null ? 15 : 0,
                            ),
                            widget.homePageApiResponse != null
                                ? Container(
                                    width: screenSize.width,
                                    height: screenSize.height * 0.35,
                                    child: ListView.builder(
                                        itemCount:
                                            widget.homePageApiResponse != null
                                                ? widget.homePageApiResponse!
                                                    .mostPopularProducts.length
                                                : 0,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailsScreen(
                                                      previousPage: '',
                                                      productID: widget
                                                          .homePageApiResponse!
                                                          .mostPopularProducts[
                                                              index]
                                                          .ProductID,
                                                      homePageApiResponse: widget
                                                          .homePageApiResponse,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ProductWidget(
                                                screenSize: screenSize,
                                                product: product.Product(
                                                  small: widget
                                                      .homePageApiResponse!
                                                      .mostPopularProducts[
                                                          index]
                                                      .Small,
                                                  currency: widget
                                                      .homePageApiResponse!
                                                      .mostPopularProducts[
                                                          index]
                                                      .Currency,
                                                  productID: widget
                                                      .homePageApiResponse!
                                                      .mostPopularProducts[
                                                          index]
                                                      .ProductID,
                                                  medium: widget
                                                      .homePageApiResponse!
                                                      .mostPopularProducts[
                                                          index]
                                                      .Medium,
                                                  title: widget
                                                      .homePageApiResponse!
                                                      .mostPopularProducts[
                                                          index]
                                                      .Title,
                                                  price: widget
                                                      .homePageApiResponse!
                                                      .mostPopularProducts[
                                                          index]
                                                      .Price,
                                                  large: widget
                                                      .homePageApiResponse!
                                                      .mostPopularProducts[
                                                          index]
                                                      .Large,
                                                ),
                                                avgRating: widget
                                                            .homePageApiResponse!
                                                            .mostPopularProducts[
                                                                index]
                                                            .AVGRating !=
                                                        ''
                                                    ? double.parse(widget
                                                        .homePageApiResponse!
                                                        .mostPopularProducts[
                                                            index]
                                                        .AVGRating!)
                                                    : 0.0,
                                                reviewCount: widget
                                                    .homePageApiResponse!
                                                    .mostPopularProducts[index]
                                                    .REVIEWCOUNT,
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: screenSize.height * 0.05,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                ///This is appbar
                Column(
                  children: [
                    Container(
                      color: kColorWhite,
                      width: screenSize.width,
                      height: screenSize.height * 0.035,
                    ),
                    Container(
                        color: kColorWhite,
                        width: screenSize.width,
                        height: screenSize.height * 0.09,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back,
                                    ),
                                  ),
                                  const Text(
                                    '  Product Details',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  HomePage(
                                                    currentTab: 2,
                                                  )),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorWidgetBackgroundColor,
                                          // border: Border.all(
                                          //     color: kColorDarkGreyText, width: 3),
                                          // image: DecorationImage(
                                          //   image: Image.asset("assets/icons/eyeicon.png",),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        child: const Icon(
                                          MyFlutterApp.carticonlined,
                                          color: kColorDarkGreyText,
                                          size: 15,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => EditProfileScreen(
                                      //             previousPage: '',
                                      //           )),
                                      // );
                                    },
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorWidgetBackgroundColor,
                                          // border: Border.all(
                                          //     color: kColorDarkGreyText, width: 3),
                                          // image: DecorationImage(
                                          //   image: Image.asset("assets/icons/eyeicon.png",),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        child: const Icon(
                                          MyFlutterApp.share,
                                          color: kColorDarkGreyText,
                                          size: 15,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => EditProfileScreen(
                                      //             previousPage: '',
                                      //           )),
                                      // );
                                    },
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kColorWidgetBackgroundColor,
                                          // border: Border.all(
                                          //     color: kColorDarkGreyText, width: 3),
                                          // image: DecorationImage(
                                          //   image: Image.asset("assets/icons/eyeicon.png",),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        child: const Icon(
                                          MyFlutterApp
                                              .icon_menu_point_v_outline,
                                          color: kColorDarkGreyText,
                                          size: 15,
                                        )),
                                  ),
                                ],
                              )
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

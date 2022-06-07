import 'package:bangla_bazar/ModelClasses/categories_subcategories_response.dart';
import 'package:bangla_bazar/ModelClasses/home_page_api_reponse.dart';
import 'package:bangla_bazar/ModelClasses/store_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Utils/user_click_local_db.dart';
import 'package:bangla_bazar/Views/Product/ProductBloc/product_bloc.dart';
import 'package:bangla_bazar/Views/Product/recently_viewed_products_screen.dart';
import 'package:bangla_bazar/Views/Product/product_details_screen.dart';
import 'package:bangla_bazar/Views/Product/search_screen.dart';
import 'package:bangla_bazar/Views/Product/sub_category_screen.dart';
import 'package:bangla_bazar/Views/Product/top_rated_product_screen.dart';
import 'package:bangla_bazar/Views/Product/trending_for_you_screen.dart';
import 'package:bangla_bazar/Views/main_home_page.dart';
import 'package:bangla_bazar/Widgets/product_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:bangla_bazar/Utils/add_to_cart_local_db.dart' as localDB;
import 'package:bangla_bazar/ModelClasses/add_to_cart_model.dart' as cart;
import 'package:bangla_bazar/ModelClasses/product_details_response.dart'
    as productDetails;

class HomeBody extends StatefulWidget {
  //static const String id = 'chatscreen';
  //GlobalKey<ScaffoldState> parentScaffoldKey;

  const HomeBody({
    Key? key,
  }) : super(key: key);
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late ProductBloc _productBloc;
  TextEditingController searchController = TextEditingController();
  HomePageApiResponse? homePageApiResponse;
  CategoriesAndSubcategoriesResponse? categoriesAndSubcategoriesResponse;
  localDB.RequestUserCartProducts? requestUserCartProducts;
  localDB.RequestUserCartProductsCombinations?
      requestUserCartProductsCombinations;

  late cart.AddToCartModel addToCartModel = cart.AddToCartModel();
  productDetails.ProductDetailsResponse? productDetailsResponse;

  int _current = 0;

  List<String> statusList = ['Bangladesh', 'United States'];
  late String statusValueChoose;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    //statusValueChoose = AppGlobal.region;
    if (AppGlobal.userID != -1) {
      _productBloc.add(GetLocalUserProductsClickData());
      _productBloc.add(GetLocalCartDetails());
      if (AppGlobal.token != '') {
        addToCartModel.sessionID = AppGlobal.token;
      }
      _productBloc.add(GetCartDetails());
    }
    getDeviceIP();
    _productBloc.add(GetGeoLocation());
    _productBloc.add(GetCategories());
  }

  Future<void> getDeviceIP() async {
    var wifiIP = await WifiInfo().getWifiIP();
    if (wifiIP != null) {
      AppGlobal.ipAddress = wifiIP;
      print('>>>>>>>Device IP Address: ${AppGlobal.ipAddress}');
    }
  }

  RequestUserProductClicksData? localUserClicksResponse;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is GetLocalUserProductsClickDataState) {
        localUserClicksResponse = state.localUserClicksResponse;
        for (int i = 0;
            i < localUserClicksResponse!.userProductClickData!.length;
            i++) {
          _productBloc.add(AddClickToAProduct(
              id: localUserClicksResponse!.userProductClickData![i].productID!,
              uniqueNumber: localUserClicksResponse!
                  .userProductClickData![i].uniqueNumber));
        }
        // print('>>>>>>>>>>>User Clicks: ');
        // print(localUserClicksResponse!.userProductClickData![1].productID);
      } else if (state is ClickAddedToProduct) {
      } else if (state is ErrorState) {
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
      } else if (state is GeoLocationData) {
        print('>>>>>>>> Country: ${AppGlobal.currentCountry}');

        _productBloc.add(GetHomePageProducts(
            country: AppGlobal.currentCountry == ''
                ? 'Bangladesh'
                : AppGlobal.currentCountry,
            id: AppGlobal.userID));
      } else if (state is HomePageProductsFetched) {
        homePageApiResponse = state.homePageApiResponse;
      } else if (state is CategoriesData) {
        categoriesAndSubcategoriesResponse =
            state.categoriesAndSubcategoriesResponse;
      } else if (state is CartDetailsLocalDBState) {
        requestUserCartProducts = state.requestUserCartProducts;
        print(requestUserCartProducts!.cartProducts!.length);
        _productBloc.add(GetLocalCartCombinationDetails());
      } else if (state is CartCombinationDetailsLocalDBState) {
        requestUserCartProductsCombinations =
            state.requestUserCartProductsCombinations;
        ('Local DB Combinations');
        print(requestUserCartProductsCombinations!
            .cartProductsCombinations!.length);
        addToCartModel =
            cart.AddToCartModel(sessionID: AppGlobal.token, productDetail: []);
        for (int i = 0;
            i < requestUserCartProducts!.cartProducts!.length;
            i++) {
          addToCartModel.productDetail!.add(cart.ProductDetail(
              productID: requestUserCartProducts!.cartProducts![i].ProductID,
              quantity: int.parse(
                  requestUserCartProducts!.cartProducts![i].TotalQuantity!),
              productVariantCombinationDetail: []));
          for (int j = 0;
              j <
                  requestUserCartProductsCombinations!
                      .cartProductsCombinations!.length;
              j++) {
            if (requestUserCartProductsCombinations!
                    .cartProductsCombinations![j].uniqueNumber ==
                requestUserCartProducts!.cartProducts![i].uniqueNumber) {
              addToCartModel.productDetail![i].productVariantCombinationDetail!
                  .add(cart.ProductVariantCombinationDetail(
                      productVariantCombinationID:
                          requestUserCartProductsCombinations!
                              .cartProductsCombinations![j]
                              .ProductVariantCombinationID));
            }
          }
        }
        if (addToCartModel.productDetail!.isNotEmpty) {
          _productBloc
              .add(AddToCart(addToCartModel: addToCartModel, productPrice: 0));
        }
      } else if (state is AddedToCart) {
      } else if (state is CartDetailsState) {
        AppGlobal.cartDetailsResponseGlobal = state.cartDetailsResponse;
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  // color: Colors.red,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          // color: Colors.yellow,
                          width: screenSize.width,
                          height: screenSize.height * 0.13,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen()),
                            );
                          },
                          child: Container(
                            width: screenSize.width,
                            height: screenSize.height * 0.065,
                            decoration: const BoxDecoration(
                              color: kColorWidgetBackgroundColor,
                              // border: Border.all(
                              //     color: kColorWidgetBackgroundColor, // Set border color
                              //     width: 0.0),   // Set border width
                              borderRadius: BorderRadius.all(Radius.circular(
                                  35.0)), // Set rounded corner radius
                              // Make rounded corner of border
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.search,
                                    color: kColorDarkGreyIcon,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'Search for anything',
                                    style: TextStyle(
                                        color: kColorFieldsBorders,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: screenSize.width,
                          height: screenSize.height * 0.065,
                          child: ListView.builder(
                              itemCount:
                                  categoriesAndSubcategoriesResponse == null
                                      ? 0
                                      : categoriesAndSubcategoriesResponse!
                                          .categoriesAndSubCategories.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubCategoriesScreen(
                                                  categoriesAndSubcategoriesResponse:
                                                      categoriesAndSubcategoriesResponse!,
                                                  selectedCategoryId:
                                                      categoriesAndSubcategoriesResponse!
                                                          .categoriesAndSubCategories[
                                                              index]
                                                          .categoryDetails
                                                          .CategoryID,
                                                  subCategories:
                                                      categoriesAndSubcategoriesResponse!
                                                          .categoriesAndSubCategories[
                                                              index]
                                                          .subCategoryDetails,
                                                  appBarTitle:
                                                      categoriesAndSubcategoriesResponse!
                                                          .categoriesAndSubCategories[
                                                              index]
                                                          .categoryDetails
                                                          .Category,
                                                )),
                                      );
                                    },
                                    child: Container(
                                      height: screenSize.height * 0.05,
                                      // width: screenSize.width * 0.33,
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
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 15,
                                              child: CachedNetworkImage(
                                                imageUrl: AppGlobal
                                                        .photosBaseURL +
                                                    categoriesAndSubcategoriesResponse!
                                                        .categoriesAndSubCategories[
                                                            index]
                                                        .categoryDetails
                                                        .CategoryPic
                                                        .replaceAll('\\', '/'),
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                  Icons.error,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              categoriesAndSubcategoriesResponse ==
                                                      null
                                                  ? ''
                                                  : categoriesAndSubcategoriesResponse!
                                                      .categoriesAndSubCategories[
                                                          index]
                                                      .categoryDetails
                                                      .Category,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        homePageApiResponse != null
                            ? homePageApiResponse!
                                    .recentlyViewedProducts.isNotEmpty
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Recently Viewed Items',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiProductsScreen(
                                                previousPage:
                                                    'Recently Viewed Items',
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'See all',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: kColorDarkGreyText),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                        homePageApiResponse != null
                            ? homePageApiResponse!
                                    .recentlyViewedProducts.isNotEmpty
                                ? const SizedBox(
                                    height: 15,
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                        homePageApiResponse != null
                            ? homePageApiResponse!
                                    .recentlyViewedProducts.isNotEmpty
                                ? Container(
                                    width: screenSize.width,
                                    height: screenSize.height * 0.35,
                                    child: ListView.builder(
                                        itemCount: homePageApiResponse != null
                                            ? homePageApiResponse!
                                                .recentlyViewedProducts.length
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
                                                            productID:
                                                                homePageApiResponse!
                                                                    .recentlyViewedProducts[
                                                                        index]
                                                                    .ProductID,
                                                            homePageApiResponse:
                                                                homePageApiResponse,
                                                          )),
                                                );
                                              },
                                              child: ProductWidget(
                                                screenSize: screenSize,
                                                product: Product(
                                                  small: homePageApiResponse!
                                                      .recentlyViewedProducts[
                                                          index]
                                                      .Small,
                                                  currency: homePageApiResponse!
                                                      .recentlyViewedProducts[
                                                          index]
                                                      .Currency,
                                                  productID: homePageApiResponse!
                                                      .recentlyViewedProducts[
                                                          index]
                                                      .ProductID,
                                                  medium: homePageApiResponse!
                                                      .recentlyViewedProducts[
                                                          index]
                                                      .Medium,
                                                  title: homePageApiResponse!
                                                      .recentlyViewedProducts[
                                                          index]
                                                      .Title,
                                                  price: homePageApiResponse!
                                                      .recentlyViewedProducts[
                                                          index]
                                                      .Price,
                                                  large: homePageApiResponse!
                                                      .recentlyViewedProducts[
                                                          index]
                                                      .Large,
                                                ),
                                                avgRating: homePageApiResponse!
                                                            .recentlyViewedProducts[
                                                                index]
                                                            .AVGRATING !=
                                                        ''
                                                    ? double.parse(
                                                        homePageApiResponse!
                                                            .recentlyViewedProducts[
                                                                index]
                                                            .AVGRATING!)
                                                    : 0.0,
                                                reviewCount:
                                                    homePageApiResponse!
                                                        .recentlyViewedProducts[
                                                            index]
                                                        .REVIEWCOUNT,
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                : const SizedBox()
                            : const SizedBox(),

                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Most Popular Products',
                              style: TextStyle(fontSize: 18),
                            ),
                            homePageApiResponse != null
                                ? homePageApiResponse!
                                        .mostPopularProducts.isNotEmpty
                                    ? InkWell(
                                        onTap: () {},
                                        child: const Text(
                                          'See all',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: kColorDarkGreyText),
                                        ),
                                      )
                                    : const SizedBox()
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: screenSize.width,
                          height: screenSize.height * 0.35,
                          child: homePageApiResponse != null
                              ? homePageApiResponse!
                                      .mostPopularProducts.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: homePageApiResponse != null
                                          ? homePageApiResponse!
                                              .mostPopularProducts.length
                                          : 0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailsScreen(
                                                          previousPage: '',
                                                          productID:
                                                              homePageApiResponse!
                                                                  .mostPopularProducts[
                                                                      index]
                                                                  .ProductID,
                                                          homePageApiResponse:
                                                              homePageApiResponse,
                                                        )),
                                              );
                                            },
                                            child: ProductWidget(
                                              screenSize: screenSize,
                                              product: Product(
                                                small: homePageApiResponse!
                                                    .mostPopularProducts[index]
                                                    .Small,
                                                currency: homePageApiResponse!
                                                    .mostPopularProducts[index]
                                                    .Currency,
                                                productID: homePageApiResponse!
                                                    .mostPopularProducts[index]
                                                    .ProductID,
                                                medium: homePageApiResponse!
                                                    .mostPopularProducts[index]
                                                    .Medium,
                                                title: homePageApiResponse!
                                                    .mostPopularProducts[index]
                                                    .Title,
                                                price: homePageApiResponse!
                                                    .mostPopularProducts[index]
                                                    .Price,
                                                large: homePageApiResponse!
                                                    .mostPopularProducts[index]
                                                    .Large,
                                              ),
                                              avgRating: homePageApiResponse!
                                                          .mostPopularProducts[
                                                              index]
                                                          .AVGRating !=
                                                      ''
                                                  ? double.parse(
                                                      homePageApiResponse!
                                                          .mostPopularProducts[
                                                              index]
                                                          .AVGRating!)
                                                  : 0.0,
                                              reviewCount: homePageApiResponse!
                                                  .mostPopularProducts[index]
                                                  .REVIEWCOUNT,
                                            ),
                                          ),
                                        );
                                      })
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/no_products.png',
                                          scale: 4,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'No Product in Most Popular',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ],
                                    )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/no_products.png',
                                      scale: 4,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Products',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ],
                                ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        ///Api is not provided yet
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text(
                        //       'Deals Of The Day',
                        //       style: TextStyle(fontSize: 18),
                        //     ),
                        //     InkWell(
                        //       onTap: () {},
                        //       child: const Text(
                        //         'See all',
                        //         style: TextStyle(
                        //             fontSize: 12, color: kColorDarkGreyText),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // Container(
                        //   width: screenSize.width,
                        //   height: screenSize.height * 0.3,
                        //   child: ListView.builder(
                        //       itemCount: 5,
                        //       scrollDirection: Axis.horizontal,
                        //       itemBuilder: (BuildContext context, int index) {
                        //         return Padding(
                        //           padding: const EdgeInsets.only(right: 10),
                        //           child: InkWell(
                        //             onTap: () {},
                        //             child: ProductWidget(
                        //               screenSize: screenSize,
                        //               product: Product(
                        //                   small: '',
                        //                   currency: '',
                        //                   productID: 12,
                        //                   medium: '',
                        //                   title: '',
                        //                   price: '',
                        //                   large: ''),
                        //               avgRating: 5,
                        //               reviewCount: 0,
                        //             ),
                        //           ),
                        //         );
                        //       }),
                        // ),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                        Container(
                          width: screenSize.width,
                          height: screenSize.height * 0.17,
                          child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: screenSize.height * 0.17,
                                      width: screenSize.width,
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Explore by Categories',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              width: screenSize.width,
                              height: screenSize.height * 0.5,
                              child: GridView.builder(
                                itemCount:
                                    categoriesAndSubcategoriesResponse == null
                                        ? 0
                                        : categoriesAndSubcategoriesResponse!
                                            .categoriesAndSubCategories.length,
                                shrinkWrap: true,
                                //physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 80 / 50,
                                        crossAxisSpacing: 5,
                                        crossAxisCount: 2),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubCategoriesScreen(
                                                  categoriesAndSubcategoriesResponse:
                                                      categoriesAndSubcategoriesResponse!,
                                                  selectedCategoryId:
                                                      categoriesAndSubcategoriesResponse!
                                                          .categoriesAndSubCategories[
                                                              index]
                                                          .categoryDetails
                                                          .CategoryID,
                                                  subCategories:
                                                      categoriesAndSubcategoriesResponse!
                                                          .categoriesAndSubCategories[
                                                              index]
                                                          .subCategoryDetails,
                                                  appBarTitle:
                                                      categoriesAndSubcategoriesResponse!
                                                          .categoriesAndSubCategories[
                                                              index]
                                                          .categoryDetails
                                                          .Category,
                                                )),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 85,
                                          height: 85,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kColorDarkGreyText
                                                .withOpacity(0.2),
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 55,
                                              height: 55,
                                              child: CachedNetworkImage(
                                                imageUrl: AppGlobal
                                                        .photosBaseURL +
                                                    categoriesAndSubcategoriesResponse!
                                                        .categoriesAndSubCategories[
                                                            index]
                                                        .categoryDetails
                                                        .CategoryPic
                                                        .replaceAll('\\', '/'),
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          categoriesAndSubcategoriesResponse ==
                                                  null
                                              ? ''
                                              : categoriesAndSubcategoriesResponse!
                                                  .categoriesAndSubCategories[
                                                      index]
                                                  .categoryDetails
                                                  .Category,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            // categoriesAndSubcategoriesResponse != null
                            //     ? Container(
                            //         child: SingleChildScrollView(
                            //           scrollDirection: Axis.horizontal,
                            //           child: Container(
                            //             width: screenSize.width * 0.4,
                            //             child: Center(
                            //               child: DotsIndicator(
                            //                   dotsCount:
                            //                       categoriesAndSubcategoriesResponse!
                            //                           .categoriesAndSubCategories
                            //                           .length,
                            //                   position: _current.toDouble(),
                            //                   decorator: const DotsDecorator(
                            //                     spacing: EdgeInsets.all(6.0),
                            //                     activeColor: kColorPrimary,
                            //                   )),
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: screenSize.width,
                          height: screenSize.height * 0.17,
                          child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: screenSize.height * 0.17,
                                      width: screenSize.width,
                                      decoration: const BoxDecoration(
                                        color: kColorWidgetBackgroundColor,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Top Rated Products',
                              style: TextStyle(fontSize: 18),
                            ),
                            homePageApiResponse != null
                                ? homePageApiResponse!
                                        .topRatedProducts.isNotEmpty
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const TopRatedProductScreen(
                                                previousPage:
                                                    'Top Rated Products',
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'See all',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: kColorDarkGreyText),
                                        ),
                                      )
                                    : const SizedBox()
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: screenSize.width,
                          height: screenSize.height * 0.35,
                          child: homePageApiResponse != null
                              ? homePageApiResponse!.topRatedProducts.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: homePageApiResponse != null
                                          ? homePageApiResponse!
                                              .topRatedProducts.length
                                          : 0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailsScreen(
                                                          previousPage: '',
                                                          productID:
                                                              homePageApiResponse!
                                                                  .topRatedProducts[
                                                                      index]
                                                                  .ProductID,
                                                          homePageApiResponse:
                                                              homePageApiResponse,
                                                        )),
                                              );
                                            },
                                            child: ProductWidget(
                                              screenSize: screenSize,
                                              product: Product(
                                                small: homePageApiResponse!
                                                    .topRatedProducts[index]
                                                    .Small,
                                                currency: homePageApiResponse!
                                                    .topRatedProducts[index]
                                                    .Currency,
                                                productID: homePageApiResponse!
                                                    .topRatedProducts[index]
                                                    .ProductID,
                                                medium: homePageApiResponse!
                                                    .topRatedProducts[index]
                                                    .Medium,
                                                title: homePageApiResponse!
                                                    .topRatedProducts[index]
                                                    .Title,
                                                price: homePageApiResponse!
                                                    .topRatedProducts[index]
                                                    .Price,
                                                large: homePageApiResponse!
                                                    .topRatedProducts[index]
                                                    .Large,
                                              ),
                                              avgRating: homePageApiResponse!
                                                          .topRatedProducts[
                                                              index]
                                                          .AVGRATING !=
                                                      ''
                                                  ? double.parse(
                                                      homePageApiResponse!
                                                          .topRatedProducts[
                                                              index]
                                                          .AVGRATING!)
                                                  : 0.0,
                                              reviewCount: homePageApiResponse!
                                                  .topRatedProducts[index]
                                                  .ReviewCount,
                                            ),
                                          ),
                                        );
                                      })
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/no_products.png',
                                          scale: 4,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'No Product in Top Rated',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ],
                                    )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/no_products.png',
                                      scale: 4,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Products',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ],
                                ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Trending for you',
                              style: TextStyle(fontSize: 18),
                            ),
                            homePageApiResponse != null
                                ? homePageApiResponse!
                                        .trendingForYouProducts.isNotEmpty
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const TrendingForYouScreen(
                                                previousPage:
                                                    'Trending for you',
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'See all',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: kColorDarkGreyText),
                                        ),
                                      )
                                    : const SizedBox()
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: screenSize.width,
                          height: screenSize.height * 0.35,
                          child: homePageApiResponse != null
                              ? homePageApiResponse!
                                      .trendingForYouProducts.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: homePageApiResponse != null
                                          ? homePageApiResponse!
                                              .trendingForYouProducts.length
                                          : 0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailsScreen(
                                                          previousPage: '',
                                                          productID:
                                                              homePageApiResponse!
                                                                  .trendingForYouProducts[
                                                                      index]
                                                                  .ProductID,
                                                          homePageApiResponse:
                                                              homePageApiResponse,
                                                        )),
                                              );
                                            },
                                            child: ProductWidget(
                                              screenSize: screenSize,
                                              product: Product(
                                                small: homePageApiResponse!
                                                    .trendingForYouProducts[
                                                        index]
                                                    .Small,
                                                currency: homePageApiResponse!
                                                    .trendingForYouProducts[
                                                        index]
                                                    .Currency,
                                                productID: homePageApiResponse!
                                                    .trendingForYouProducts[
                                                        index]
                                                    .ProductID,
                                                medium: homePageApiResponse!
                                                    .trendingForYouProducts[
                                                        index]
                                                    .Medium,
                                                title: homePageApiResponse!
                                                    .trendingForYouProducts[
                                                        index]
                                                    .Title,
                                                price: homePageApiResponse!
                                                    .trendingForYouProducts[
                                                        index]
                                                    .Price,
                                                large: homePageApiResponse!
                                                    .trendingForYouProducts[
                                                        index]
                                                    .Large,
                                              ),
                                              avgRating: homePageApiResponse!
                                                          .trendingForYouProducts[
                                                              index]
                                                          .AVGRating !=
                                                      ''
                                                  ? double.parse(
                                                      homePageApiResponse!
                                                          .trendingForYouProducts[
                                                              index]
                                                          .AVGRating)
                                                  : 0.0,
                                              reviewCount: homePageApiResponse!
                                                  .trendingForYouProducts[index]
                                                  .REVIEWCOUNT,
                                            ),
                                          ),
                                        );
                                      })
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/no_products.png',
                                          scale: 4,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'No Product in Trending for you',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ],
                                    )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/no_products.png',
                                      scale: 4,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Products',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///AppBar below
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
                            Row(
                              children: [
                                Container(
                                    width: 105,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15)),
                                      color:
                                          kColorDarkGreyText.withOpacity(0.2),
                                      // border: Border.all(
                                      //     color: kColorDarkGreyText, width: 3),
                                      // image: DecorationImage(
                                      //   image: Image.asset("assets/icons/eyeicon.png",),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: DropdownButton(
                                          hint: Text(
                                            AppGlobal.region,
                                            style: const TextStyle(
                                              color: kColorDarkGreyText,
                                            ),
                                          ),
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          dropdownColor:
                                              kColorWidgetBackgroundColor,
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: kColorDarkGreyIcon,
                                            size: 20,
                                          ),
                                          iconSize: 20,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                          onChanged: (valueItem) {},
                                          items: statusList.map((valueItem) {
                                            return DropdownMenuItem(
                                              child: Text(valueItem),
                                              value: valueItem,
                                              onTap: () {
                                                setState(() {
                                                  AppGlobal.region = valueItem;
                                                  _productBloc.add(
                                                      GetHomePageProducts(
                                                          country: AppGlobal
                                                                      .currentCountry ==
                                                                  ''
                                                              ? 'Bangladesh'
                                                              : AppGlobal
                                                                  .currentCountry,
                                                          id: AppGlobal
                                                              .userID));
                                                });
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage(
                                                  currentTab: 3,
                                                )),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            kColorDarkGreyText.withOpacity(0.2),
                                        // border: Border.all(
                                        //     color: kColorDarkGreyText, width: 3),
                                        // image: DecorationImage(
                                        //   image: Image.asset("assets/icons/eyeicon.png",),
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: AppGlobal.photosBaseURL +
                                            AppGlobal.profilePic,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              color: kColorPrimary,
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          MyFlutterApp.account_border,
                                          color: kColorDarkGreyIcon,
                                          size: 18,
                                        ),
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
          ),
        ),
      );
    });
  }
}

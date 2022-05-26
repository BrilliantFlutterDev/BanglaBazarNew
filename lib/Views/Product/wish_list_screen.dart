import 'package:bangla_bazar/ModelClasses/recently_viewed_reponse.dart';
import 'package:bangla_bazar/ModelClasses/store_response.dart';
import 'package:bangla_bazar/ModelClasses/wish_list_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';

import 'package:bangla_bazar/Views/Product/ProductBloc/product_bloc.dart';
import 'package:bangla_bazar/Views/Product/product_details_screen.dart';
import 'package:bangla_bazar/Views/Product/search_screen.dart';
import 'package:bangla_bazar/Views/main_home_page.dart';

import 'package:bangla_bazar/Widgets/product_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';

class WishListScreen extends StatefulWidget {
  final String previousPage;

  const WishListScreen({
    Key? key,
    required this.previousPage,
  }) : super(key: key);
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late ProductBloc _productBloc;

  late String statusValueChoose;

  WishListResponse? wishListResponse;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    statusValueChoose = '';
    _productBloc.add(GetWishList());
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
      if (state is LoadingState) {
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
      } else if (state is WishListDataFetched) {
        wishListResponse = state.wishListResponse;
      } else if (state is AddedInWishList) {
        _productBloc.add(GetWishList());
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ///
                                const Text(
                                  'Results',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '  ( ${wishListResponse != null ? wishListResponse!.userWishList.length : '0'} )',
                                  style: const TextStyle(
                                      fontSize: 12, color: kColorDarkGreyText),
                                ),
                              ],
                            ),
                            wishListResponse != null
                                ? wishListResponse!.userWishList.isNotEmpty
                                    ? GridView.builder(
                                        itemCount: wishListResponse == null
                                            ? 0
                                            : wishListResponse!
                                                .userWishList.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 78 / 120,
                                                crossAxisCount: 2),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailsScreen(
                                                          previousPage: '',
                                                          productID:
                                                              wishListResponse!
                                                                  .userWishList[
                                                                      index]
                                                                  .ProductID,
                                                        )),
                                              );
                                            },
                                            child: ProductWidget(
                                              screenSize: screenSize,
                                              product: wishListResponse == null
                                                  ? Product(
                                                      small: '',
                                                      currency: '',
                                                      productID: 12,
                                                      medium: '',
                                                      title: '',
                                                      price: '',
                                                      large: '')
                                                  : Product(
                                                      small: wishListResponse!
                                                          .userWishList[index]
                                                          .Large,
                                                      currency:
                                                          wishListResponse!
                                                              .userWishList[
                                                                  index]
                                                              .Currency,
                                                      productID:
                                                          wishListResponse!
                                                              .userWishList[
                                                                  index]
                                                              .ProductID,
                                                      medium: wishListResponse!
                                                          .userWishList[index]
                                                          .Medium,
                                                      title: wishListResponse!
                                                          .userWishList[index]
                                                          .Title,
                                                      price: wishListResponse!
                                                          .userWishList[index]
                                                          .Price,
                                                      large: wishListResponse!
                                                          .userWishList[index]
                                                          .Large),
                                              avgRating: wishListResponse ==
                                                      null
                                                  ? 0
                                                  : double.parse(
                                                      wishListResponse!
                                                          .userWishList[index]
                                                          .AVGRATING!),
                                              reviewCount:
                                                  wishListResponse == null
                                                      ? 0
                                                      : wishListResponse!
                                                          .userWishList[index]
                                                          .REVIEWCOUNT,
                                              inWishList: 'true',
                                              onDislikePress: () {
                                                _productBloc.add(
                                                    RemoveFromWishList(
                                                        productId:
                                                            wishListResponse!
                                                                .userWishList[
                                                                    index]
                                                                .ProductID));
                                              },
                                            ),
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/no_order.png',
                                              scale: 4,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              'No item in wishlist',
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
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    HomePage()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              },
                                              child: Container(
                                                height:
                                                    screenSize.height * 0.05,
                                                width: screenSize.width * 0.43,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: kColorPrimary,
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'Add in Wishlist',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: kColorWhite,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                : Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/no_order.png',
                                          scale: 4,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'Orders',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Container(
                        height: screenSize.height * 0.1,
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
                                  Text(
                                    '  ${widget.previousPage}',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SearchScreen()),
                                      );
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
                                          Icons.search,
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

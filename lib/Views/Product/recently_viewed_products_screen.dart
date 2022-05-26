import 'package:bangla_bazar/ModelClasses/recently_viewed_reponse.dart';
import 'package:bangla_bazar/ModelClasses/store_response.dart';
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

class MultiProductsScreen extends StatefulWidget {
  final String previousPage;

  const MultiProductsScreen({
    Key? key,
    required this.previousPage,
  }) : super(key: key);
  @override
  _MultiProductsScreenState createState() => _MultiProductsScreenState();
}

class _MultiProductsScreenState extends State<MultiProductsScreen> {
  late ProductBloc _productBloc;
  int activeTabNo = 1;
  TextEditingController reviewController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<String> topReviewList = ['Top Reviews', 'Best Reviews'];
  late String statusValueChoose;
  RecentlyViewedItemsResponse? recentlyViewedItemsResponse;
  List<RecentlyViewedProducts>? recentlyViewedProducts = [];

  final _scrollController = ScrollController();

  int offset = 0;
  int totalPages = 0;

  bool loadingNextPage = false;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    statusValueChoose = '';
    _productBloc.add(GetRecentlyViewedItems(offset: 0));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (offset < totalPages - 1) {
          offset++;
          loadingNextPage = true;
          _productBloc.add(GetRecentlyViewedItems(offset: offset));
          print('Load Next Page');
        }
      }
    });
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
      } else if (state is RecentlyViewedItemsDataFetched) {
        if (loadingNextPage == false) {
          recentlyViewedProducts!.clear();
          recentlyViewedItemsResponse = state.recentlyViewedItemsResponse;
          totalPages = (recentlyViewedItemsResponse!.totalRecords / 10).ceil();
          recentlyViewedProducts!
              .addAll(recentlyViewedItemsResponse!.recentlyViewedProducts);
          print('Total Pages: $totalPages');
        } else {
          recentlyViewedProducts!
              .addAll(state.recentlyViewedItemsResponse.recentlyViewedProducts);
          print('>>>>>>>');
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
                ///This is the body
                SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
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
                                  '  ( ${recentlyViewedItemsResponse != null ? recentlyViewedProducts!.length : '0'} )',
                                  style: const TextStyle(
                                      fontSize: 12, color: kColorDarkGreyText),
                                ),
                              ],
                            ),
                            GridView.builder(
                              itemCount: recentlyViewedItemsResponse == null
                                  ? 0
                                  : recentlyViewedProducts!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 78 / 120,
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsScreen(
                                                previousPage: '',
                                                productID:
                                                    recentlyViewedProducts![
                                                            index]
                                                        .ProductID,
                                              )),
                                    );
                                  },
                                  child: ProductWidget(
                                    screenSize: screenSize,
                                    product: recentlyViewedItemsResponse == null
                                        ? Product(
                                            small: '',
                                            currency: '',
                                            productID: 12,
                                            medium: '',
                                            title: '',
                                            price: '',
                                            large: '')
                                        : Product(
                                            small: recentlyViewedProducts![
                                                    index]
                                                .Large,
                                            currency: recentlyViewedProducts![
                                                    index]
                                                .Currency,
                                            productID: recentlyViewedProducts![
                                                    index]
                                                .ProductID,
                                            medium:
                                                recentlyViewedProducts![index]
                                                    .Medium,
                                            title:
                                                recentlyViewedProducts![index]
                                                    .Title,
                                            price:
                                                recentlyViewedProducts![index]
                                                    .Price,
                                            large:
                                                recentlyViewedProducts![index]
                                                    .Large),
                                    avgRating:
                                        recentlyViewedItemsResponse == null
                                            ? 0
                                            : double.parse(
                                                recentlyViewedProducts![index]
                                                    .AVGRATING),
                                    reviewCount:
                                        recentlyViewedItemsResponse == null
                                            ? 0
                                            : recentlyViewedProducts![index]
                                                .REVIEWCOUNT,
                                  ),
                                );
                              },
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
                                      size: 22,
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
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => EditProfileScreen(
                                      //             previousPage: '',
                                      //           )),
                                      // );
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

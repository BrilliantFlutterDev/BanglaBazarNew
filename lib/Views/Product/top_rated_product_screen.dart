import 'package:bangla_bazar/ModelClasses/recently_viewed_reponse.dart';
import 'package:bangla_bazar/ModelClasses/store_response.dart';
import 'package:bangla_bazar/ModelClasses/top_rated_product_response.dart';
import 'package:bangla_bazar/ModelClasses/trending_for_you_response.dart';
import 'package:bangla_bazar/ModelClasses/trending_for_you_response.dart';
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

class TopRatedProductScreen extends StatefulWidget {
  final String previousPage;

  const TopRatedProductScreen({
    Key? key,
    required this.previousPage,
  }) : super(key: key);
  @override
  _TopRatedProductScreenState createState() => _TopRatedProductScreenState();
}

class _TopRatedProductScreenState extends State<TopRatedProductScreen> {
  late ProductBloc _productBloc;
  int activeTabNo = 1;
  TextEditingController reviewController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<String> topReviewList = ['Top Reviews', 'Best Reviews'];
  late String statusValueChoose;
  TopRatedProductsResponse? topRatedProductsResponse;
  List<ViewTopRatedProducts>? topRatedProducts = [];

  final _scrollController = ScrollController();

  int offset = 0;
  int totalPages = 0;

  bool loadingNextPage = false;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    statusValueChoose = '';
    _productBloc.add(GetTopRatedItems(
        offset: 0, country: AppGlobal.currentCountry, search: ''));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (offset < totalPages - 1) {
          offset++;
          loadingNextPage = true;
          _productBloc.add(GetTopRatedItems(
              offset: offset, country: AppGlobal.currentCountry, search: ''));

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
      } else if (state is TopRatedDataFetched) {
        if (loadingNextPage == false) {
          topRatedProducts!.clear();
          topRatedProductsResponse = state.topRatedProductsResponse;
          totalPages = (topRatedProductsResponse!.totalRecords / 20).ceil();
          topRatedProducts!
              .addAll(topRatedProductsResponse!.viewTopRatedProducts);
          print('Total Pages: $totalPages');
        } else {
          topRatedProducts!
              .addAll(state.topRatedProductsResponse.viewTopRatedProducts);
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
                                  '  ( ${topRatedProductsResponse != null ? topRatedProducts!.length : '0'} )',
                                  style: const TextStyle(
                                      fontSize: 12, color: kColorDarkGreyText),
                                ),
                              ],
                            ),
                            GridView.builder(
                              itemCount: topRatedProductsResponse == null
                                  ? 0
                                  : topRatedProducts!.length,
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
                                                    topRatedProducts![index]
                                                        .ProductID,
                                              )),
                                    );
                                  },
                                  child: ProductWidget(
                                    screenSize: screenSize,
                                    product: topRatedProductsResponse == null
                                        ? Product(
                                            small: '',
                                            currency: '',
                                            productID: 12,
                                            medium: '',
                                            title: '',
                                            price: '',
                                            large: '')
                                        : Product(
                                            small:
                                                topRatedProducts![index].Large,
                                            currency: topRatedProducts![index]
                                                .Currency,
                                            productID: topRatedProducts![index]
                                                .ProductID,
                                            medium:
                                                topRatedProducts![index].Medium,
                                            title:
                                                topRatedProducts![index].Title,
                                            price:
                                                topRatedProducts![index].Price,
                                            large:
                                                topRatedProducts![index].Large),
                                    avgRating: topRatedProductsResponse == null
                                        ? 0
                                        : double.parse(topRatedProducts![index]
                                            .AVGRATING!),
                                    reviewCount: topRatedProductsResponse ==
                                            null
                                        ? 0
                                        : topRatedProducts![index].ReviewCount,
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

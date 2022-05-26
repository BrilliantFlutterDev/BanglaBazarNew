import 'package:bangla_bazar/ModelClasses/categories_subcategories_response.dart';
import 'package:bangla_bazar/ModelClasses/store_response.dart' as store;
import 'package:bangla_bazar/ModelClasses/sub_categories_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';

import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';

import 'package:bangla_bazar/Views/Product/ProductBloc/product_bloc.dart';
import 'package:bangla_bazar/Views/Product/open_subcategory_screen.dart';
import 'package:bangla_bazar/Views/Product/product_details_screen.dart';
import 'package:bangla_bazar/Widgets/subcategory_product_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SubCategoriesScreen extends StatefulWidget {
  //static const String id = 'chatscreen';
  //final GlobalKey<ScaffoldState> parentScaffoldKey;
  final CategoriesAndSubcategoriesResponse? categoriesAndSubcategoriesResponse;
  List<SubCategoryDetails> subCategories;
  int selectedCategoryId;
  String appBarTitle;

  SubCategoriesScreen({
    Key? key,
    required this.categoriesAndSubcategoriesResponse,
    required this.selectedCategoryId,
    required this.subCategories,
    required this.appBarTitle,
  }) : super(key: key);
  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  late ProductBloc _productBloc;
  SubCategoriesResponse? subCategoriesResponse;
  int lastSubCategoryOpenNo = 0;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
  }

  final _controllerCategory = ScrollController();

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
      } else if (state is SubCategoriesProductFetched) {
        subCategoriesResponse = state.subCategoriesResponse;
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
                ///This is Body
                Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  color: kColorWhite,
                  child: Column(
                    children: [
                      SizedBox(
                        // color: Colors.yellow,
                        width: screenSize.width,
                        height: screenSize.height * 0.12,
                      ),
                      Row(
                        children: [
                          Container(
                            height: screenSize.height * 0.86,
                            width: screenSize.width * 0.25,
                            color: kColorWidgetBackgroundColor,
                            child: ListView.builder(
                              controller: _controllerCategory,
                              itemCount: widget
                                  .categoriesAndSubcategoriesResponse!
                                  .categoriesAndSubCategories
                                  .length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        lastSubCategoryOpenNo = 0;
                                        widget.selectedCategoryId = widget
                                            .categoriesAndSubcategoriesResponse!
                                            .categoriesAndSubCategories[i]
                                            .categoryDetails
                                            .CategoryID;
                                        widget.subCategories = widget
                                            .categoriesAndSubcategoriesResponse!
                                            .categoriesAndSubCategories[i]
                                            .subCategoryDetails;
                                        widget.appBarTitle = widget
                                            .categoriesAndSubcategoriesResponse!
                                            .categoriesAndSubCategories[i]
                                            .categoryDetails
                                            .Category;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: screenSize.height * 0.12,
                                        width: screenSize.width * 0.22,
                                        decoration: BoxDecoration(
                                          color: widget
                                                      .categoriesAndSubcategoriesResponse!
                                                      .categoriesAndSubCategories[
                                                          i]
                                                      .categoryDetails
                                                      .CategoryID ==
                                                  widget.selectedCategoryId
                                              ? kColorWhite
                                              : kColorWidgetBackgroundColor,
                                          // border: Border.all(
                                          //     color: kColorWidgetBackgroundColor, // Set border color
                                          //     width: 0.0),   // Set border width
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),

                                          // image: DecorationImage(
                                          //   image:
                                          //   NetworkImage(AppGlobal.photosBaseURL +
                                          //       widget.categoriesAndSubcategoriesResponse!
                                          //           .categoriesAndSubCategories[i]
                                          //           .categoryDetails
                                          //           .CategoryPic),
                                          //   fit: BoxFit.cover,
                                          // ),
                                          // Set rounded corner radius
                                          // Make rounded corner of border
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Image.network(AppGlobal
                                            //         .photosBaseURL +
                                            //     widget
                                            //         .categoriesAndSubcategoriesResponse!
                                            //         .categoriesAndSubCategories[
                                            //             i]
                                            //         .categoryDetails
                                            //         .CategoryPic),
                                            Container(
                                              height: screenSize.height * 0.06,
                                              width: screenSize.width * 0.15,
                                              child: CachedNetworkImage(
                                                imageUrl: AppGlobal
                                                        .photosBaseURL +
                                                    widget
                                                        .categoriesAndSubcategoriesResponse!
                                                        .categoriesAndSubCategories[
                                                            i]
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
                                                        Icon(Icons.error),
                                              ),
                                              // color: Colors.amber,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              widget
                                                  .categoriesAndSubcategoriesResponse!
                                                  .categoriesAndSubCategories[i]
                                                  .categoryDetails
                                                  .Category,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Container(
                              height: screenSize.height * 0.88,
                              width: screenSize.width * 0.7,
                              child: ListView.builder(
                                itemCount: widget.subCategories.length,
                                itemBuilder: (context, i) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.subCategories[i].SubCategory,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                if (widget.subCategories[i]
                                                        .isOpen ==
                                                    false) {
                                                  widget
                                                      .subCategories[
                                                          lastSubCategoryOpenNo]
                                                      .isOpen = false;
                                                  lastSubCategoryOpenNo = i;
                                                  subCategoriesResponse = null;
                                                  _productBloc.add(
                                                      GetSubCategoriesProducts(
                                                          id: widget
                                                              .subCategories[i]
                                                              .SubCategoryID));
                                                  widget.subCategories[i]
                                                      .isOpen = true;
                                                } else {
                                                  subCategoriesResponse = null;
                                                  widget.subCategories[i]
                                                      .isOpen = false;
                                                  setState(() {});
                                                }
                                              },
                                              child: Icon(widget
                                                          .subCategories[i]
                                                          .isOpen ==
                                                      false
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Divider(
                                          height: 1,
                                          color: kColorFieldsBorders),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      subCategoriesResponse != null
                                          ? Visibility(
                                              visible: widget
                                                  .subCategories[i].isOpen,
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                OpenSubcategoryScreen(
                                                                  storeID: 12,
                                                                  previousPage:
                                                                      '',
                                                                )),
                                                      );
                                                    },
                                                    child:
                                                        subCategoriesResponse!
                                                                    .product
                                                                    .length >
                                                                6
                                                            ? Container(
                                                                child: Text(
                                                                  'See All',
                                                                  style: TextStyle(
                                                                      color:
                                                                          kColorBlueText,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                height: 30,
                                                                width: 50,
                                                              )
                                                            : SizedBox(),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    child: GridView.builder(
                                                      itemCount:
                                                          subCategoriesResponse!
                                                                  .product
                                                                  .isEmpty
                                                              ? 0
                                                              : subCategoriesResponse!
                                                                  .product
                                                                  .length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              childAspectRatio:
                                                                  39 / 70,
                                                              crossAxisSpacing:
                                                                  7,
                                                              crossAxisCount:
                                                                  3),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ProductDetailsScreen(
                                                                            previousPage:
                                                                                '',
                                                                            productID:
                                                                                subCategoriesResponse!.product[index].ProductID,
                                                                          )),
                                                            );
                                                          },
                                                          child:
                                                              SubCategoryProductWidget(
                                                            screenSize:
                                                                screenSize,
                                                            product: store.Product(
                                                                small: '',
                                                                productID: 12,
                                                                currency:
                                                                    subCategoriesResponse!
                                                                        .product[
                                                                            index]
                                                                        .Currency,
                                                                medium: '',
                                                                title: subCategoriesResponse!
                                                                    .product[
                                                                        index]
                                                                    .Title,
                                                                price: subCategoriesResponse!
                                                                    .product[
                                                                        index]
                                                                    .Price,
                                                                large: ''),
                                                            productPic:
                                                                subCategoriesResponse!
                                                                    .product[
                                                                        index]
                                                                    .Medium,
                                                            rating: double.parse(
                                                                subCategoriesResponse!
                                                                    .product[
                                                                        index]
                                                                    .AVGRATING),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                              ),
                                            )
                                          : SizedBox()
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                ///This is AppBar
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
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                  )),
                              Text(
                                '  ${widget.appBarTitle}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 21),
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

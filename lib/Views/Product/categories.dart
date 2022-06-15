import 'package:bangla_bazar/ModelClasses/categories_subcategories_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';

import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';

import 'package:bangla_bazar/Views/Product/ProductBloc/product_bloc.dart';
import 'package:bangla_bazar/Views/Product/sub_category_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Categories extends StatefulWidget {
  //static const String id = 'chatscreen';
  //final GlobalKey<ScaffoldState> parentScaffoldKey;

  const Categories({
    Key? key,
  }) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late ProductBloc _productBloc;
  CategoriesAndSubcategoriesResponse? categoriesAndSubcategoriesResponse;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc.add(GetCategories());
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
      } else if (state is CategoriesData) {
        categoriesAndSubcategoriesResponse =
            state.categoriesAndSubcategoriesResponse;
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          // color: Colors.yellow,
                          width: screenSize.width,
                          height: screenSize.height * 0.12,
                        ),
                        Container(
                          height: screenSize.height * 0.88,
                          child: GridView.builder(
                            itemCount:
                                categoriesAndSubcategoriesResponse == null
                                    ? 0
                                    : categoriesAndSubcategoriesResponse!
                                        .categoriesAndSubCategories.length,
                            shrinkWrap: true,
                            //physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 50 / 70,
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 3),
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
                                        color:
                                            kColorDarkGreyText.withOpacity(0.2),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 55,
                                          height: 55,
                                          child: CachedNetworkImage(
                                            imageUrl: AppGlobal.photosBaseURL +
                                                categoriesAndSubcategoriesResponse!
                                                    .categoriesAndSubCategories[
                                                        index]
                                                    .categoryDetails
                                                    .CategoryPic
                                                    .replaceAll('\\', '/'),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
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
                                      categoriesAndSubcategoriesResponse == null
                                          ? ''
                                          : categoriesAndSubcategoriesResponse!
                                              .categoriesAndSubCategories[index]
                                              .categoryDetails
                                              .Category,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          //height: screenSize.height,
                        ),

                        ///
                      ],
                    ),
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
                              const Text(
                                '  Categories',
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

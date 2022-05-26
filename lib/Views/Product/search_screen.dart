import 'package:bangla_bazar/ModelClasses/categories_subcategories_response.dart';
import 'package:bangla_bazar/ModelClasses/home_page_api_reponse.dart';
import 'package:bangla_bazar/ModelClasses/search_response.dart';
import 'package:bangla_bazar/ModelClasses/store_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';
import 'package:bangla_bazar/Views/AuthenticationScreens/account_screen.dart';
import 'package:bangla_bazar/Views/Product/ProductBloc/product_bloc.dart';
import 'package:bangla_bazar/Views/Product/product_details_screen.dart';
import 'package:bangla_bazar/Views/Product/sub_category_screen.dart';
import 'package:bangla_bazar/Widgets/photo_avatar.dart';
import 'package:bangla_bazar/Widgets/product_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchScreen extends StatefulWidget {
  //static const String id = 'chatscreen';
  //GlobalKey<ScaffoldState> parentScaffoldKey;

  const SearchScreen({
    Key? key,
  }) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ProductBloc _productBloc;
  TextEditingController searchController = TextEditingController();

  SearchResponse? searchResponse;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
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
      } else if (state is SearchResultFetched) {
        searchResponse = state.searchResponse;
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
                          height: screenSize.height * 0.09,
                        ),
                        Container(
                          width: screenSize.width,
                          height: screenSize.height * 0.8,
                          child: ListView.builder(
                              itemCount: searchResponse != null
                                  ? searchResponse!.product.length
                                  : 0,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailsScreen(
                                                      previousPage: '',
                                                      productID: searchResponse!
                                                          .product[index]
                                                          .ProductID,
                                                    )),
                                          );
                                        },
                                        child: Text(
                                          searchResponse!.product[index].Title,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          searchController.text =
                                              searchResponse!
                                                  .product[index].Title;
                                          setState(() {});
                                        },
                                        child: Icon(
                                          MyFlutterApp.recent_arrow,
                                          size: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      color: kColorWhite,
                      width: screenSize.width,
                      height: screenSize.height * 0.070,
                    ),
                    TextField(
                      style: TextStyle(color: kColorDarkGreyIcon),
                      controller: searchController,
                      cursorColor: kColorDarkGreyIcon,
                      onSubmitted: (value) {
                        _productBloc.add(Search(
                            searchType: 0,
                            limit: 12,
                            offset: 0,
                            search: searchController.text));
                        if (searchController.text.isEmpty) {
                          searchResponse!.product.clear();
                          setState(() {});
                        }
                      },
                      onChanged: (value) {
                        if (searchController.text.length % 3 == 0 &&
                            searchController.text.isNotEmpty) {
                          _productBloc.add(Search(
                              searchType: 0,
                              limit: 12,
                              offset: 0,
                              search: searchController.text));
                        }
                        if (searchController.text.isEmpty) {
                          searchResponse!.product.clear();
                          setState(() {});
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(35.0),
                            ),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kColorWidgetBackgroundColor, width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35.0),
                            ),
                          ),
                          //border: InputBorder.none,
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kColorWidgetBackgroundColor, width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35.0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kColorWidgetBackgroundColor, width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35.0),
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: kColorDarkGreyIcon,
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: kColorFieldsBorders),
                          hintText: "Search for anything",
                          fillColor: kColorWidgetBackgroundColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

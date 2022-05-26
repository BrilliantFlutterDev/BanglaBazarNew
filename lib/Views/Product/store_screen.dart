import 'package:bangla_bazar/ModelClasses/product_details_response.dart'
    as product;
import 'package:bangla_bazar/ModelClasses/store_response.dart';
import 'package:bangla_bazar/Utils/app_colors.dart';
import 'package:bangla_bazar/Utils/app_global.dart';

import 'package:bangla_bazar/Utils/icons.dart';
import 'package:bangla_bazar/Utils/modalprogresshud.dart';

import 'package:bangla_bazar/Views/Product/ProductBloc/product_bloc.dart';
import 'package:bangla_bazar/Views/Product/product_details_screen.dart';
import 'package:bangla_bazar/Widgets/photo_avatar.dart';
import 'package:bangla_bazar/Widgets/product_user_review_widget.dart';
import 'package:bangla_bazar/Widgets/product_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StoreScreen extends StatefulWidget {
  final String storeName;
  final String previousPage;

  const StoreScreen({
    Key? key,
    required this.previousPage,
    required this.storeName,
  }) : super(key: key);
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late ProductBloc _productBloc;
  int activeTabNo = 1;
  TextEditingController reviewController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<String> topReviewList = ['Top Reviews', 'Best Reviews'];
  late String statusValueChoose;
  StoreResponse? storeResponse;
  int offset = 0;
  int totalPages = 0;
  bool loadingNextPage = false;
  List<Product>? storeProductsList = [];

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // print('|||||||||||||');
    // print(0.3.ceil());
    _productBloc = BlocProvider.of<ProductBloc>(context);
    statusValueChoose = '';
    //_productBloc.add(GetStore(storeName: 'Nishat', offset: 0));
    _productBloc
        .add(GetStore(storeName: widget.storeName, offset: 0, search: ''));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (offset < totalPages - 1) {
          offset++;
          loadingNextPage = true;
          _productBloc.add(GetStore(
              storeName: widget.storeName, offset: offset, search: ''));
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
      } else if (state is StoreData) {
        if (loadingNextPage == false) {
          storeProductsList!.clear();
          storeResponse = state.storeResponse;
          totalPages = (storeResponse!.totalProducts / 5).ceil();
          storeProductsList!.addAll(storeResponse!.products);
          print('Total Pages: $totalPages');
        } else {
          storeProductsList!.addAll(state.storeResponse.products);
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
                  child: Column(
                    children: [
                      SizedBox(
                        // color: Colors.yellow,
                        width: screenSize.width,
                        height: screenSize.height * 0.125,
                      ),
                      Container(
                        height: screenSize.height * 0.15,
                        width: screenSize.width,

                        decoration: BoxDecoration(
                          color: kColorWidgetBackgroundColor,
                          image: DecorationImage(
                            image: NetworkImage(storeResponse != null
                                ? AppGlobal.photosBaseURL +
                                    storeResponse!.business.companyLogo
                                        .replaceAll('\\', '/')
                                : ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // child: CachedNetworkImage(
                        //   imageUrl: storeResponse != null
                        //       ? AppGlobal.photosBaseURL +
                        //           storeResponse!.business.bannerImage
                        //               .replaceAll('\\', '/')
                        //       : '',
                        //   progressIndicatorBuilder:
                        //       (context, url, downloadProgress) => Center(
                        //     child: CircularProgressIndicator(
                        //         color: kColorPrimary,
                        //         value: downloadProgress.progress),
                        //   ),
                        //   errorWidget: (context, url, error) =>
                        //       Icon(Icons.error),
                        // )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            kColorDarkGreyText.withOpacity(0.2),
                                        border: Border.all(
                                            color: kColorOrangeText, width: 2),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              storeResponse != null
                                                  ? AppGlobal.photosBaseURL +
                                                      storeResponse!
                                                          .business.companyLogo
                                                          .replaceAll('\\', '/')
                                                  : ''),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // child: CachedNetworkImage(
                                      //   imageUrl: storeResponse != null
                                      //       ? AppGlobal.photosBaseURL +
                                      //           storeResponse!
                                      //               .business.companyLogo
                                      //               .replaceAll('\\', '/')
                                      //       : '',
                                      //   progressIndicatorBuilder: (context,
                                      //           url, downloadProgress) =>
                                      //       Center(
                                      //     child: CircularProgressIndicator(
                                      //         color: kColorPrimary,
                                      //         value:
                                      //             downloadProgress.progress),
                                      //   ),
                                      //   errorWidget: (context, url, error) =>
                                      //       Icon(Icons.error),
                                      // )
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          storeResponse == null
                                              ? ''
                                              : storeResponse!
                                                  .business.companyName,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: kColorYellow,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '4.5',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '(100 Reviews)',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: kColorFieldsBorders),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const StoreScreen(
                                    //             previousPage: '',
                                    //             storeName: 1,
                                    //           )),
                                    // );
                                  },
                                  child: Container(
                                      height: screenSize.height * 0.04,
                                      width: screenSize.width * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: kColorWidgetBackgroundColor,
                                        border: Border.all(
                                          color: kColorPrimary,
                                        ),
                                      ),
                                      child: const Center(
                                          child: Text(
                                        '+ Follow',
                                        style: TextStyle(
                                            fontSize: 12, color: kColorPrimary),
                                      ))),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
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
                                    'Products',
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
                                    'About',
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
                                    'Policies',
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
                                const SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      activeTabNo = 4;
                                    });
                                  },
                                  child: Text(
                                    'Reviews',
                                    style: TextStyle(
                                        color: activeTabNo == 4
                                            ? kColorPrimary
                                            : kColorDarkGreyText,
                                        decoration: activeTabNo == 4
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Visibility(
                                visible: activeTabNo == 1 ? true : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          //padding: const EdgeInsets.all(10),
                                          height: screenSize.height * 0.06,
                                          width: screenSize.width * 0.78,
                                          child: TextField(
                                            controller: searchController,
                                            onChanged: (value) {
                                              print(
                                                  searchController.text.length);
                                              if (searchController.text.length %
                                                      3 ==
                                                  0) {
                                                if (loadingNextPage == true) {
                                                  offset--;
                                                }
                                                loadingNextPage = false;
                                                _productBloc.add(GetStore(
                                                    storeName: widget.storeName,
                                                    offset: 0,
                                                    search:
                                                        searchController.text));
                                              }
                                            },
                                            decoration: InputDecoration(
                                              floatingLabelStyle:
                                                  const TextStyle(
                                                      color: kColorPrimary),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                borderSide: const BorderSide(
                                                  color: kColorFieldsBorders,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                    color: kColorPrimary,
                                                  )),
                                              prefixIcon: Icon(
                                                Icons.search,
                                                size: 18,
                                                color: kColorFieldsBorders,
                                              ),
                                              filled: true,
                                              labelStyle: TextStyle(
                                                  color: kColorFieldsBorders,
                                                  fontSize: 12),
                                              labelText: 'Search for anything',
                                            ),
                                          ),
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
                                              width: 45,
                                              height: 45,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    kColorWidgetBackgroundColor,
                                                // border: Border.all(
                                                //     color: kColorDarkGreyText, width: 3),
                                                // image: DecorationImage(
                                                //   image: Image.asset("assets/icons/eyeicon.png",),
                                                //   fit: BoxFit.cover,
                                                // ),
                                              ),
                                              child: const Icon(
                                                Icons.menu,
                                                color: kColorDarkGreyText,
                                                size: 15,
                                              )),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'All Products',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Container(
                                      //height: screenSize.height * 0.65,
                                      child: GridView.builder(
                                        itemCount: storeResponse == null
                                            ? 0
                                            : storeProductsList!.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
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
                                                              storeProductsList![
                                                                      index]
                                                                  .productID,
                                                        )),
                                              );
                                            },
                                            child: ProductWidget(
                                              screenSize: screenSize,
                                              product: storeResponse == null
                                                  ? Product(
                                                      small: '',
                                                      currency: '',
                                                      productID: 14,
                                                      medium: '',
                                                      title: '',
                                                      price: '',
                                                      large: '')
                                                  : storeProductsList![index],
                                              avgRating: 0,
                                              reviewCount: 0,
                                            ),
                                          );
                                        },
                                      ),
                                      //height: screenSize.height,
                                    ),
                                  ],
                                )),
                            Visibility(
                                visible: activeTabNo == 2 ? true : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'About us',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      storeResponse == null
                                          ? ''
                                          : storeResponse!.business.about,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: kColorDarkGreyText),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      'Address',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
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
                                            Icons.add_location_alt,
                                            color: kColorPrimary,
                                            size: 10,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          storeResponse == null
                                              ? ''
                                              : storeResponse!
                                                  .business.address1,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: kColorDarkGreyText),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Phone No',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
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
                                          storeResponse == null
                                              ? ''
                                              : storeResponse!
                                                  .business.businessPhone,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: kColorDarkGreyText),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
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
                                          storeResponse == null
                                              ? ''
                                              : storeResponse!
                                                  .business.businessEmail,
                                          style: TextStyle(
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
                                    Text(
                                      'Shipping Policy',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt arcu cursus vitae congue mauris. Sagittis id consectetur purus ut. Tellus rutrum tellus pelle Vel pretium lectus quam id leo in vitae turpis massa.',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: kColorDarkGreyText),
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      'Refund Policy',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt arcu cursus vitae congue mauris. Sagittis id consectetur purus ut. Tellus rutrum tellus pelle Vel pretium lectus quam id leo in vitae turpis massa.',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: kColorDarkGreyText),
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      'Cancellation / Return / Exchange Policy',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt arcu cursus vitae congue mauris. Sagittis id consectetur purus ut. Tellus rutrum tellus pelle Vel pretium lectus quam id leo in vitae turpis massa.',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: kColorDarkGreyText),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                )),
                            Visibility(
                                visible: activeTabNo == 4 ? true : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Customer Reviews',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: 3,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemSize: 16,
                                          itemCount: 5,
                                          //itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Based on 1500 reviews',
                                          style: TextStyle(
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
                                        Text(
                                          '5 ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 14,
                                          color: kColorYellow,
                                        ),
                                        SizedBox(
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
                                          percent: 0.8,
                                          progressColor: kColorYellow,
                                          backgroundColor:
                                              kColorWidgetBackgroundColor,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          '80%',
                                          style: TextStyle(
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
                                        Text(
                                          '4 ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 14,
                                          color: kColorYellow,
                                        ),
                                        SizedBox(
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
                                          percent: 0.1,
                                          progressColor: kColorYellow,
                                          backgroundColor:
                                              kColorWidgetBackgroundColor,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          '10%',
                                          style: TextStyle(
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
                                        Text(
                                          '3 ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 14,
                                          color: kColorYellow,
                                        ),
                                        SizedBox(
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
                                          percent: 0.06,
                                          progressColor: kColorYellow,
                                          backgroundColor:
                                              kColorWidgetBackgroundColor,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          '6%',
                                          style: TextStyle(
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
                                        Text(
                                          '2 ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                        Icon(
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
                                          percent: 0.12,
                                          progressColor: kColorYellow,
                                          backgroundColor:
                                              kColorWidgetBackgroundColor,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          '12%',
                                          style: TextStyle(
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
                                        Text(
                                          '1 ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 14,
                                          color: kColorYellow,
                                        ),
                                        SizedBox(
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
                                          percent: 0.09,
                                          progressColor: kColorYellow,
                                          backgroundColor:
                                              kColorWidgetBackgroundColor,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          '9%',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kColorDarkGreyText),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Review this product',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
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
                                        Text(
                                          'Your Rating: ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        RatingBar.builder(
                                          initialRating: 3,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemSize: 18,
                                          itemCount: 5,
                                          //itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
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
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              //charLength = value.length;
                                            });
                                            //print('$value,$charLength');
                                          },
                                          maxLines: 8,
                                          cursorColor: kColorPrimary,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            // hintText: getTranslated(context,
                                            //     'typeherestartdictation'),
                                            isDense: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 20, 40, 0),
                                            hintText: 'Write your review here',
                                            hintStyle: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade400),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: kColorFieldsBorders,
                                                  width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
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
                                        onTap: () {},
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
                                        Text(
                                          'Top Reviews',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Sort by:  ',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Container(
                                              width: screenSize.width * 0.35,
                                              height: 35,
                                              padding: EdgeInsets.only(
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
                                      itemCount: 3,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        return ProductUserReviewWidget(
                                          screenSize: screenSize,
                                          usersProductReviewAndRating: product
                                              .UsersProductReviewAndRating(
                                            ID: 2,
                                            UserID: 2,
                                            ProductID: 2,
                                            Review: 'Good',
                                            Rating: 0,
                                            PurchaseVerified: "Y",
                                            LastUpdate:
                                                "2021-12-09T12:49:13.000Z",
                                            UserName: "UserName",
                                            ProfilePic: '',
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Have a question?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
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
                                          prefixIcon: Icon(
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
                                  const Text(
                                    '  Store View',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
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
                                          Icons.share,
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
                                          Icons.menu,
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

// To parse this JSON data, do
//
//     final storeResponse = storeResponseFromJson(jsonString);

import 'dart:convert';

StoreResponse storeResponseFromJson(String str) =>
    StoreResponse.fromJson(json.decode(str));

String storeResponseToJson(StoreResponse data) => json.encode(data.toJson());

class StoreResponse {
  StoreResponse({
    required this.status,
    required this.totalProducts,
    required this.business,
    required this.products,
  });

  late final bool status;
  late final int totalProducts;
  late final Business business;
  late final List<Product> products;

  factory StoreResponse.fromJson(Map<String, dynamic> json) => StoreResponse(
        status: json["status"],
        totalProducts: json["total_Products"],
        business: Business.fromJson(json["business"]),
        products: List<Product>.from(
            json["Products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "total_Products": totalProducts,
        "business": business.toJson(),
        "Products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Business {
  Business({
    required this.vendorId,
    required this.companyName,
    required this.taxId,
    required this.taxIdPic,
    required this.governmentId,
    required this.governmentIdPic,
    required this.companyLogo,
    required this.bannerImage,
    required this.address1,
    required this.address2,
    required this.cityId,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.googleMapId,
    required this.countryId,
    required this.paymentAccount,
    required this.paymentRouting,
    required this.businessEmail,
    required this.businessPhone,
    required this.emailVerified,
    required this.phoneVerified,
    required this.businessUrl,
    required this.pageUrl,
    required this.reviewedByAdmin,
    required this.reviewedBySuperAdmin,
    required this.gatewayId,
    required this.allowDelivery,
    required this.allowStorePickup,
    required this.productApproval,
    required this.createdDate,
    required this.lastUpdate,
    required this.about,
    required this.policies,
    required this.adminNote,
  });

  late final int vendorId;
  late final String companyName;
  late final String taxId;
  late final String taxIdPic;
  late final String governmentId;
  late final String governmentIdPic;
  late final String companyLogo;
  late final String bannerImage;
  late final String address1;
  late final String address2;
  late final int cityId;
  late final String city;
  late final String state;
  late final String zipCode;
  late final String googleMapId;
  late final int countryId;
  late final String paymentAccount;
  late final String paymentRouting;
  late final String businessEmail;
  late final String businessPhone;
  late final String emailVerified;
  late final String phoneVerified;
  late final String businessUrl;
  late final String pageUrl;
  late final String? reviewedByAdmin;
  late final String reviewedBySuperAdmin;
  late final int gatewayId;
  late final String allowDelivery;
  late final String allowStorePickup;
  late final String productApproval;
  late final DateTime createdDate;
  late final DateTime lastUpdate;
  late final String about;
  late final String policies;
  late final String adminNote;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        vendorId: json["VendorID"],
        companyName: json["CompanyName"],
        taxId: json["TaxID"],
        taxIdPic: json["TaxIDPic"],
        governmentId: json["GovernmentID"],
        governmentIdPic: json["GovernmentIDPic"],
        companyLogo: json["CompanyLogo"],
        bannerImage: json["BannerImage"],
        address1: json["Address1"],
        address2: json["Address2"],
        cityId: json["CityID"],
        city: json["City"],
        state: json["State"],
        zipCode: json["ZipCode"],
        googleMapId: json["GoogleMapID"],
        countryId: json["CountryID"],
        paymentAccount: json["PaymentAccount"],
        paymentRouting: json["PaymentRouting"],
        businessEmail: json["BusinessEmail"],
        businessPhone: json["BusinessPhone"],
        emailVerified: json["EmailVerified"],
        phoneVerified: json["PhoneVerified"],
        businessUrl: json["BusinessURL"],
        pageUrl: json["PageURL"],
        reviewedByAdmin: json["ReviewedByAdmin"] ?? '',
        reviewedBySuperAdmin: json["ReviewedBySuperAdmin"],
        gatewayId: json["GatewayID"],
        allowDelivery: json["AllowDelivery"],
        allowStorePickup: json["AllowStorePickup"],
        productApproval: json["ProductApproval"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        lastUpdate: DateTime.parse(json["LastUpdate"]),
        about: json["About"] ?? '',
        policies: json["Policies"] ?? '',
        adminNote: json["AdminNote"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "VendorID": vendorId,
        "CompanyName": companyName,
        "TaxID": taxId,
        "TaxIDPic": taxIdPic,
        "GovernmentID": governmentId,
        "GovernmentIDPic": governmentIdPic,
        "CompanyLogo": companyLogo,
        "BannerImage": bannerImage,
        "Address1": address1,
        "Address2": address2,
        "CityID": cityId,
        "City": city,
        "State": state,
        "ZipCode": zipCode,
        "GoogleMapID": googleMapId,
        "CountryID": countryId,
        "PaymentAccount": paymentAccount,
        "PaymentRouting": paymentRouting,
        "BusinessEmail": businessEmail,
        "BusinessPhone": businessPhone,
        "EmailVerified": emailVerified,
        "PhoneVerified": phoneVerified,
        "BusinessURL": businessUrl,
        "PageURL": pageUrl,
        "ReviewedByAdmin": reviewedByAdmin,
        "ReviewedBySuperAdmin": reviewedBySuperAdmin,
        "GatewayID": gatewayId,
        "AllowDelivery": allowDelivery,
        "AllowStorePickup": allowStorePickup,
        "ProductApproval": productApproval,
        "CreatedDate": createdDate.toIso8601String(),
        "LastUpdate": lastUpdate.toIso8601String(),
        "About": about,
        "Policies": policies,
        "AdminNote": adminNote,
      };
}

class Product {
  Product({
    required this.productID,
    required this.title,
    required this.price,
    required this.currency,
    required this.small,
    required this.medium,
    required this.large,
  });

  late final int productID;
  late final String title;
  late final String price;
  late final String currency;
  late final String small;
  late final String medium;
  late final String large;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json["Title"],
        price: json["Price"],
        currency: json["Currency"],
        small: json["Small"],
        medium: json["Medium"],
        large: json["Large"],
        productID: json["ProductID"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Price": price,
        "Currency": currency,
        "Small": small,
        "Medium": medium,
        "Large": large,
        "ProductID": productID
      };
}

class RequestUserProductClicksData {
  List<UserProductClickLocalDB>? userProductClickData;

  RequestUserProductClicksData({required this.userProductClickData});

  RequestUserProductClicksData.fromJson(List<Map<String, dynamic>> json) {
    userProductClickData = <UserProductClickLocalDB>[];
    for (var v in json) {
      userProductClickData!.add(UserProductClickLocalDB.fromJson(v));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userProductClickData != null) {
      data['ProductClicksData'] =
          userProductClickData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserProductClickLocalDB {
  int? productID;
  String? uniqueNumber;

  UserProductClickLocalDB(
      {required this.productID, required this.uniqueNumber});

  UserProductClickLocalDB.fromJson(Map<String, dynamic> json) {
    productID = json['ProductID'];
    uniqueNumber = json['UniqueNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['ProductID'] = productID;
    data['UniqueNumber'] = uniqueNumber;

    return data;
  }
}

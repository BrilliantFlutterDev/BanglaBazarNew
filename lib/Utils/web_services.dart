import 'dart:convert';
import 'dart:developer';

import 'package:bangla_bazar/ModelClasses/AddNewBussinessPage1Model.dart';
import 'package:bangla_bazar/ModelClasses/add_driver_model.dart';
import 'package:bangla_bazar/Utils/app_global.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WebServices {
  static Future<dynamic> apiPost(String url, var params) async {
    dynamic response;
    Dio dio = Dio();
    //FormData formData;
    print("url : $url");

    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["region"] = AppGlobal.region;

      //formData = FormData.fromMap(params);

      response = await dio
          .post(
        url,
        data: jsonEncode(params),
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // LoginResponse().message = e.response.data(1);
        print(e.response!.data);
        print(e.response!.headers);
        return e;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e);
        return e;
      }
    }
    if (response != null) {
      print('response: $response');
      return response;
    } else {
      return response;
    }
  }

  static Future<dynamic> apiPostAuthenticationBearerToken(
      String url, var params) async {
    dynamic response;
    Dio dio = Dio();
    //FormData formData;
    print('url: $url');
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["Authorization"] = 'Bearer ${AppGlobal.token}';
      dio.options.headers["region"] = AppGlobal.region;

      //formData = FormData.fromMap(params);

      response = await dio
          .post(
        url,
        data: jsonEncode(params),
      )
          .timeout(const Duration(seconds: 35), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // LoginResponse().message = e.response.data(1);
        print(e.response!.data);
        print(e.response!.headers);
        return e;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e);
        return e;
      }
    }
    if (response != null) {
      print("params: $params");
      print('response: $response');
      return response;
    } else {
      return response;
    }
  }

  static Future<dynamic> apiPostToJson(String url, var params) async {
    dynamic response;
    Dio dio = Dio();
    //FormData formData;
    print('In web service class>>>>>>');
    print('url: $url');
    print(params.toJson());
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["Authorization"] = 'Bearer ${AppGlobal.token}';
      dio.options.headers["region"] = AppGlobal.region;

      //formData = FormData.fromMap(params);

      response = await dio
          .post(
        url,
        data: jsonEncode(params),
      )
          .timeout(const Duration(seconds: 35), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // LoginResponse().message = e.response.data(1);
        print(e.response!.data);
        print(e.response!.headers);
        return e;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e);
        return e;
      }
    }
    if (response != null) {
      print('response: $response');
      return response;
    } else {
      return response;
    }
  }

  static Future<dynamic> apiPostToJsonWithoutBearerToken(
      String url, var params) async {
    dynamic response;
    Dio dio = Dio();
    //FormData formData;
    print('In web service class>>>>>>');
    print('url: $url');
    print(params.toJson());
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["region"] = AppGlobal.region;

      //formData = FormData.fromMap(params);

      response = await dio
          .post(
        url,
        data: jsonEncode(params),
      )
          .timeout(const Duration(seconds: 35), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // LoginResponse().message = e.response.data(1);
        print(e.response!.data);
        print(e.response!.headers);
        return e;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e);
        return e;
      }
    }
    if (response != null) {
      print('response: $response');
      return response;
    } else {
      return response;
    }
  }

  static Future<dynamic> apiPutToJson(String url, var params) async {
    dynamic response;
    Dio dio = Dio();
    //FormData formData;
    print('In web service class>>>>>>');
    print('url: $url');
    print(params.toJson());
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["Authorization"] = 'Bearer ${AppGlobal.token}';
      dio.options.headers["region"] = AppGlobal.region;
      //formData = FormData.fromMap(params);

      response = await dio
          .put(
        url,
        data: jsonEncode(params),
      )
          .timeout(const Duration(seconds: 35), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // LoginResponse().message = e.response.data(1);
        print(e.response!.data);
        print(e.response!.headers);
        return e;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e);
        return e;
      }
    }
    if (response != null) {
      print('response: $response');
      return response;
    } else {
      return response;
    }
  }

  static Future<dynamic> apiDeleteAuthenticationBearerToken(String url) async {
    dynamic response;
    Dio dio = Dio();
    //FormData formData;
    print('url: $url');
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["Authorization"] = 'Bearer ${AppGlobal.token}';

      //formData = FormData.fromMap(params);

      response = await dio
          .delete(
        url,
      )
          .timeout(const Duration(seconds: 35), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // LoginResponse().message = e.response.data(1);
        print(e.response!.data);
        print(e.response!.headers);
        return e;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e);
        return e;
      }
    }
    if (response != null) {
      print('response: $response');
      return response;
    } else {
      return response;
    }
  }

  static Future<dynamic> apiPostBusiness(
      String url, var params, AddBusinessPage1Data addBusinessPage1Data) async {
    dynamic response;
    Dio dio = Dio();
    FormData formData;
    print('url: $url');
    try {
      dio.options.headers["Accept"] = 'application/json';
      print("params: $params");

      formData = FormData.fromMap(params);
      print('|||||||||Pics are going to upload');
      formData.files.add(
        MapEntry(
            "GovernmentIDPic",
            await MultipartFile.fromFile(addBusinessPage1Data.govIDImage!.path,
                filename:
                    addBusinessPage1Data.govIDImage!.path.split('/').last)),
      );
      print('|||||||||Government Pic');
      formData.files.add(
        MapEntry(
            "BannerImage",
            await MultipartFile.fromFile(
                addBusinessPage1Data.companyLogoImage!.path,
                filename: addBusinessPage1Data.companyLogoImage!.path
                    .split('/')
                    .last)),
      );
      print('|||||||||Banner Pic');
      print(addBusinessPage1Data.textIDImage!.path);
      formData.files.add(
        MapEntry(
            "TaxIDPic",
            await MultipartFile.fromFile(addBusinessPage1Data.textIDImage!.path,
                filename:
                    addBusinessPage1Data.textIDImage!.path.split('/').last)),
      );
      print('|||||||||TaxID Pic');
      formData.files.add(
        MapEntry(
            "CompanyLogo",
            await MultipartFile.fromFile(
                addBusinessPage1Data.companyLogoImage!.path,
                filename: addBusinessPage1Data.companyLogoImage!.path
                    .split('/')
                    .last)),
      );
      print('|||||||||Logo Pic');

      response = await dio
          .post(
        url,
        data: formData,
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // LoginResponse().message = e.response.data(1);
        print(e.response!.data);
        print(e.response!.headers);
        return e;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e);
        return e;
      }
    }
    if (response != null) {
      print("params: $params");
      print('response: $response');
      return response;
    } else {
      return response;
    }
  }

  static Future<dynamic> apiPostDriverTokenBarer(
      String url, var params, AddDriverModel addDriverModel) async {
    dynamic response;
    Dio dio = Dio();
    FormData formData;
    print('url: $url');
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["Authorization"] = 'Bearer ${AppGlobal.token}';

      print("params: $params");

      formData = FormData.fromMap(params);
      if (addDriverModel.govIDImage != null) {
        print('|||||||||Pics are going to upload');
        formData.files.add(
          MapEntry(
              "GovernmentIDPic",
              await MultipartFile.fromFile(addDriverModel.govIDImage!.path,
                  filename: addDriverModel.govIDImage!.path.split('/').last)),
        );
      }

      if (addDriverModel.registerAc == true) {
        response = await dio
            .post(
          url,
          data: formData,
        )
            .timeout(const Duration(seconds: 60), onTimeout: () {
          return response('Connection Timeout');
        });
      } else {
        response = await dio
            .put(
          url,
          data: formData,
        )
            .timeout(const Duration(seconds: 60), onTimeout: () {
          return response('Connection Timeout');
        });
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // LoginResponse().message = e.response.data(1);
        print(e.response!.data);
        print(e.response!.headers);
        return e;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e);
        return e;
      }
    }
    if (response != null) {
      print("params: $params");
      print('response: $response');
      return response;
    } else {
      return response;
    }
  }

  static Future<dynamic> apiPut(String url, var params) async {
    dynamic response;
    Dio dio = Dio();
    //FormData formData;
    print('url: $url');
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["region"] = AppGlobal.region;
      //formData = FormData.fromMap(params);

      response = await dio
          .put(
        url,
        data: jsonEncode(params),
      )
          .timeout(const Duration(seconds: 35), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // LoginResponse().message = e.response.data(1);
        print(e.response!.data);
        print(e.response!.headers);
        return e;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e);
        return e;
      }
    }
    if (response != null) {
      print("params: $params");
      print('response: $response');
      return response;
    } else {
      return response;
    }
  }

  static Future updateProfilePic(String url, var params, var image) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    dynamic response;
    Dio dio = Dio();
    FormData formData;
    print('>>>>>url: $url');
    print('>>>>>>>params: ${jsonEncode(params)}');
    try {
      dio.options.headers["Accept"] = 'application/json';

      // dio.options.connectTimeout = 50000;

      formData = FormData.fromMap(params);

      formData.files.add(
        MapEntry(
            "myimg",
            await MultipartFile.fromFile(image.path,
                filename: image.path.split('/').last)),
      );

      response = await dio
          .put(
        url,
        data: formData,
      )
          .timeout(const Duration(seconds: 100), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);

        return e.response;
      }
    }
    if (response != null) {
      print('upload image response: $response');
      return response;
    } else {
      return response;
    }
  }

  static Future<dynamic> apiGet(String url) async {
    dynamic response;
    Dio dio = Dio();

    print('url: $url');

    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["region"] = AppGlobal.region;
      // dio.options.connectTimeout = 50000;

      response = await dio
          .get(
        url,
      )
          .timeout(const Duration(seconds: 100), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);

        return e.response;
      }
    }
    if (response != null) {
      print('response: $response');
      return response;
    } else {
      return response;
    }
  }

  static Future<dynamic> apiGetAuthenticationBearerToken(String url) async {
    dynamic response;
    Dio dio = Dio();

    print('url: $url');

    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["Authorization"] = 'Bearer ${AppGlobal.token}';
      dio.options.headers["region"] = AppGlobal.region;

      response = await dio
          .get(
        url,
      )
          .timeout(const Duration(seconds: 100), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);

        return e.response;
      }
    }
    if (response != null) {
      print('response: $response');
      return response;
    } else {
      return response;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:payment_integration/core/utils/constants/endpoint.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiServices {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  //************************************  postdata  *********************************

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    String lang = 'en',
    String? token,
    Map<String, String>? headers,
  }) async {
    try {
      // dio.options.headers = {
      //   'Authorization': 'bearer $token',
      //   "Accept": "application/json"
      // };
      return await dio.post(url,
          queryParameters: query,
          data: data,
          options: Options(
              validateStatus: (_) => true,
              contentType: Headers.formUrlEncodedContentType,
              responseType: ResponseType.json,
              headers: headers ??
                  {
                    'Authorization': 'bearer $token',
                    "Accept": "application/json"
                  }));
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:wanandroid/http/Api.dart';

class HttpManager {
  static HttpManager _instance;
  Dio _dio;

  factory HttpManager.getInstance() {
    return _instance ??= HttpManager._internal();
  }

  HttpManager._internal() {
    BaseOptions options = new BaseOptions(
        baseUrl: Api.BASE_URL, connectTimeout: 5000, receiveTimeout: 5000);
    _dio = new Dio(options);
  }

  request(url, {String method = "get"}) async {
    try {
      Options option = new Options(method: method);
      Response response = await _dio.request(url, options: option);
      return response.data;
    } catch (e) {
      return null;
    }
  }
}

import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wanandroid/http/Api.dart';

class HttpManager {
  static HttpManager _instance;
  Dio _dio;
  PersistCookieJar _persistCookieJar;

  factory HttpManager.getInstance() {
    return _instance ??= HttpManager._internal();
  }

  HttpManager._internal() {
    BaseOptions options = new BaseOptions(
        baseUrl: Api.BASE_URL, connectTimeout: 5000, receiveTimeout: 5000);
    _dio = new Dio(options);
    _initDio();
  }

  void _initDio() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var path = Directory(join(directory.path, "cookie")).path;
    _persistCookieJar = PersistCookieJar(dir: path);
    _dio.interceptors.add(CookieManager(_persistCookieJar));
  }

  request(url, {data, String method = "get"}) async {
    try {
      Options option = new Options(method: method);
      Response response = await _dio.request(url, data: data, options: option);
      print(response.request.headers);
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void clearCookie() {
    _persistCookieJar.deleteAll();
  }
}

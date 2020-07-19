import 'package:dio/dio.dart';
import 'package:wanandroid/http/http_manager.dart';

class Api {

  ///BaseUrl
  static const String BASE_URL = "https://www.wanandroid.com/";

  ///文章列表
  static const String ARTICLE_LIST = "article/list/";

  ///banner
  static const String BANNER = "banner/json";

  ///登录
  static const String LOGIN = "user/login";

  ///注册
  static const String REGISTER = "user/register";

  ///收藏
  static const String COLLECT = "lg/collect/list/";

  static getArticleList(int page) async {
    return HttpManager.getInstance().request("$ARTICLE_LIST$page/json");
  }

  static getBanner() async {
    return HttpManager.getInstance().request(BANNER);
  }

  static clearCookie() {
    HttpManager.getInstance().clearCookie();
  }

  static login(String username, String password) async {
    var formData = FormData.fromMap({
      "username": username,
      "password": password,
    });
    return await HttpManager.getInstance()
        .request(LOGIN, data: formData, method: "post");
  }

  static register(String username, String password) async {
    ///必须使用form表单提交
    var formData = FormData.fromMap(
        {"username": username, "password": password, "repassword": password});
    return await HttpManager.getInstance()
        .request(REGISTER, data: formData, method: "post");
  }

  static getCollects(int page) async {
    return await HttpManager.getInstance().request("$COLLECT/$page/json");
  }
}

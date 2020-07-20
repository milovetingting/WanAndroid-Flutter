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

  ///收藏文章列表
  static const String COLLECT = "lg/collect/list/";

  ///收藏网站列表
  static const String COLLECT_WEBSITE_LIST = "lg/collect/usertools/json";

  ///收藏站内文章
  static const String COLLECT_INTERNAL_ARTICLE = "lg/collect/";

  ///取消收藏站内文章
  static const String UNCOLLECT_INTERNAL_ARTICLE = "lg/uncollect_originId/";

  ///收藏网站
  static const String COLLECT_WEBSITE = "lg/collect/addtool/json";

  ///取消收藏网站
  static const String UNCOLLECT_WEBSITE = "lg/collect/deletetool/json";

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

  static getArticleCollects(int page) async {
    return await HttpManager.getInstance().request("$COLLECT/$page/json");
  }

  static getWebSiteCollects() async {
    return await HttpManager.getInstance().request(COLLECT_WEBSITE_LIST);
  }

  static collectArticle(int id) async {
    return await HttpManager.getInstance()
        .request("$COLLECT_INTERNAL_ARTICLE$id/json", method: "post");
  }

  static unCollectArticle(int id) async {
    return await HttpManager.getInstance()
        .request("$UNCOLLECT_INTERNAL_ARTICLE$id/json", method: "post");
  }

  static collectWebsite(String name, String link) async {
    var formData = FormData.fromMap({"name": name, "link": link});
    return await HttpManager.getInstance()
        .request(COLLECT_WEBSITE, data: formData, method: "post");
  }

  static unCollectWebsite(int id) async {
    var formData = FormData.fromMap({"id": id});
    return await HttpManager.getInstance()
        .request(UNCOLLECT_WEBSITE, data: formData, method: "post");
  }
}

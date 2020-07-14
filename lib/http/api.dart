import 'package:wanandroid/http/http_manager.dart';

class Api {
  static const String BASE_URL = "https://www.wanandroid.com/";
  static const String ARTICLE_LIST = "article/list/";
  static const String BANNER = "banner/json";

  static getArticleList(int page) async {
    return HttpManager.getInstance().request("$ARTICLE_LIST$page/json");
  }

  static getBanner() async {
    return HttpManager.getInstance().request(BANNER);
  }
}

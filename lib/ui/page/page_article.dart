import 'package:banner_view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/http/Api.dart';
import 'package:wanandroid/ui/page/page_webview.dart';
import 'package:wanandroid/ui/widget/article_item.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  ///滑动控制器
  ScrollController _controller = new ScrollController();

  ///正在加载的界面是否显示
  bool _showLoading = true;

  ///文章列表
  List articles = [];

  ///banner图
  List banners = [];

  ///文章总页数
  var totalPage = 0;

  ///当前页
  var curPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ///获取ScrollController监听控件可以滚动的最大范围
      var maxScroll = _controller.position.maxScrollExtent;

      ///获得当前位置的像素值
      var pixels = _controller.position.pixels;

      ///已经滑动到最底部并且还有可以加载的数据
      if (pixels == maxScroll && curPage < totalPage) {
        _getArticleList();
      }
    });

    _pullToRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ///正在加载
        Offstage(
          offstage: !_showLoading,
          child: Center(child: CircularProgressIndicator()),
        ),

        ///内容
        Offstage(
          offstage: _showLoading,
          child: RefreshIndicator(
              child: ListView.builder(
                  itemCount: articles.length + 1,
                  itemBuilder: (context, i) => _articleItem(i),
                  controller: _controller),
              onRefresh: _pullToRefresh),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///首页Item布局
  Widget _articleItem(int i) {
    if (i == 0) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: _bannerItem());
    }
    var itemData = articles[i - 1];
    return new ArticleItem(itemData);
  }

  ///BannerView布局
  Widget _bannerItem() {
    List<Widget> list = banners.map((item) {
      return InkWell(
        child: Image.network(item['imagePath'], fit: BoxFit.cover),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return WebViewPage(item);
          }));
        },
      );
//      return Image.network(item['imagePath'], fit: BoxFit.cover);
    }).toList();
    return list.isNotEmpty
        ? BannerView(list, intervalDuration: const Duration(seconds: 3))
        : null;
  }

  ///获取Banner
  _getBanner([bool update = true]) async {
    var response = await Api.getBanner();
    if (response != null) {
      banners.clear();
      banners.addAll(response['data']);
      if (update) {
        setState(() {});
      }
    }
  }

  ///获取文章列表
  _getArticleList([bool update = true]) async {
    var response = await Api.getArticleList(curPage);
    if (response != null) {
      var map = response['data'];
      var data = map['datas'];
      totalPage = map['pageCount'];
      if (curPage == 0) {
        articles.clear();
      }
      curPage++;
      articles.addAll(data);
      if (update) {
        setState(() {});
      }
    }
  }

  ///下拉刷新
  Future<void> _pullToRefresh() async {
    curPage = 0;
    Iterable<Future> futures = [_getBanner(), _getArticleList()];
    await Future.wait(futures);
    _showLoading = false;
    setState(() {});
    return null;
  }
}

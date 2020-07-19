import 'package:flutter/material.dart';
import 'package:wanandroid/manager/app_manager.dart';
import 'package:wanandroid/ui/page/page_article.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    ///初始化/等待3s显示splash
    Iterable<Future> futures = [
      AppManager.initApp(),
      Future.delayed(Duration(seconds: 3))
    ];
    await Future.wait(futures);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return ArticlePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset("assets/images/splash.png"),
    );
  }
}

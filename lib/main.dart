import 'package:flutter/material.dart';
import 'package:wanandroid/ui/page/page_splash.dart';

void main() {
  runApp(ArticleApp());
}

class ArticleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(routes: {"/": (context) => SplashPage()});
  }
}

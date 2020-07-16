import 'package:flutter/material.dart';
import 'package:wanandroid/manager/app_manager.dart';
import 'package:wanandroid/ui/widget/main_drawer.dart';

import 'ui/page/page_article.dart';

void main() {
  runApp(ArticleApp());
}

class ArticleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppManager.initApp();
    return new MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text("文章", style: const TextStyle(color: Colors.white))),
            drawer: Drawer(child: MainDrawer()),
            body: ArticlePage()));
  }
}

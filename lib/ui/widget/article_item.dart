import 'package:flutter/material.dart';
import 'package:wanandroid/ui/page/page_webview.dart';

class ArticleItem extends StatelessWidget {
  final itemData;

  const ArticleItem(this.itemData);

  @override
  Widget build(BuildContext context) {
    Row author = new Row(
      children: <Widget>[
        new Expanded(
            child: Text.rich(TextSpan(children: [
          TextSpan(text: "作者:"),
          TextSpan(
              text: itemData['author'],
              style: TextStyle(color: Theme.of(context).primaryColor)),
        ]))),
        Text(itemData['niceDate'])
      ],
    );
    Text title = Text(itemData['title'],
        style: TextStyle(fontSize: 16, color: Colors.black),
        textAlign: TextAlign.left);
    Text chapterName = Text(itemData['chapterName'],
        style: TextStyle(color: Theme.of(context).primaryColor));
    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10.0), child: author),
        Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0), child: title),
        Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: chapterName)
      ],
    );
    return Card(
      ///阴影效果
      elevation: 4.0,
      child: InkWell(
        child: column,
        onTap: ()  async{
          await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            itemData['url'] = itemData['link'];
            return WebViewPage(
              itemData,
              supportCollect: true,
            );
          }));
        },
      ),
    );
  }
}

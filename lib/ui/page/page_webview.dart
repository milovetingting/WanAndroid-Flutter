import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final data;

  WebViewPage(this.data);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;

  FlutterWebviewPlugin flutterWebviewPlugin;

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        //加载完成
        setState(() {
          isLoading = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.data['title']),

        ///AppBar下的进度条
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: const LinearProgressIndicator()),

        ///透明度
        bottomOpacity: isLoading ? 1.0 : 0.0,
      ),
      withLocalStorage: true,
      url: widget.data['url'],
      withJavascript: true,
    );
  }
}

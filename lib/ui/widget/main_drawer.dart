import 'package:flutter/material.dart';
import 'package:wanandroid/event/events.dart';
import 'package:wanandroid/http/api.dart';
import 'package:wanandroid/manager/app_manager.dart';
import 'package:wanandroid/ui/page/page_collect.dart';
import 'package:wanandroid/ui/page/page_login.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String _username;

  @override
  void initState() {
    super.initState();
    AppManager.eventBus.on<LoginEvent>().listen((event) {
      setState(() {
        _username = event.username;
        AppManager.preferences.setString(AppManager.ACCOUNT, _username);
      });
    });
    _username = AppManager.preferences.getString(AppManager.ACCOUNT);
  }

  @override
  Widget build(BuildContext context) {
    Widget userHeader = DrawerHeader(
      decoration: BoxDecoration(color: Colors.blue),
      child: InkWell(
        onTap: () => _itemClick(null),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 18.0),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo.png"),
                radius: 38.0,
              ),
            ),
            Text(
              _username ?? "请登录",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            )
          ],
        ),
      ),
    );
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        userHeader,
        InkWell(
            onTap: () => _itemClick(CollectPage()),
            child: ListTile(
              leading: Icon(Icons.favorite),
              title: Text(
                "收藏列表",
                style: TextStyle(fontSize: 16.0),
              ),
            )),
        Padding(
          padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
          child: Divider(color: Colors.grey),
        ),
        Offstage(
          offstage: _username == null,
          child: InkWell(
            onTap: () {
              setState(() {
                AppManager.preferences.setString(AppManager.ACCOUNT, null);
                Api.clearCookie();
                _username = null;
              });
            },
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("退出登录", style: TextStyle(fontSize: 16.0)),
            ),
          ),
        )
      ],
    );
  }

  void _itemClick(Widget page) {
    var dstPage = _username == null ? LoginPage() : page;
    if (dstPage != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return dstPage;
      }));
    }
  }
}

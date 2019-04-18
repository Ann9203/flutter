import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart';
import 'package:flutter_osc_client/netUtils/net_utils.dart';
import 'package:flutter_osc_client/utils/data_save_utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/cupertino.dart';

///新闻详情页
class NewsDetailPage extends StatefulWidget {
  int newsId;

  NewsDetailPage({this.newsId}) : assert(newsId != null);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  String url;
  bool isLoading = true;
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _flutterWebviewPlugin.onStateChanged.listen((data) {
      if (data.type == WebViewState.finishLoad) {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
      } else if (data.type == WebViewState.startLoad) {
        if (!mounted) return;
        setState(() {
          isLoading = true;
        });
      }
    });

    DataSaveUtils.getAccessToken().then((accessToken) {
      if (accessToken != null) {
        Map<String, dynamic> params = Map();
        params['id'] = widget.newsId;
        params['access_token'] = accessToken;
        params['dataType'] = 'json';
        NetUtils.get(AppUrls.NEWS_DETSIL_LIST, params).then((data) {
          if (data != null && data.length > 0) {
            Map<String, dynamic> params = Map();
            params = json.decode(data);
            if (!mounted) return;
            setState(() {
              url = params['url'];
              print('url:::$url');
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _flutterWebviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _appBarTitle = [
      Text(
        '新闻详情',
        style: TextStyle(color: Color(AppColors.APP_THEME_ICON_COLOR)),
      ),
    ];
    if (isLoading) {
      _appBarTitle.add(SizedBox(
        width: 10.0,
      ));
      _appBarTitle.add(CupertinoActivityIndicator());
    }
    return url == null
        ? Center(child: CupertinoActivityIndicator())
        : WebviewScaffold(
            url: url,
            appBar: AppBar(
              title: Row(
                children: _appBarTitle,
              ),
              iconTheme:
                  IconThemeData(color: Color(AppColors.APP_THEME_ICON_COLOR)),
            ),
            withJavascript: true,
            withLocalStorage: true,
            withZoom: true,
          );
  }
}

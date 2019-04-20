import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osc_client/netUtils/net_utils.dart';
import 'package:flutter_osc_client/utils/data_save_utils.dart';
import 'package:flutter_osc_client/constance/constants.dart' show AppColors, AppUrls, AppInfo;
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LoginWebPage extends StatefulWidget {
  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {

 FlutterWebviewPlugin _flutterWebviewPlugin =  FlutterWebviewPlugin();
  bool isLogin = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听url变化
    _flutterWebviewPlugin.onUrlChanged.listen((url){
          if(mounted) {
            setState(() {
              isLogin = false;
            });
          }
          //返回了code值, 在调用web网页登录成功
          if(url != null && url.length > 0 && url.contains('?code=')){
              //登录成功
              //获取code码 , 进行调用登录接口
           // https://www.dongnaoedu.com/?code=6hHYoH&state=
            print('loginWebView + $url');

              String code = url.split('?')[1].split('&')[0].split('=')[1];
              Map<String, dynamic> params = Map();
              params['client_id'] = AppInfo.CLIENT_ID;
              params['client_secret'] = AppInfo.CLIENT_SECRET;
              params['dataType'] = 'json';
              params['grant_type'] = 'authorization_code';
              params['redirect_uri'] = AppInfo.REDIRECT_URI;
              params['code'] = '$code';


              NetUtils .get(AppUrls.OAUTH2_TOKEN, params).then((data){
                print('login $data');
                if(data!= null){
                  //解析为map
                  Map<String, dynamic> info = json.decode(data);
                   DataSaveUtils.saveLoginInfo(info);
                   //返回登录信息 退出当前路由
                   Navigator.pop(context, 'refresh');
                }
              });

          }
    });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _flutterWebviewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _appbarTitle = [
      Text('登录开源中国', style: TextStyle(color: Color(AppColors.APP_THEME_ICON_COLOR)),),
    ];
    if(isLogin) {
      _appbarTitle.add(SizedBox(width: 10.0,));
      _appbarTitle.add(CupertinoActivityIndicator());

    }

//    return Scaffold(
//      appBar: AppBar(title: Text('登录'),),
//      body:Center(
//        child: Container(
//          width:  100.0,
//          height: 100.0,
//          color: Colors.green,
//        ),
//      ),
//    );
//
    return WebviewScaffold(
        url: AppUrls.OAUTH2_AUTHORIZE +
            '?response_type=code&client_id=' +
            AppInfo .CLIENT_ID +
            '&redirect_uri=' +
            AppInfo.REDIRECT_URI,
        appBar: AppBar(
          title: Row(
            children: _appbarTitle,
          ),
        ),
        withJavascript: true, //js
        withLocalStorage: true, //本地存储
       withZoom: true , //是否可以放大缩小
    );


  //  return WebviewScaffold(url: 'http://wwww.baidu.com', appBar: AppBar(title: Text('登录'),));
  }
}



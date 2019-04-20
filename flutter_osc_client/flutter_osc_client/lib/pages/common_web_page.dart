import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart' show AppInfo , AppColors;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/cupertino.dart';

class CommonWebPage extends StatefulWidget {
  String title;
  String url;
  CommonWebPage({
    this.title,
    this.url})
      :assert(title != null),
      assert(url != null);



  @override
  _CommonWebPageState createState() => _CommonWebPageState();
}

class _CommonWebPageState extends State<CommonWebPage> {


  FlutterWebviewPlugin _flutterWebviewPlugin =  FlutterWebviewPlugin();
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听url变化
   _flutterWebviewPlugin.onStateChanged.listen((state){
     if(state.type == WebViewState.finishLoad){
       if(!mounted) return;
       setState(() {
         isLoading = false;
       });
     } else if(state.type == WebViewState.startLoad){
       if(mounted){
         setState(() {
           isLoading = true;
         });
       }
     }

   });


  }


  @override
  Widget build(BuildContext context) {

    List<Widget> _appBarTitle = [
      Text(widget.title, style: TextStyle(color: Color(AppColors.APP_THEME_ICON_COLOR)),),
    ];
    if(isLoading){
      _appBarTitle.add(SizedBox(
        width: 10.0,
      ));
      _appBarTitle.add(CupertinoActivityIndicator());
    }


    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title:Row(children: _appBarTitle,),

        iconTheme: IconThemeData(color: Color(AppColors.APP_THEME_ICON_COLOR)),
      ),
      withJavascript: true, //js
      withLocalStorage: true, //本地存储
      withZoom: true , //是否可以放大缩小
    );

  }
}

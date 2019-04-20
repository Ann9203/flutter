import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart';
import 'package:flutter_osc_client/utils/data_save_utils.dart';
import 'package:flutter_osc_client/utils/event_bus_utils.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置', style: TextStyle(color: Color(AppColors.APP_THEME_ICON_COLOR), fontSize: 20.0),),
        iconTheme: IconThemeData(color: Color(AppColors.APP_THEME_ICON_COLOR)),
      ),
      body: Center(
        child: FlatButton(
            color: Colors.green,
            onPressed: (){
              DataSaveUtils.clearLoginInfo().then((_){
                eventBus.fire(LogoutEvent());
                Navigator.of(context).pop(); //退出
              });
            },
            child: Text('退出登录', style: TextStyle(fontSize: 20.0),)),
      ),
    );
  }
}

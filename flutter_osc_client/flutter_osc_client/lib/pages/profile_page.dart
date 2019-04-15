import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_osc_client/constance/constants.dart'
    show AppColors, AppUrls;
import 'package:flutter_osc_client/netUtils/net_utils.dart';
import 'package:flutter_osc_client/pages/user_detain_info_page.dart';
import 'package:flutter_osc_client/pages/web_login_page.dart';
import 'package:flutter_osc_client/utils/data_save_utils.dart';
import 'package:flutter_osc_client/utils/event_bus_utils.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName;
  String userIcon;

  List menuTitle = ['我的消息', '阅读记录', '我的博客', '我的问题', '我的活动', '我的团队', '邀请好友'];
  List menuIcons = [
    CupertinoIcons.group,
    Icons.receipt,
    Icons.book,
    Icons.question_answer,
    Icons.airplanemode_active,
    CupertinoIcons.group,
    CupertinoIcons.share
  ];

  ///   * 登录

  void _login() async {
    // Navigator.push(context, MaterialPageRoute(builder:(context)=> LoginWebPage()));

    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()));

    if (result != null && result == 'refresh') {
      ///登录成功 eventBus 通知
      eventBus.fire(LoginEvent());
    }
  }

  ///在缓存中获取信息
  void _showUserInfo() {
    DataSaveUtils.getUserInfo().then((userInfo){

      if(userInfo != null){
        userIcon = userInfo.avatar;
        userName = userInfo.name;
      } else {
         userIcon = null;
         userName = null;
      }
    });
  }

  ///请求用户信息
  void _getUserInfo() {
    //如果登录
    DataSaveUtils.getAccessToken().then((accessToken) {
      if (accessToken != null && accessToken.length != 0) {
        Map<String, dynamic> params = Map();
        params['access_token'] = accessToken;
        params['dataType'] = 'json';
        NetUtils.get(AppUrls.OPENAPI_USER, params).then((userData) {
          print('userInfo $userData');
          //保存用户信息
          Map<String, dynamic> dataMap = json.decode(userData);
          if (dataMap != null && dataMap.isNotEmpty) {
            if (mounted) {
              setState(() {
                userName = dataMap['name'];
                userIcon = dataMap['avatar'];
              });
            }
            DataSaveUtils.saveUserInfo(dataMap);
          }
        });
      }
    });
  }

  ///* 初始化
  /// * 1. 登录信息
  ///* 2.判断是否登录 登录获取登录信息
  /// *
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showUserInfo();
    eventBus.on<LoginEvent>().listen((event) {
      //TODO 显示用户信息
      _getUserInfo();
    });
    eventBus.on<LogoutEvent>().listen((event) {
      //TODO 退出登录
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  color: Color(AppColors.APP_THEME_COLOR),
                  height: 180.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: userIcon != null
                            ? Container(
                                width: 60.0,
                                height: 60.0,
                                //boxDecoration 盒子  盒子中的image  需要使用DecorationImage
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, //圆
                                    border: Border.all(
                                        color: Color(
                                            AppColors.APP_THEME_ICON_COLOR),
                                        width: 2.0), //border 宽度
                                    image: DecorationImage(
                                        image: NetworkImage(userIcon),
                                        fit: BoxFit.cover)),
                              )
                            : Image.asset(
                                'assets/images/ic_avatar_default.png',
                                fit: BoxFit.cover,
                                width: 60.0,
                                height: 60.0,
                              ),
                        onTap: (){

                          DataSaveUtils.isLogin().then((isLogin){
                             if(isLogin){
                               ///登录了需要显示个人详情
                               Navigator.of(context).push(MaterialPageRoute(builder:(context)=>UserInfoDetailPage()));
                             } else {
                               _login();
                             }
                          });

                        }
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(userName != null ? userName : '点击登录',
                          style: TextStyle(
                            color: Color(AppColors.APP_THEME_ICON_COLOR),
                          )),
                    ],
                  ),
                );
              }
              index = index - 1;

              return ListTile(
                title: Text(menuTitle[index]),
                leading: Icon(menuIcons[index]),
                trailing: Icon(CupertinoIcons.forward),
              );
            },
            separatorBuilder: (context, index) {
              if (index == 0) {
                return Divider(
                  height: 0.0,
                );
              } else {
                return Divider(
                  height: 1.0,
                );
              }
            },
            itemCount: menuIcons.length + 1));
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart' show AppColors, AppUrls;
import 'package:flutter_osc_client/models/my_infomation.dart';
import 'package:flutter_osc_client/netUtils/net_utils.dart';
import 'package:flutter_osc_client/utils/data_save_utils.dart';
import 'package:flutter/cupertino.dart';

class UserInfoDetailPage extends StatefulWidget {
  @override
  _UserInfoDetailPageState createState() => _UserInfoDetailPageState();
}

class _UserInfoDetailPageState extends State<UserInfoDetailPage> {

  MyUserInfo _myUserInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserDetailInfo();
  }


  ///获取用户信息
  void _getUserDetailInfo(){
    DataSaveUtils.getAccessToken().then((accessToken){
      print('accessToken: $accessToken');
      if(accessToken != null && accessToken .length > 0){
        Map<String, dynamic> params = new Map();
        params['access_token'] = accessToken;
        params['dataType'] ='json';
        NetUtils.post(AppUrls.MY_INFORMATION, params).then((userDetailInfo){
          //获取用户详情
          if(userDetailInfo != null && userDetailInfo.length > 0){
            Map<String, dynamic> mapUserInfo = json. decode(userDetailInfo);
            if(mapUserInfo != null && mapUserInfo.isNotEmpty){
              MyUserInfo  myUserInfo = new MyUserInfo();
              myUserInfo.uid = mapUserInfo['uid'];
              myUserInfo.notice = mapUserInfo['notice'];
              myUserInfo.followersCount = mapUserInfo['followersCount'];
              myUserInfo.favoriteCount = mapUserInfo['favoriteCount'];
              myUserInfo.fansCount = mapUserInfo['fansCount'];
              myUserInfo.portrait = mapUserInfo['portrait'];
              myUserInfo.lastLoginTime = mapUserInfo['lastLoginTime'];
              myUserInfo.joinTime = mapUserInfo['joinTime'];
              myUserInfo.expertise = mapUserInfo['expertise'];
              myUserInfo.platforms = mapUserInfo['platforms'];
              myUserInfo.city = mapUserInfo['city'];
              myUserInfo.province = mapUserInfo['province'];
              myUserInfo.gender = mapUserInfo['gender'];
              myUserInfo.name = mapUserInfo['name'];
              setState(() {
                _myUserInfo = myUserInfo;
              });
            }
          }
        });
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的资料' , style: TextStyle(fontSize: 20.0, color: Color(AppColors.APP_THEME_ICON_COLOR)),),
        iconTheme: IconThemeData(color: Color(AppColors.APP_THEME_ICON_COLOR)),
      ),
      body: Container(
          child:
            SingleChildScrollView(
                child: _myUserInfo== null?
                Center(
                  child:  CupertinoActivityIndicator()
                )
                :Column(
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              margin: const EdgeInsets.only(left: 20.0),
                              padding: const EdgeInsets.only(top: 10.0, right: 20.0,bottom: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '头像',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  Container(
                                    width: 60.0,
                                    height: 60.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Color(AppColors.APP_THEME_ICON_COLOR), width: 2.0),
                                        image: DecorationImage(image: NetworkImage(_myUserInfo.portrait), fit: BoxFit.cover)

                                      ),
                                  )
                                ],

                              ),
                            ),
                          ),
                          Divider(),
                          _buildInkWell('昵称',_myUserInfo.name.toString(), false),
                          Divider(),
                          _buildInkWell('加入时间',_myUserInfo.joinTime.toString(), false),
                          Divider(),
                          _buildInkWell('所在地区',_myUserInfo.city.toString(), false),
                          Divider(),
                          _buildInkWell('开发平台',_myUserInfo.platforms.toString(), true),
                          Divider(),
                          _buildInkWell('专长领域',_myUserInfo.expertise.toString(), true),
                          Divider(),
                          _buildInkWell('粉丝数',_myUserInfo.fansCount.toString(), false),
                          Divider(),
                          _buildInkWell('收藏数',_myUserInfo.favoriteCount.toString(), false),
                          Divider(),
                          _buildInkWell('关注数', _myUserInfo.followersCount.toString(), false)
                        ],
                    ),
            ),
      ),
    );
  }

  ///动态构建条目
  InkWell _buildInkWell(String name, String value, bool isExpended) {
    return InkWell(
                          onTap: (){},
                          child: Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            padding: const EdgeInsets.only(right: 20.0,top: 10.0, bottom: 10.0),
                            child: Row(
                              crossAxisAlignment:  CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(name, style: TextStyle(fontSize: 15.0),),
                                isExpended?
                                    Expanded(child: Text(value, textAlign: TextAlign.right, maxLines: 1, style: TextStyle(fontSize: 15.0),))
                                    :Text(value, style: TextStyle(fontSize: 15.0, ),)
                              ],
                            ),
                          ),
                        );
  }
}

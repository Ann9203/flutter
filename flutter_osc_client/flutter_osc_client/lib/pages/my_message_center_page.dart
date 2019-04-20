import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart';
import 'package:flutter_osc_client/netUtils/net_utils.dart';
import 'package:flutter_osc_client/utils/data_save_utils.dart';
import 'package:flutter/cupertino.dart';

class MyMessageCentrPage extends StatefulWidget {
  @override
  _MyMessageCentrPageState createState() => _MyMessageCentrPageState();
}

///消息中心
class _MyMessageCentrPageState extends State<MyMessageCentrPage> {
  List<String> _tabTitle = ['@我', '评论', '私信'];
  List messageList ;
  int curPage = 1;


  ///获取消息
  void _getMessageList(){
      DataSaveUtils.isLogin().then((isLogin){
        if(isLogin){
          DataSaveUtils.getAccessToken().then((accessToken){
            print('access: $accessToken');

            Map<String, dynamic> params = Map<String, dynamic>();
            params['page'] = curPage;
            params['pageSize'] = 20;
            params['access_token'] = accessToken;
            params['dataType'] = 'json';
            print('message: ${params.toString()}');

            NetUtils.get(AppUrls.MESSAGE_LIST, params).then((resInfo){
              //返回结果
              print('message: $resInfo');
              if(resInfo != null && resInfo.length >0){
                Map<String, dynamic> dataInfoMap = json.decode(resInfo);
                var _messageList = dataInfoMap['messageList'];
                setState(() {
                  messageList = _messageList;
                });

              }
            });
          });

         }
      });
  }

  ///刷新获取消息
  Future<Null> _pullToRefresh() async{
    curPage = 1;
    _getMessageList();
    return null;

  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabTitle.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('消息中心',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(AppColors.APP_THEME_ICON_COLOR))),
          iconTheme:
              IconThemeData(color: Color(AppColors.APP_THEME_ICON_COLOR)),
          bottom: TabBar(
              tabs: _tabTitle
                  .map((title) => Tab(
                        text: title,
                      ))
                  .toList()),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text('暂无内容'),
            ),
            Center(
              child: Text('暂无内容'),
            ),
            _buildRefreshIndicator()
          ],
        ),
      ),
    );
  }

   _buildRefreshIndicator() {
    if(messageList == null){
      _getMessageList();
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return RefreshIndicator(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Image.network(messageList[index]['portrait']),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '${messageList[index]['sendername']}',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${messageList[index]['pubDate']}',
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color:
                                      Color(AppColors.APP_MIN_SIZE_COLOR)),
                                )
                              ],
                            ),
                            Text(
                              '${messageList[index]['content']}',
                              style: TextStyle(fontSize: 12.0),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, indext) {
                return Divider();
              },
              itemCount: messageList.length,
            ),
            onRefresh: _pullToRefresh,
          );
  }
}

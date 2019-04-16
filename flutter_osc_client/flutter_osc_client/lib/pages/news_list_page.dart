import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_osc_client/netUtils/net_utils.dart';
import 'package:flutter_osc_client/pages/web_login_page.dart';
import 'package:flutter_osc_client/utils/data_save_utils.dart';
import 'package:flutter_osc_client/utils/event_bus_utils.dart';
import 'package:flutter_osc_client/widgets/new_list_item.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  bool isLogin = false;
  int currentPage = 1;
  List newsList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///判断是会否登录
    DataSaveUtils.isLogin().then((isLogin){
      if(!mounted) return;
      setState(() {
        this.isLogin = isLogin;
      });
    });

    ///监听登出
    eventBus.on<LogoutEvent>().listen((event){
      setState(() {
        this.isLogin = false;
      });
    });

    //监听登录
    eventBus.on<LoginEvent>().listen((event){
      setState(() {
        this.isLogin = true;
      });
      getNewList(false);
    });
  }



  @override
  Widget build(BuildContext context) {
    ///没有登录去登录
    if(!isLogin){
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('由于openApi的限制, 必须登录才获取资讯!'),
              InkWell(
                onTap: _gotoLogin,
                child: Text('去登陆'),
              )
            ],
          ),
        ),
      );
    }


    return Scaffold(
        body: RefreshIndicator(
            child: _buildWidget(),
            onRefresh:_pullToRefresh,
        )
    );
  }
 Future<Null> _pullToRefresh() async{
    currentPage = 1;
    getNewList(false);
  }

  ///去登陆
  _gotoLogin()async{
   final result =  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginWebPage()));
   // ignore: unrelated_type_equality_checks
   if(result != null && result == 'refresh'){
     eventBus.fire(LoginEvent());
   }
  }
  _buildWidget() {
    if (newsList == null) {
      //TODO 获取数据
      getNewList(false);
      return CupertinoActivityIndicator();
    }

    return ListView.builder(
        itemBuilder: (contex, index) {
      return NewsListItem(newsList: newsList[index]);
    },
      itemCount: newsList.length,
    );
  }

  ///加载数据
  getNewList(bool isLoadMore) {
    DataSaveUtils.isLogin().then(((isLogin){
      if(isLogin){
        DataSaveUtils.getAccessToken().then((accessToken){
          if(accessToken != null && accessToken.length >0){
            Map<String, dynamic> params = Map();
            params['access_token'] = accessToken;
            params['catalog'] = 1;
            params['page'] = currentPage;
            params['pageSize'] = 20;
            params['dataType'] = 'json';

            NetUtils.get(AppUrls.NEWS_LIST, params).then((data){

              if(data != null && data.length > 0){
                Map<String, dynamic> requestInfo = json.decode(data);
                List _newsList ;
                _newsList = requestInfo['newslist'];
                setState(() {
                  if(!mounted) return;
                  if(isLoadMore){
                    newsList.addAll(_newsList);
                  } else {
                    newsList = _newsList;
                  }
                });
              }
            });
          }


        });
      }

    }));
  }
}



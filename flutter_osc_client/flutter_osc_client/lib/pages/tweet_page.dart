import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart';
import 'package:flutter_osc_client/netUtils/net_utils.dart';
import 'package:flutter_osc_client/pages/web_login_page.dart';
import 'package:flutter_osc_client/utils/data_save_utils.dart';
import 'package:flutter_osc_client/utils/event_bus_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_osc_client/widgets/tweet_item_widget.dart';

class TweetPage extends StatefulWidget {
  @override
  _TweetPageState createState() => _TweetPageState();
}

class _TweetPageState extends State<TweetPage>
    with SingleTickerProviderStateMixin {
  List _tabTitle = ['最新', '热门'];
  List _lastTweetList;
  List _hotTweetList;
  int curretnPage = 1;
  int pageSize = 20;
  ScrollController _scrollController = ScrollController();
  TabController _tabController;

  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _tabTitle.length, vsync: this);
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var piexls = _scrollController.position.pixels;
      if (piexls == maxScroll) {
        curretnPage++;
        Future.delayed(Duration(seconds: 3),(){
          getTweetList(true, true);
        });


      }
    });

    ///判断是会否登录
    DataSaveUtils.isLogin().then((isLogin) {
      if (!mounted) return;
      setState(() {
        this.isLogin = isLogin;
      });
    });

    ///监听登出
    eventBus.on<LogoutEvent>().listen((event) {
      if (!mounted) true;
      setState(() {
        this.isLogin = false;
      });
    });

    //监听登录
    eventBus.on<LoginEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = true;
      });
      //登录成功
      getTweetList(false, false);
    });
  }

  ///获取动态列表
  getTweetList(bool isLoadMore, bool isHost) {
    DataSaveUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataSaveUtils.getAccessToken().then((accessToken) {
          if (accessToken == null || accessToken.length == 0) {
            return;
          }

          Map<String, dynamic> params = Map();
          params['access_token'] = accessToken;
          params['user'] = isHost ? -1 : 0;
          params['pageSize'] = pageSize;
          params['page'] = curretnPage;
          params['dataType'] = 'json';
          NetUtils.get(AppUrls.TWEET_LIST, params).then((data) {
            print('data${data}');
            if (data != null && data.length > 0) {
              Map<String, dynamic> dataMap = json.decode(data);
              if (dataMap != null && dataMap.length > 0) {
                List _tweetList = dataMap['tweetlist'];
                if (!mounted) return;
                setState(() {
                  if (isLoadMore) {
                    if (isHost) {
                      _hotTweetList.addAll(_tweetList);
                    } else {
                      _lastTweetList.addAll(_tweetList);
                    }
                  } else {
                    if (isHost) {
                      _hotTweetList = _tweetList;
                    } else {
                      _lastTweetList = _tweetList;
                    }
                  }
                });
              }
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogin) {
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
    return Column(
      children: <Widget>[
        Container(
          color: Color(AppColors.APP_THEME_COLOR),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Color(AppColors.APP_THEME_ICON_COLOR),
            labelColor: Color(AppColors.APP_THEME_ICON_COLOR),
            tabs: _tabTitle.map((title) {
              return Tab(
                text: title,
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [_buildLastWidget(), _buildHostWidget()],
            controller: _tabController,
          ),
        )
      ],
    );
  }

  ///去登陆
  _gotoLogin() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()));

    if (result != null && result == 'refresh') {
      ///登录成功 eventBus 通知
      eventBus.fire(LoginEvent());
    }
  }

  ///最新  可以加載更多
  Widget _buildHostWidget () {
    if (_hotTweetList == null) {
      getTweetList(false, true);
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }

    return RefreshIndicator(
      child: ListView.separated(
        controller: _scrollController,
          itemBuilder: (context, index) {
            if (index == _hotTweetList.length) {
              ///尾部句
              return Container(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CupertinoActivityIndicator(),
                    Text('上拉加载更多')
                  ],
                ),
              );
            }
            return TweetItemWidget(
              infomation: _hotTweetList[index],
            );
          },
          separatorBuilder: (context, indext) {
            return Container(
              height: 1.0,
              color: Color(AppColors.APP_LINE1_COLOR),
            );
          },
          itemCount: _hotTweetList.length+1),
      onRefresh: _pullToRefresh,
    );
  }

  ///热门 应该就只有十条数据
  Widget _buildLastWidget () {
    if (_lastTweetList == null) {
      getTweetList(false, false);
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }

    return ListView.builder(
        itemBuilder: (context, indext) {
      return TweetItemWidget(
        infomation: _lastTweetList[indext],
      );
    },
    itemCount: _lastTweetList.length,);

  }

  ///下拉刷新必须有事异步操作
  Future<Null> _pullToRefresh() async {
    curretnPage = 1;
    getTweetList(false, false);
    return null;
  }
}

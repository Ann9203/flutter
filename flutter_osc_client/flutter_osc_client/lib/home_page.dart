import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart' show AppColors;
import 'package:flutter_osc_client/pages/discover_page.dart';
import 'package:flutter_osc_client/pages/news_list_page.dart';
import 'package:flutter_osc_client/pages/profile_page.dart';
import 'package:flutter_osc_client/pages/tweet_page.dart';
import 'package:flutter_osc_client/widgets/bottom_navigation_view.dart';
import 'package:flutter_osc_client/widgets/drawer_view.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}
//SafeArea : 水滴屏  刘海平
//mainActivity
//1. title 每个页面title名称不一样 白色
//2.去掉右边的标签
//3.抽屉效果 //自定义
//4.ViewPager controler 自定义
//5.bottom  自定义

class _HomePageState extends State<HomePage> {
  var _appTitle = ['资讯','动弹','发现','我的'];
  var _currentCount = 0;
  PageController _pageController;
  /*底部自定义布局*/
  List<BottomNavigationView> _bottomNavigationItems;
  /*viewpage自定义布局*/
  List<Widget> _pageViews;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _currentCount);
    _bottomNavigationItems = [
       new BottomNavigationView(
           title: _appTitle[0],
           iconPath:'assets/images/ic_nav_news_normal.png',
           activeIconPath: 'assets/images/ic_nav_news_actived.png' ),
       new BottomNavigationView(
           title: _appTitle[1],
           iconPath:'assets/images/ic_nav_tweet_normal.png',
           activeIconPath: 'assets/images/ic_nav_tweet_actived.png' ),
       new BottomNavigationView(
           title: _appTitle[2],
           iconPath:'assets/images/ic_nav_discover_normal.png',
           activeIconPath: 'assets/images/ic_nav_discover_actived.png' ),
       new BottomNavigationView(
           title: _appTitle[3],
           iconPath:'assets/images/ic_nav_my_normal.png',
           activeIconPath: 'assets/images/ic_nav_my_pressed.png' ),
    ];

    _pageViews = [
      NewsListPage(), //资讯
      TweetPage(), //动弹
      DiscoverPage(), //发现
      ProfilePage(), //个人中心

    ];


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(_appTitle[_currentCount] , style: TextStyle(color: Color(AppColors.APP_THEME_ICON_COLOR) ),),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(AppColors.APP_THEME_ICON_COLOR) ),
      ),
      body:PageView.builder(
         physics: NeverScrollableScrollPhysics(),
         controller: _pageController,
          itemBuilder: (context, index) => _pageViews[index],
          itemCount: _pageViews.length,
          onPageChanged: (index){
            setState(() {
              _currentCount = index;
            });
          },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentCount,
        type: BottomNavigationBarType.fixed ,
        items: _bottomNavigationItems.map((BottomNavigationView view) => view.item).toList(),
        onTap: (index){
          setState(() {
            _currentCount = index;
          });
          _pageController.animateToPage(_currentCount, duration: const Duration(microseconds: 1), curve: Curves.ease);
        },
      ),
      drawer: MyDrawer(
        headPath: 'assets/images/cover_img.jpg',
        menuIcon: [Icons.send, Icons.home, Icons.error, Icons.settings],
        titles: ['发布动弹','动弹小黑屋','关于', '设置'],

      ),

    );
  }
}




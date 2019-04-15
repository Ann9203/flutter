import 'package:flutter/material.dart';
import 'package:flutter_osc_client/pages/about_page.dart';
import 'package:flutter_osc_client/pages/publish_tweet_page.dart';
import 'package:flutter_osc_client/pages/setting_page.dart';
import 'package:flutter_osc_client/pages/tweet_black_house_page.dart';

class  MyDrawer extends StatelessWidget{
  final String headPath;
  final List menuIcon;
  final List<String> titles;
  
  
  MyDrawer({this.headPath, this.menuIcon, this.titles})
   :assert(headPath != null),
    assert(menuIcon != null),
    assert(titles != null);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView.separated(
        padding: EdgeInsets.all(0.0), //解决状态栏问题
          itemBuilder: (context, index){
            if(index == 0){
              return Image.asset(headPath, fit: BoxFit.cover, );
            }
             index = index - 1;
            return ListTile(
              title: Text(titles[index], style: TextStyle(fontSize: 16.0),),
              leading: Icon(menuIcon[index]),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                //TODO 
                switch(index){
                  case 0:
                    _navPush(context, PublishTweetPage());
                    break;
                  case 1:
                    _navPush(context, TweetBlackHousePage());
                    break;
                  case 2:
                    _navPush(context, AboutPage());
                    break;
                  case 3:
                    _navPush(context, SettingPage());

                    break;
                }
                
              },

              
            );
          }, 
          separatorBuilder: (context, index){
            if(index == 0){
              return Divider(height: 0.0,);
            } else {
              return Divider(height: 1.0,);
            }
          },
          itemCount: menuIcon.length+1),
    );
  }
  
  
  //路由跳转
 _navPush(BuildContext context, Widget page){
    Navigator.push(context, MaterialPageRoute(builder:(context)=> page));
 }
  
}
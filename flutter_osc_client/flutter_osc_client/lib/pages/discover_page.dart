 import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_osc_client/constance/constants.dart';
import 'package:flutter_osc_client/pages/common_web_page.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  List<Map<String, String>> _discoverList = [
    {"开源软件": 'assets/images/soft.png',
      "码云推荐": 'assets/images/githubcode.png',
      "代码片段": 'assets/images/code.png'},
    {"扫一扫": 'assets/images/scan.png',
      "摇一摇": 'assets/images/shake.png',},
    {"码云封面人物": 'assets/images/people.png',
      "线下活动": 'assets/images/activity.png',},
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('发现', style: TextStyle(color: Color(AppColors.APP_THEME_ICON_COLOR)),),
              iconTheme: IconThemeData(color: Color(AppColors.APP_THEME_ICON_COLOR)),
            ),
          body: ListView.builder(
              itemBuilder: (context, _outIndex){
                //listView
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1.0,
                        color: Color(AppColors.APP_LINE_COLOR),
                      ),
                      bottom: BorderSide (
                         width: 1.0,
                         color: Color(AppColors.APP_LINE_COLOR),

                      )
                    )
                  ),
                  child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),//解决滑动痛处
                      shrinkWrap: true, // 多层嵌套必须开启
                      itemBuilder: (context, index){
                          return InkWell(
                            onTap: (){
                              _loadWebCommon(_discoverList[_outIndex].keys.elementAt(index) );
                            },
                            child: Container(
                              height: 60.0,
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                              child: ListTile(
                               title: Text('${ _discoverList[_outIndex].keys.elementAt(index)}', style: TextStyle(fontSize: 18.0)) ,
                                leading: Image.asset(_discoverList[_outIndex].values.elementAt(index), width: 30.0, height: 30.0, fit: BoxFit.cover
                                  ,), //Image.asset(),
                                trailing: Icon(Icons.arrow_forward_ios) ,
                              ),
                            ),
                          );
                      },
                      separatorBuilder: (context,index)=>Divider(height: 1.0, color: Color(AppColors.APP_LINE_COLOR),) ,
                      itemCount: _discoverList[_outIndex].length),
                );
           },
            itemCount: _discoverList.length,
          )
          ,

      );

  }

  ///前往公共的web页面
  _loadWebCommon(String title){
    String url ;
    switch(title){
      case '开源软件':
        url = 'https://zb.oschina.net/';
        break;
      case '码云推荐':
        url = 'https://gitee.com/?from=osc-top';
        break;
      case'代码片段':
        url = 'https://zb.oschina.net/projects/list.html';
        break;
      case'码云封面人物':
        url = 'https://www.oschina.net/blog?tab=recommend';
        break;
      case'线下活动':
        url = 'https://www.oschina.net/event?tab=latest&city=%E5%85%A8%E5%9B%BD&time=all';
        break;

      case '摇一摇':
        break;
      case '扫一扫':
        break;


    }
    if(!title.contains('摇一摇')  && !title.contains('扫一扫') ){
      _nativeTowWebPage(title, url);
    }

  }

  _nativeTowWebPage(String title, String url){
    if(url != null && title != null){
      Navigator.of(context).push(MaterialPageRoute(builder:(context) => CommonWebPage(title: title, url: url,)));
    }
  }
}

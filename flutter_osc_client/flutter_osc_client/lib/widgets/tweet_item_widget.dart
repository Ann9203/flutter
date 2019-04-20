import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart';

class TweetItemWidget extends StatelessWidget {
//"id": 1121274,
//"pubDate": "2013-08-28 18:40:07.0",
//"body": "@做最好的三三",
//"author": "彭博",
//"authorid": 89964,
//"commentCount": 0,
//"portrait": "http://static.oschina.net/uploads/user/44/89964_50.jpg?t=1376365607000"

  Map<String, dynamic> infomation;

  TweetItemWidget({this.infomation}) : assert(infomation != null);
  final RegExp regExp1 = new RegExp("</.*>");
  final RegExp regExp2 = new RegExp("<.*>");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildPartOne(),
          _buildPartTwo(),
          _buildPartThree(context),
          _buildPartFour(),
          Container(
            color: Color(AppColors.APP_LINE1_COLOR),
            height: 8.0,
          )
        ],
      ),
    );
  }

  ///第一部分头像 昵称 日期
  Widget _buildPartOne() {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 12.0,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(infomation['portrait'], scale: 1.5),
            ),
            SizedBox(
              width: 5.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  infomation['author'],
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  infomation['pubDate'],
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Color(AppColors.APP_MIN_SIZE_COLOR)),
                )
              ],
            )
          ],
        ));
  }

  ///第二部分 文字内容
  Widget _buildPartTwo() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Text(
        '${_clearHtmlContent(infomation['body'])}',
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
    );
  }

  ///第三部分图片部分
  Widget _buildPartThree(BuildContext context) {
    String _imSmall = infomation['imgSmall'];
    if ((_imSmall != null && _imSmall.length > 0)) {
      List<String> imgs = _imSmall.split(",");
      List<String> imgUrlList = new List();
      for (String s in imgs) {
        if (s.startsWith('https://static.oschina.net/uploads/space/https')) {
         s =  s.replaceAll('https://static.oschina.net/uploads/space/', '');
        }
        imgUrlList.add(s);
      }

      List<Widget> imgList = [];
      List<List<Widget>> rows = [];
      num length = imgUrlList.length;
      for (var row = 0; row < _getRow(length); row++) {
        List<Widget> rowArr = [];
        for (var col = 0; col < 3; col++) {
          num index = row * 3 + col;
          num screenWidth = MediaQuery.of(context).size.width;
          double cellWidth = (screenWidth - 100) / 3;
          if (index < length) {
            rowArr.add(Padding(
              padding: const EdgeInsets.all(2.0),
              child: new Image.network(
                imgUrlList[index],
                width: cellWidth,
                height: cellWidth,
              ),
            ));
          }
        }
        rows.add(rowArr);
      }

      for (var row in rows) {
        imgList.add(new Row(
          children: row,
        ));
      }

      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: imgList,
        ),
      );
    }
    return SizedBox(
      height: 5.0,
    );
  }

  ///第四部分
  _buildPartFour() {
    return Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.exit_to_app,
                  size: 16.0,
                  color: Color(AppColors.APP_MIN_SIZE_COLOR),
                ),
                Text(
                  '转发',
                  style: TextStyle(
                      color: Color(AppColors.APP_MIN_SIZE_COLOR),
                      fontSize: 14.0),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.message,
                  color: Color(AppColors.APP_MIN_SIZE_COLOR),
                  size: 16.0,
                ),
                Text(
                  '${infomation['commentCount']}',
                  style: TextStyle(
                      color: Color(AppColors.APP_MIN_SIZE_COLOR),
                      fontSize: 14.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.thumb_up,
                  color: Color(AppColors.APP_MIN_SIZE_COLOR),
                  size: 16.0,
                ),
                Text(
                  '赞',
                  style: TextStyle(
                      color: Color(AppColors.APP_MIN_SIZE_COLOR),
                      fontSize: 14.0),
                ),
              ],
            ),
          ],
        ));
  }

  ///去掉文件中html代码的部分
  _clearHtmlContent(String str) {
    if (str.startsWith("<emoji")) {
      return "[emoji]";
    }
    var s = str.replaceAll(regExp1, "");
    s = s.replaceAll(regExp2, "");
    s = s.replaceAll("\n", "");
    return s;
  }

  ///获取图片的行数
  _getRow(int n) {
    int a = n % 3;
    int b = n ~/ 3;
    if (a != 0) {
      return b + 1;
    }
    return b;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart';
import 'package:flutter_osc_client/pages/news_detail_page.dart';

class NewsListItem extends StatelessWidget {
  final Map<String, dynamic> newsList;

  NewsListItem({this.newsList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsDetailPage(newsId: newsList['id'],)));
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1.0,
          color: Color(AppColors.APP_LINE_COLOR),
        ))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${newsList['title']}', maxLines: 1, overflow: TextOverflow.ellipsis,),

            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Text(
                    '@${newsList['author']} ${newsList['pubDate'].toString().split(' ')[0]}'),
                Row(
                  children: <Widget>[
                    Text('${newsList['commentCount']}'),
                    Icon(
                      Icons.mail_outline,
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

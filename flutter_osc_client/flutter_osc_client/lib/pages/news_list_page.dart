import 'package:flutter/material.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          child: Text('资讯')
        ),
      ),
    );
  }
}

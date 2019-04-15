import 'package:flutter/material.dart';

class TweetPage extends StatefulWidget {
  @override
  _TweetPageState createState() => _TweetPageState();
}

class _TweetPageState extends State<TweetPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: 200.0,
            height: 200.0,
            child: Text('动弹')
        ),
      ),
    );
  }
}

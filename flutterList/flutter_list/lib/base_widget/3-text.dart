import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: Scaffold(
          appBar: AppBar(
          title: Text('Text实例'),
      ),
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Text('糖豆最美最漂亮最可耐哈哈哈哈哈!!!糖豆最美最漂亮最可耐哈哈哈哈哈!!!糖豆最美最漂亮最可耐哈哈哈哈哈!!!糖豆最美最漂亮最可耐哈哈哈哈哈!!!',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,//自动换行//
              style: TextStyle(
              decoration: TextDecoration.lineThrough,
              decorationStyle: TextDecorationStyle.wavy
              ),

              ),
              SizedBox(
              height: 20.0,
              ),
              RichText(
                text: TextSpan(
                text: 'lallalalallala',
                style: TextStyle(color: Colors.green, fontSize: 20.0),
                children: <TextSpan>[
                    TextSpan(
                    text: 'doudoudoudodudou',
                    recognizer: TapGestureRecognizer()..onTap = (){
                      String url = 'https://baidu.com';}
                    ),
                  ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


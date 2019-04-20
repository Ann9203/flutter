import 'package:flutter/material.dart';
import 'package:flutter_list/base_widget/SwipeToDissmissDemo.dart';

void main()=>runApp(new MyApp());

//class MyApp extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return  MaterialApp(
//      title: '糖豆豆',
//      theme:  ThemeData.dark(),
//      home: SwipeToDissmissDemo(),
//    );
//  }
//
//}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '豆豆',
      theme: ThemeData.dark(),
      home: SwipeToDissmissDemo(),
    );
  }
}



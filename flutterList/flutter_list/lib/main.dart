import 'package:flutter/material.dart';
import 'SwipeToDissmissDemo.dart';

void main()=>runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  MaterialApp(
      title: '动脑学院',
      theme:  ThemeData.dark(),
      home: SwipeToDissmissDemo(),
    );
  }

}


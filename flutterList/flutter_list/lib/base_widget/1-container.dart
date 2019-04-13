import 'package:flutter/material.dart';

void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('豆'),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 30.0),
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 10.0),
              borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
            ),
            child: Text('Container', style: TextStyle(fontSize: 20),),
            transform: Matrix4.skew(0.5,10.0),
        ),
        ),
      ),
    );
  }
}

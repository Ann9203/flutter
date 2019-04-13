import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    home: MyDedmo(),
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform(transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(_offset.dy*0.01)
        ..rotateY(_offset.dx*0.01)
          ..rotateZ(_offset.dx*0.01),
        child: GestureDetector(
          onPanUpdate: (detail){
            setState(() {
              _offset += detail.delta;
            });
          },
          onDoubleTap: (){
            setState(() {
              _offset = Offset.zero;
            });
          },

          child: Container(
            width: 100.0,
            height: 100.0,
            color: Colors.deepOrange,
          ),
        ),
        ),
      ),

    );
  }
}

class MyDedmo extends StatefulWidget {
  @override
  _MyDedmoState createState() => _MyDedmoState();
}

/**
 *  center  Scaffold  Transform
 */
class _MyDedmoState extends State<MyDedmo> {
  Offset _offset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
          child: Transform(transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_offset.dy*0.01)
            ..rotateY(_offset.dx*0.01),
            child:  GestureDetector(
              onPanUpdate: (detail){
                setState(() {
                  _offset += detail.delta;
                });
              },
              onDoubleTap: (){
                setState(() {
                  _offset = Offset.zero;
                });
              },
              child: Container(
                width: 100.0,
                height: 100.9,
                color: Colors.deepOrange,
              ),
            ),)
      ),
    );



  }
}


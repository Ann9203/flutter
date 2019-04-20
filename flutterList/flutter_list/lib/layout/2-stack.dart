import 'dart:math';

import 'package:flutter/material.dart';

void main()=>runApp( MyPage());

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       // child: _buildStack(),
        child: _buildStackIndex(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          _index= Random().nextInt(2)%2;
        });
      }),
    );
  }

  Stack _buildStack() {
    return Stack(
        children: <Widget>[
          Container(
            color: Colors.amber,
            width: 200.0,
            height: 200.0,
          ),
          Positioned(
            top: 10.0,
              left: 10.0,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.deepOrange,
              ))
        ],
      );
  }
  Stack _buildStackAlign() {
    return Stack(
      alignment: Alignment(1.2,-1.2),
      children: <Widget>[
        Container(

          color: Colors.amber,
          width: 200.0,
          height: 200.0,
        ),
        Positioned(
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.deepOrange,
            ))
      ],
    );
  }

  Stack _buildStackIndex() {
    return IndexedStack(
      index: _index,
      alignment: Alignment(1.2,-1.2),
      children: <Widget>[
        Container(

          color: Colors.amber,
          width: 200.0,
          height: 200.0,
        ),
        Positioned(
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.deepOrange,
            ))
      ],
    );
  }
}




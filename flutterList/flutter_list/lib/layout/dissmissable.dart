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
  final List<String> items = List.generate(20, (index)=>'item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index){
          final item = items[index];
          return Dismissible(
              onDismissed: (i){
                items.removeAt(index);
              },
              movementDuration: Duration(milliseconds: 5000),
              key: Key(item),
              child: ListTile(
                title: Text('$item'),
          ),
          background:Container(color: Color(0xffff0000),)
          );
        },
      ),
    );
  }
}







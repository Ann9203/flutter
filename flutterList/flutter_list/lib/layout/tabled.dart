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
       child: Table(
         columnWidths: const <int, TableColumnWidth>{
           0:FixedColumnWidth(50.0),
           1:FixedColumnWidth(150.0),
           2:FixedColumnWidth(50.0),
           3:FixedColumnWidth(50.0),
           4:FixedColumnWidth(50.0),
         },
         border: TableBorder.all(
           color: Colors.deepOrange,
           width: 5.0,
         ),
         children: const<TableRow>[
           TableRow(
             children: [
               Text('头像'),
               Text('姓名'),
               Text('年龄'),
               Text('身高'),
             ]
           ),
        TableRow(
          children: [
            Icon(Icons.photo_camera),
            Text('li'),
            Text('23'),
            Text('168'),
          ]),
         ],
       ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          _index= Random().nextInt(2)%2;
        });
      }),
    );
  }


}




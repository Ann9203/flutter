import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoAlertDialog(
          title: Text('CupertinoAlertDialog'),
          content: Text('是否否否否否'),
          actions: <Widget>[
            CupertinoDialogAction(child: Text('确定')),
            CupertinoDialogAction(child: Text('取消')),
          ],

        ),
      ),
    );

  }
}

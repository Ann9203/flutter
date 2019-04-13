import 'package:flutter/material.dart';
void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon_Button'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person),
              SizedBox(height: 30.0,),
              IconButton(icon: Icon(Icons.error),onPressed: (){},),
              SizedBox(height: 30.0,),
              RaisedButton(
                onPressed: (){},
                child: Text('RaisedButton'),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}

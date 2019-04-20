import 'package:flutter/material.dart';
void main()=>runApp(LoginPage());

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _name;
  String _password;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('form'),),
        body: Column(
          children: <Widget>[
            Container(
              child: Form(child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '请输入用户名',

                    ),
                    onSaved: (value){
                      print('$value');
                      _name = value;
                    },
                    onFieldSubmitted: (value){
                      print('$value');
                    },

                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}




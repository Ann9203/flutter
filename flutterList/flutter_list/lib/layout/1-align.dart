import 'package:flutter/material.dart';

void main()=>runApp( HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 200,
              height: 100,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

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
        appBar: AppBar(
          title: Text('CardDemo'),
          leading: Icon(Icons.star),
        ),
        body: ListView(
          children: <Widget>[
            _buildCard(),
            _buildCard(),
            _buildCard(),
            _buildCard(),
          ],
        ));
  }

  Card _buildCard() {
    return Card(
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/timg.jpg' , width: double.infinity, height: 150, fit: BoxFit.cover,),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(Icons.home),
                    ),

                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                        ),
                        Text('五星级评级五星级评级五星级评级五星级评级五星级评级',style: TextStyle(fontSize: 20.0),),
                        Text('500', style: TextStyle(fontSize: 15.0),),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                        ),
                      ],
                    )),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[

                          Icon(Icons.favorite, color: Colors.red,),
                          Text('4'),

                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}

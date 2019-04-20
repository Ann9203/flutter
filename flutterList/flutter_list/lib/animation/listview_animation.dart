import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(home :HomePage()));

/**
 * listview 轮子效果
 */
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 var images = [
      'assets/images/timg.jpg',
      'assets/images/tuer.jpg',
      'assets/images/tusan.jpeg',
      'assets/images/tu4.jpg',
      'assets/images/tu5.jpg',
      'assets/images/tu6.jpg',
      'assets/images/timg.jpg',
      'assets/images/tuer.jpg',
      'assets/images/tusan.jpeg',
      'assets/images/tu4.jpg',
      'assets/images/tu5.jpg',
      'assets/images/tu6.jpg',
    ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _buildListWheelScrollView(context),
    ),
    );
  }

  ListWheelScrollView _buildListWheelScrollView(BuildContext context) {
    return ListWheelScrollView(
          itemExtent: MediaQuery.of(context).size.height*0.4,
          children: images
                .map((m)=>Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
                Image.asset(
                m,
                fit: BoxFit.fill,
                ),
                Positioned(child: Text('图片滚动' , style: TextStyle(color: Colors.green, fontSize: 25.0),) , bottom: 40.0, left: 40.0, )

          ],
        ),
      ))
        .toList(),
    );
  }
}

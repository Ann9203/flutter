import 'package:flutter/material.dart';

void main()=>runApp( MyPage());

class MyPage extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget  {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin{
  Animation<Color> _doubleAnim;
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5))..forward();
    _doubleAnim = ColorTween(begin: Color(0xffffffff), end: Color(0xffff0000)).animate(_animationController)
    ..addListener((){
      print(_doubleAnim.value.toString());
      setState(() {
      });
    })
    ..addStatusListener((status){
        if(status == AnimationStatus.completed){
          _animationController.reverse();
        } else if(status == AnimationStatus.dismissed){
          _animationController.forward();
        }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Container(
         width: 200.0,
         height: 200.0,
         color: _doubleAnim.value,

       ),
      ),

    );
  }
}







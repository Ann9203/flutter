import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  home: HomePage(),
));


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
      with SingleTickerProviderStateMixin{
  Animation<double> _animation ;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween(begin: -0.1, end: 0.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut))
    ..addStatusListener(_myListener);
    _animationController.forward();
  }

  void _myListener(status){
    if(status == AnimationStatus.completed){
      _animationController.removeStatusListener(_myListener);
      _animationController.reset();
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
      _animationController.forward();

    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child){
            return Transform(
              transform: Matrix4.translationValues(_animation.value*_screenWidth,_animation.value*_screenHeight, 0.0),
              child: Container(
                width: 200.0,
                height: 200.0,
                child: FlutterLogo(),
              ),
            );
          }),
    );
  }
}

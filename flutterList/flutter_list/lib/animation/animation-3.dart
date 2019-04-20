import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
    home: HomePage(),
  theme: ThemeData.light(),
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
 with SingleTickerProviderStateMixin{
   Animation<double> _doubleAnim;
   AnimationController _animationController;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds:  2))..forward();
    _doubleAnim = Tween(begin: 2.0, end: 8.0).animate(_animationController)
    ..addStatusListener((state){
      if(state == AnimationStatus.completed){
        _animationController.reverse();
      } else if(state == AnimationStatus.dismissed){
        _animationController .forward();
      }
    })
    ..addListener((){
      setState(() {

      });
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
    return MyLog(animation: _doubleAnim,);
  }
}

class MyLog extends AnimatedWidget{
  final Tween<double> _rotateAnim = Tween(begin: 0.0, end: 45.0);
  final Tween<double> _scalAnim = Tween(begin: 1.0, end: 2.5);
  final ColorTween _colorTween = ColorTween(begin: Color(0x2fffff00), end: Color(0xffffff00));
  MyLog({Key key, Animation animation}):super(key:key, listenable:animation);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Animation _animation = listenable;
    return Transform.scale(
        scale: _scalAnim.evaluate(_animation),
        child: Transform.rotate(angle: _rotateAnim.evaluate(_animation),
        child: Center(
          child:Container(
            width: _animation.value,
            height: _animation.value,
            color: _colorTween.evaluate(_animation)),
          ),
        ));
  }

}

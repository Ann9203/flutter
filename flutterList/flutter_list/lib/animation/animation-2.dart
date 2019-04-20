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
  Animation<double> _doubleAnim;
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5))..forward();
    _doubleAnim = Tween(begin: 0.0, end: 10.0).animate(_animationController)
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
        child: MyLogo(animation: _doubleAnim,),
      ),

    );
  }
}
class MyLogo extends AnimatedWidget{
  final Tween<double> rotateAnim = Tween(begin: 0, end: 75);
  final Tween<double> scaleAnim = Tween(begin: 0, end: 2.0);
  MyLogo({Key key, Animation animation}):super (key: key, listenable:animation);
  @override
  Widget build(BuildContext context) {
    final Animation _animation = listenable;
    // TODO: implement build
    return Transform.scale(
      scale: scaleAnim.evaluate(_animation),

      child:Transform.rotate(angle: rotateAnim.evaluate(_animation), child: FlutterLogo(),),

    );
  }

}







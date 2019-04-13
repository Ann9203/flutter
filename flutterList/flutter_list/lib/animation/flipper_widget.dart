import 'dart:math';

import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  home: HomePage(),
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/**
 * 翻拍动画
 */
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin{
    Animation<double> _animation;
    AnimationController _animationController;
    bool reversed = false;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    //动画组
    _animation = TweenSequence([
      TweenSequenceItem(
        weight: 0.5,
        tween: Tween(begin: 0.0, end: -pi/2),
      ),
      TweenSequenceItem(
        weight: 0.5,
        tween: Tween(begin: pi/2, end: 0.0),

      ),
    ]).animate(_animationController);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
  _doAnimation(){
      reversed?_animationController.reverse() : _animationController.forward();
      reversed = !reversed;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget child){
              return Transform(transform: Matrix4.identity()
                ..setEntry(3,2, 0.002)
                ..rotateY(_animation.value),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: _doAnimation,
                  child: IndexedStack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CardOne(),
                      CardTwo()
                    ],

                    index: _animationController.value > 0.5 ? 1 : 0,

                  ),
                ),

              );
            }),
      )

    );
  }
}


class CardOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepOrange,
      child: Container(
        width: 200.0,
        height: 200.0,
        child: Center(
          child: Text('点我查看密码', style: TextStyle(color: Colors.white, fontSize: 20.0)),
           //
        ),
      ),
    );
  }
}

class CardTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: Container(
        width: 200.0,
        height: 200.0,
        child: Center(
          child: Text('11111111', style: TextStyle(color: Colors.white, fontSize: 25.0)),
          //
        ),
      ),
    );
  }
}

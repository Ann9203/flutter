import 'dart:math';

import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(home: HomePage(),));


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/**
 * 旋转动画升级  分为八个动画步骤
 */
class _HomePageState extends State<HomePage>
  with SingleTickerProviderStateMixin{
  Tween<double> _tween;
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat();
    _tween = Tween(begin: 0.0, end: 1.0);
  }

  Animation<double> get onAnimation => _tween.animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval( 0.0,  0.125, curve: Curves.linear))
  );

  Animation<double> get oneAnimation => _tween.animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval( 0.0,  0.125, curve: Curves.linear))
  );
  Animation<double> get twoAnimation => _tween.animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval( 0.125,  0.25, curve: Curves.linear))
  );
  Animation<double> get threeAnimation => _tween.animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval( 0.25,  0.375, curve: Curves.linear))
  );
  Animation<double> get foureAnimation => _tween.animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval( 0.375,  0.5, curve: Curves.linear))
  );
  Animation<double> get fiveAnimation => _tween.animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval( 0.5,  0.625, curve: Curves.linear))
  );
  Animation<double> get sixAnimation => _tween.animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval( 0.625,  0.75, curve: Curves.linear))
  );
  Animation<double> get sevenAnimation => _tween.animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval( 0.75,  0.875, curve: Curves.linear))
  );

  Animation<double> get eightAnimation => _tween.animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval( 0.875,  1.0, curve: Curves.linear))
  );
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('动画'),),
      body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new AnimationBrick(
                animations: [oneAnimation, twoAnimation],
                controller: _animationController,
                marginLeft: 0.0,
                alignment: Alignment.centerLeft,
                isClockWise: true,
              ),
              new AnimationBrick(
                animations: [threeAnimation, eightAnimation],
                controller: _animationController,
                marginLeft: 0.0,
                isClockWise: false,
              ),
              new AnimationBrick(
                animations: [foureAnimation, sevenAnimation],
                controller: _animationController,
                marginLeft: 30.0,
                isClockWise: false,
              ),
              new AnimationBrick(
                animations: [fiveAnimation, sixAnimation],
                controller: _animationController,
                marginLeft: 30.0,
                isClockWise: false,
              )
            ],
          ),
      ),
    );
  }
}

class AnimationBrick extends AnimatedWidget{
  final AnimationController controller;
  final List<Animation> animations;
  final double marginLeft;
  final Alignment alignment;
  final bool isClockWise;

  AnimationBrick({
    Key key,
    this.controller,
    this.animations,
    this.marginLeft,
    this.alignment = Alignment.centerRight,
    this.isClockWise
}):super(key : key, listenable: controller);

 Matrix4 clockWise(Animation animation)=> Matrix4.rotationZ(animation.value*pi*2.0*0.5);
 Matrix4 antiClockWise(Animation animation)=> Matrix4.rotationZ(-(animation.value*pi*2.0*0.5));


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var firstTransformation = isClockWise ? clockWise(animations[0]) : antiClockWise(animations[0]);
    var secondTransformation =isClockWise ? clockWise(animations[1]) : antiClockWise(animations[1]);
    return  Transform(
      alignment: alignment,
      transform: firstTransformation,
      child: Transform(
        transform: secondTransformation,
          alignment: alignment,
          child: _buildContainer(),),
    );
  }

  Container _buildContainer() {
    return Container(
          margin: EdgeInsets.only(left: marginLeft),
          width: 40.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(15.0)
          ),
        );
  }

}


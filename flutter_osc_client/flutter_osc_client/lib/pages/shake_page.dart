import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart' show AppColors;
import 'package:sensors/sensors.dart';
import 'package:vibration/vibration.dart';
import 'dart:math';
import 'dart:async';


///摇一摇
class ShakePage extends StatefulWidget {
  @override
  _ShakePageState createState() => _ShakePageState();
}

class _ShakePageState extends State<ShakePage> {
  bool isShake = false;
  int _currentIndex = 0;
  StreamSubscription _streamSubscription;
  static const int SHAKE_TMEOUT = 500;
  static const double SHAKE_THRESHOLD = 3.25;
  var _lastTime = 0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///监听摇晃的时间  也就是 重力左右摇晃
    _streamSubscription = accelerometerEvents.listen((AccelerometerEvent event){
      var x = event.x;
      var y = event.y;
      var z = event.z;
      var now = DateTime.now().millisecondsSinceEpoch;
      double acc = sqrt(x*x + y*y +z*z)-9.8;
      ///判断摇晃力度 判断时间间隔
      if(acc > SHAKE_THRESHOLD && now - _lastTime > SHAKE_TMEOUT){
        ///摇晃了
        Vibration.vibrate();
        _lastTime = now;
        setState(() {
          if(!mounted) return;
          isShake = true;
        });
      }

    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamSubscription.cancel();
  }



  ///是否正在摇晃

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '摇一摇',
          style: TextStyle(
              color: Color(AppColors.APP_THEME_ICON_COLOR), fontSize: 20.0),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APP_THEME_ICON_COLOR)),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/shake.png',
            width: 200.0,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(isShake ? '活动一结束' : '扫一扫获取礼品')
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            title: Text('礼品'),
              icon: Icon(Icons.card_giftcard),
              activeIcon: Icon(
                Icons.card_giftcard,
                color: Colors.green,
              )),
          BottomNavigationBarItem(
              title: Text('资讯'),
              icon: Icon(Icons.receipt),
              activeIcon: Icon(
                Icons.receipt,
                color: Colors.green,
              ))
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          if(!mounted) return;
          setState(() {
            _currentIndex = index;
            isShake = false;
          });
        },
      ),
    );
  }
}

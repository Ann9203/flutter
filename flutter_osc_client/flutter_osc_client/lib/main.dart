import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart' show AppColors;
import 'package:flutter_osc_client/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //去掉右上角debug标签
      title: '开源中国',
      theme: ThemeData(
        primaryColor: Color(AppColors.APP_THEME_COLOR),
      ),
      home: HomePage(),
    );
  }
}


import 'package:flutter/material.dart';

class BottomNavigationView{
  final BottomNavigationBarItem item;
  final String title;
  final String iconPath;
  final String activeIconPath;

  BottomNavigationView({@required this.title , @required this.iconPath, @required this.activeIconPath})
  :item = BottomNavigationBarItem(
    title: Text(title),
    icon: Image.asset(iconPath, width: 20.0, height: 20.0,),
    activeIcon: Image.asset(activeIconPath, width: 20.0, height: 20.0,)
  );

}

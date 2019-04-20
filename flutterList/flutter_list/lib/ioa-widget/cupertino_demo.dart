import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('首页')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person), 
                title: Text('个人')
              ),
            ]),
        tabBuilder: (context, index){
          return CupertinoTabView(
            builder: (context){
              switch(index){
                case 0:
                  return MyHom();
                  break;
                case 1:
                  return MyPerson();
                  break;
              }
            },
          );
        }
    );}
}

class MyHom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Center(child: Text('主页'),));
  }
}
class MyPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      leading: Icon(CupertinoIcons.person),
      trailing: Icon(CupertinoIcons.photo_camera),
      middle: Text('豆豆'),
    ) ,
    
    child: Center(child: Text('个人中心'),));

  }
}



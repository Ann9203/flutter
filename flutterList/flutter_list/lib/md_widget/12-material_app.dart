import 'package:flutter/material.dart';
void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material',
      routes: {'/other': (BuildContext context) => OtherPage()}, //界面调准
      home: Scaffold(


          body:HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 int  _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('TMaterialAPP'),
        centerTitle: true,
        elevation: 1.0,
          actions: <Widget>[
            Icon(Icons.save),
            Icon(Icons.search),
            Icon(Icons.find_in_page)
          ],
        leading: Icon(Icons.account_box),),
        body: Center(),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.pushNamed(context, '/other');
        },
          tooltip: '路由跳转',
          foregroundColor: Colors.amber,
          backgroundColor: Colors.red,
         elevation: 0.4,
         child: Icon(Icons.arrow_forward),),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Person')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text('Person')
          ), BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('Person')
          ),

        ],
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            _currentIndex = index;

          });
        },),
        drawer: Drawer(
          elevation: 0.0,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(accountName: Text('zhengbo'),
                  accountEmail: Text('lixue326@163.com'),
                  currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/17.jpg'),),
                  otherAccountsPictures: <Widget>[Icon(Icons.camera_alt)],
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/timg.jpg'), fit: BoxFit.fill)
                ),
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title:Text('会员特权'),
              ),
              ListTile(
                leading: Icon(Icons.save),
                title:Text('会员特权'),
              ),
              ListTile(
                leading: Icon(Icons.star),
                title:Text('会员等级'),
              ),
              AboutListTile(
                icon: Icon(Icons.info),
                child: Text('关于'),
              )
            ],
        ),
      ),
      ));
  }
}




class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OtherPage'),),
    );
  }
}



import 'package:flutter/material.dart';
void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material',
      home:HomePage(),
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SimpleDialog(
              title: Text('对话框Title'),
              children: <Widget>[
                SimpleDialogOption(
                  child: Text('确定'),
                  onPressed: () => print('点击确定'),
                ),
                SimpleDialogOption(
                  child: Text('取消'),
                  onPressed: () => print('点击取消'),
                )
              ],
            ),
            RaisedButton(
                child: Text('删除'),
                onPressed: (){
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('温馨提示'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('是否删除此条目'),
                              Text('删除后数据不可恢复!'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('确定'),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('取消'),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
              });
            })
          ],
        ),
      ),
    );
  }
}






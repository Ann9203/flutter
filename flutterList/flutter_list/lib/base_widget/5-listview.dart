import 'package:flutter/material.dart';
void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListView'),
        ),
        body:
          ListView.builder(
          itemCount: 200 ,
          itemBuilder: (context , index){
            if(index.isOdd){
              return Divider();
            }
            return  ListTile(
              leading: Icon(Icons.favorite_border),
              title: Text('doudoudoud'),
              subtitle: Text('xihaxiah'),
              trailing: Icon(Icons.arrow_forward_ios),
            );
          })

      ),
    );
  }

  ListView _horizontalList() {
    return ListView(
          scrollDirection: Axis.horizontal,
          //generate 一次性加载所有数据
          children: List.generate(15, (index){
            return Text('$index', style: TextStyle(fontSize: 30.0, color: Colors.green),);
          })
        );
  }

  ListView _buildListView() {
    return ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('favorit_boder'),
            subtitle: Text('xihaxiah'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('favorit_boder'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('favorit_boder'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('favorit_boder'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('favorit_boder'),
          ),
        ],
      );
  }
}

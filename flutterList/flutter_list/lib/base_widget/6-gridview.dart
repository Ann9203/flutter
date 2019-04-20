import 'package:flutter/material.dart';
void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('gridView'),
          ),
          body:
           GridView.builder(
               gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 3,
                   mainAxisSpacing: 100),
               itemBuilder: (context, index){
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

  GridView _buildGridView() {
    return GridView.count(crossAxisCount: 5, //交叉轴个数
        scrollDirection: Axis.horizontal, //滑动方向
          childAspectRatio: 2/3, //宽高比例
          children: List.generate(100, (index){
            return Text(
              '$index',
              style: TextStyle(fontSize: 20, color: Colors.green),
            );
          })
        );
  }
}


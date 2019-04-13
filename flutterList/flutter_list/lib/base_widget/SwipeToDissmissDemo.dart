import 'package:flutter/material.dart';
class SwipeToDissmissDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new _SwipeToDissMissState();
  }

}

class _SwipeToDissMissState extends State<SwipeToDissmissDemo>{
  List<String> list = List.generate(30, (index)=>"糖豆豆 $index 元素");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      appBar: AppBar(title: Text('糖豆豆1')),
      body: ListView.builder(itemCount: list.length,
          itemBuilder: (context, index){
            return Dismissible(
              key: Key(list[index]),
              direction: DismissDirection.endToStart,
              child: ListTile(title: Text('${list[index]}'),),
              background: Container(color: Colors.red,),
              onDismissed: (direction){
              setState(() {
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('${list[index]}')));
                list.removeAt(index);
              });
            },
              
            );
          }),
    );
  }

}


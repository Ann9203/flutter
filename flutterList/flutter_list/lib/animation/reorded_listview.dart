import 'dart:math';

import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(home: HomePage(),));


/**
 * listview 条目移动
 */
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List list = List.generate(Random().nextInt(20)+1, (index)=>'demoItem $index');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  /**
   * scaffold 脚手架   reorderableListView :  重新排序ListView
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text( 'listView reorder'),),
        body: ReorderableListView(
            children: list
                  .map((index)=>ListTile(
                    key: ObjectKey(index),
                      title: Text(index),
                      leading: Icon(Icons.favorite, color: Colors.deepOrange,)  ,
                  ))
                  .toList(),

            onReorder: _reorderList),
    );
  }
  void _reorderList(int oldIndex, int newIndex){
    setState(() {
        if(newIndex == list.length){
            newIndex = list.length-1;
        }

        var item = list.removeAt(oldIndex);
        list.insert(newIndex, item);

    });
  }
}




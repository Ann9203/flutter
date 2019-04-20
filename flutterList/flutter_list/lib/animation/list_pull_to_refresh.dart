import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main()=>runApp(MaterialApp(home:  HomePage(),));


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List list = List();
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
    _scrollController= ScrollController()
        ..addListener((){
          //判断是否滑到底部
          if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
            _loadMore();
          }
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('listView-PullToRefresh'),
      ),
      body: Center(
        child: RefreshIndicator(
          displacement: 10.0,
            child: list == null || list.isEmpty?
              Center(
                  child: CircularProgressIndicator(),
              )
               : ListView.builder(
                controller: _scrollController,
                itemCount: list.length+1,
                itemBuilder: (context, index){
                  if(index == list.length){
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ListTile(
                    title: Text(list[index]),
                  );
                },
              ),
            onRefresh: _refresh),
      ),
    );
  }

  /**
   * 刷新
   */
   Future<void> _refresh() async{
    await Future.delayed(Duration(seconds: 3), (){
      setState(() {
        list = List.generate(Random().nextInt(20)+15, (index) => 'item $index');
      });
    });

  }

  Future _loadMore() async{
    await Future.delayed(Duration(seconds: 3), (){
      setState(() {

        list.addAll(List.generate(Random().nextInt(5)+5, (index) => 'item $index'));

      });
    });
  }
}

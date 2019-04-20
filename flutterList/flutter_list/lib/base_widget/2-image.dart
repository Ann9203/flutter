import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image实例'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              //加载网络图片
//              Image.network(
//                'https://www.baidu.com/img/bd_logo1.png?where=super',
//                width: 100.0,
//                height: 100.0,),
//
//              //加载Asset
//              Image.asset('assets/images/timg.jpg',
//                width: 200.0,
//                height: 200.0,),
//              //缓存获取
//              MemoryImageWidget(),
              //从SDK文件加载图片
              FileImageWidget(),

            ],
          ),
        ),
      ),
    );
  }
}

class FileImageWidget extends StatefulWidget {
  @override
  _FileImageWidgetState createState() => _FileImageWidgetState();
}

class _FileImageWidgetState extends State<FileImageWidget> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
            child: _image == null
                ?Text('未选择图片!')
                : Image.file(_image, width: 200.0, height: 200.0,),
        ),
        FlatButton(
          onPressed: getImage,
          child: Text('选择图片',
            style: TextStyle(fontSize: 20.0,
                color: Colors.green),
          ),
        ),
      ],
    );
  }
}


class MemoryImageWidget extends StatefulWidget {
  @override
  _MemoryImageWidgetState createState() => _MemoryImageWidgetState();
}

class _MemoryImageWidgetState extends State<MemoryImageWidget> {
  Uint8List bytes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.load('assets/images/timg.jpg').then((data) {
      if (mounted) {
        setState(() {
          bytes = data.buffer.asUint8List();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _decoration = BoxDecoration(
      image: bytes == null ? null : DecorationImage(image: MemoryImage(bytes)),
    );
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: _decoration,
    );
  }
}


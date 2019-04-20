import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constance/constants.dart';
import 'package:flutter_osc_client/utils/data_save_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class PublishTweetPage extends StatefulWidget {
  @override
  _PublishTweetPageState createState() => _PublishTweetPageState();
}

class _PublishTweetPageState extends State<PublishTweetPage> {
  TextEditingController _textEditingController = TextEditingController();
  List<File> fileList = List<File>();
  Future<File> _imageFile;
  bool isLoading = false;

  Widget _buildWidgetBody() {
    List<Widget> _body = [
      ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: '今天想动弹什么?',
                hintStyle:
                    TextStyle(color: Color(AppColors.APP_MIN_SIZE_COLOR)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(const Radius.circular(10.0)),
                ),
              ),
              maxLength: 150,
              maxLines: 6,
            ),
          ),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: List.generate(fileList.length + 1, (index) {
              if (index == fileList.length) {
                //button
                return Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        //TODO Widget
                        _pickImage(context);
                      },
                      child: Image.asset('assets/images/ic_add_pics.png'),
                    );
                  },
                );
              }
              return GestureDetector(
                onTap: () {
                  //取消图片
                  setState(() {
                    fileList.remove(index);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    fileList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          )
        ],
      ),
    ];

    if (isLoading) {
      _body.add(Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            color: Color(AppColors.APP_AlPH),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoActivityIndicator(),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '正在努力动弹中..',
                  style: TextStyle(color: Color(AppColors.APP_THEME_COLOR)),
                )
              ],
            ),
          ),
        ),
      ));
    }

    return Stack(
      children: _body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false, //防止键盘弹出 超出屏幕
        appBar: AppBar(
          title: Text(
            '弹一弹',
            style: TextStyle(color: Color(AppColors.APP_THEME_COLOR)),
          ),
          iconTheme: IconThemeData(color: Color(AppColors.APP_THEME_COLOR)),
          actions: <Widget>[
            Builder(builder: (context) {
              return FlatButton(
                onPressed: () {
                  //发布动弹 请求网络
                  DataSaveUtils.getAccessToken().then((accessToken) {
                    if (accessToken != null && accessToken.length > 0) {
                      //TODO 网络请求发布动弹
                      _publishTweet(context, accessToken);
                    }
                  });
                },
                child: Text(
                  '发送',
                  style: TextStyle(color: Color(AppColors.APP_THEME_COLOR)),
                ),
              );
            })
          ],
        ),
        body: FutureBuilder(
          future: _imageFile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null &&
                _imageFile != null) {
              fileList.add(snapshot.data);
              _imageFile = null;
            }
            return _buildWidgetBody();
          },
        ));
  }

  void _publishTweet(BuildContext context, String token) async {
    if (token == null) {
      _showSnakBar(context, '未登录');
      return;
    }
    String tweetContent = _textEditingController.text;
    if (tweetContent == null || tweetContent.isEmpty) {
      _showSnakBar(context, '请输入内容');
      return;
    }

    Map<String, dynamic> params = Map();
    params['msg'] = tweetContent;
    params['access_token'] = token;
    print('动弹内容$tweetContent');

    var multipartRequest =
        http.MultipartRequest('POST', Uri.parse(AppUrls.TWEET_PUB));
    multipartRequest.fields.addAll(params);
    if (fileList.length > 0) {
      for (File file in fileList) {
        var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
        var length = await file.length();
        var fileName = file.path.substring(file.path.lastIndexOf("/") + 1);
        multipartRequest.files
            .add(http.MultipartFile('img', stream, length, filename: fileName));
      }
    }
    setState(() {
      isLoading = true;
    });

    var streamResponse = await multipartRequest.send();
    streamResponse.stream.transform(utf8.decoder).listen((response) {
      setState(() {
        isLoading = false;
      });
      if (response != null) {
        var decode = json.decode(response);
        var errorCode = decode['error'];
        if (mounted) {
          setState(() {
            if (errorCode != null && errorCode == '200') {
              fileList.clear();
              _textEditingController.clear();
              _showSnakBar(context, '发布成功');
            } else {
              _showSnakBar(context, '发布失败');
            }
          });
        }
      }
    });
  }

  void _showSnakBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(msg),
      duration: Duration(milliseconds: 500),
    ));
  }

  ///选择图片的
  void _pickImage(BuildContext context) {
    num size = fileList.length;
    if (size > 9) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text('最多九张图')));
      return;
    }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return new Container(
            height: 121.0,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (mounted) {
                      setState(() {
                        _getImageCameraPermission().then((isCamera) {
                          if (isCamera != null && isCamera) {
                            _imageFile = ImagePicker.pickImage(
                                source: ImageSource.camera);
                          }
                        });
                      });
                    }
                  },
                  child: Container(
                    height: 60.0,
                    child: Center(
                      child: Text(
                        '相机拍照',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
                new Divider(
                  height: 1.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (mounted) {
                      setState(() {
                        _imageFile =
                            ImagePicker.pickImage(source: ImageSource.gallery);
                      });
                    }
                  },
                  child: Container(
                    height: 60.0,
                    child: Center(
                      child: Text(
                        '图库选择',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<bool> _getImageCameraPermission() async {
    PermissionStatus permissionStatus =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (permissionStatus != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissionMap =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.camera]);
      return permissionMap[PermissionGroup.camera] == PermissionStatus.granted;
    } else {
      return true;
    }
  }
}

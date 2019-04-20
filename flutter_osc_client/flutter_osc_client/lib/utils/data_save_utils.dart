import 'package:flutter_osc_client/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


///数据处理
class DataSaveUtils{
  static const String SP_ACCESS_TOKEN = 'access_token';
  static const String SP_REFRESH_TOKEN = 'refresh_token';
  static const String SP_UID = 'uid';
  static const String SP_TOKEN_TYPE = 'token_type';
  static const String SP_EXPIRES_IN = 'expires_in';
  static const String SP_IS_LOGIN = 'is_login';

  //用户信息字段
  static const String SP_USER_GENDER = 'gender';
  static const String SP_USER_NAME = 'name';
  static const String SP_USER_LOCATION = 'location';
  static const String SP_USER_ID = 'id';
  static const String SP_USER_AVATAR = 'avatar';
  static const String SP_USER_EMAIL = 'email';
  static const String SP_USER_URL = 'url';

  ///存储登录信息
  static Future<void> saveLoginInfo(Map<String, dynamic> map)async{
     SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
     sharedPreferences
              ..setString(SP_ACCESS_TOKEN, map[SP_ACCESS_TOKEN])
              ..setString(SP_REFRESH_TOKEN, map[SP_REFRESH_TOKEN])
              ..setInt(SP_UID, map[SP_UID])
              ..setString(SP_TOKEN_TYPE, map[SP_TOKEN_TYPE])
              ..setInt(SP_EXPIRES_IN, map[SP_EXPIRES_IN])
              ..setBool(SP_IS_LOGIN, true);
  }


  ///存储登录信息
  static Future<void> clearLoginInfo()async{
    SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
    sharedPreferences
      ..setString(SP_ACCESS_TOKEN, '')
      ..setString(SP_REFRESH_TOKEN, '')
      ..setInt(SP_UID, -1)
      ..setString(SP_TOKEN_TYPE, '')
      ..setInt(SP_EXPIRES_IN,-1)
      ..setBool(SP_IS_LOGIN, false);
  }

  ///获取是否登录
  static Future<bool> isLogin()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool(SP_IS_LOGIN);
     return isLogin !=null  && isLogin;
  }

  ///获取token值
  static Future<String> getAccessToken()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String accessToken = sp.getString(SP_ACCESS_TOKEN);
    return accessToken;
  }

  ///存储用户信息
  static  saveUserInfo(Map<String, dynamic> map)async{
    SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
    if(map != null && map.isNotEmpty){
      String gender = map[SP_USER_GENDER];
      String name = map[SP_USER_NAME];
      String location = map[SP_USER_LOCATION];
      int id = map[SP_USER_ID];
      String avatar = map[SP_USER_AVATAR];
      String email = map[SP_USER_EMAIL];
      String url = map[SP_USER_URL];

      sharedPreferences
        ..setString(SP_USER_GENDER, gender)
        ..setString(SP_USER_NAME, name)
        ..setString(SP_USER_LOCATION, location)
        ..setInt(SP_USER_ID, id)
        ..setString(SP_USER_AVATAR, avatar)
        ..setString(SP_USER_EMAIL,email)
        ..setString(SP_USER_URL,url);

      User user = new User(
        gender: gender,
        name: name,
        location: location,
        id: id,
        avatar: avatar,
        email: email,
        url: url

      );

      return user;
    }
    return null;
  }


  ///获取用户信息
  static Future<User> getUserInfo()async{
    SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
    bool isLogin  = sharedPreferences.getBool(SP_IS_LOGIN);
    if( isLogin == null || !isLogin){
      return null;
    }
    User user = new User(
      gender: sharedPreferences.getString(SP_USER_GENDER),
      name: sharedPreferences.getString(SP_USER_NAME),
        id: sharedPreferences.getInt(SP_USER_ID),
      avatar: sharedPreferences.getString(SP_USER_AVATAR),
      location: sharedPreferences.getString(SP_USER_LOCATION),
      email: sharedPreferences.getString(SP_USER_EMAIL),
      url: sharedPreferences.getString(SP_USER_URL)
    );
    return user;

  }
}
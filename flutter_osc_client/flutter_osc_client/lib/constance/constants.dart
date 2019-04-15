


abstract class AppColors{
  //应用主题颜色
  static const APP_THEME_COLOR = 0xff63ca6c;
  static const APP_THEME_ICON_COLOR = 0xffffffff;
  static const APP_MIN_SIZE_COLOR = 0xffaaaaaa;
}


abstract class AppUrls{
  static const String HOST = 'https://www.oschina.net';
  static const String OAUTH2_AUTHORIZE  = HOST + '/action/oauth2/authorize'; //验证
  static const String OAUTH2_TOKEN  = HOST + '/action/openapi/token'; //登录获取到token

  static const String OPENAPI_USER = HOST + '/action/openapi/user';  //获取当前登录的用户信息
  static const String MY_INFORMATION = HOST +'/action/openapi/my_information'; //获取用户详情
  static const String MESSAGE_LIST = HOST +'/action/openapi/message_list'; //获取私信消息列表

}

abstract class AppInfo{
  static const String CLIENT_ID = '9Um24uw7HtMkDTsMqjut';  //id
  static const String CLIENT_SECRET = 'OZWcxQFy8IplQV8wKRZhdGpxfzWONz74';//秘钥
  static const String REDIRECT_URI = 'https://flutterchina.club/'; //回调地址

}




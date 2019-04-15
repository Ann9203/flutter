
class MyUserInfo{
//  "uid": 89964,
//  "name": "彭博",
//  "gender": 1,
//  "province": "广东",
//  "city": "深圳",
//  "platforms": [
//  "Java EE",
//  "Java SE",
//  "JavaScript",
//  "HTML/CSS"
//  ],
//  "expertise": [
//  "WEB开发",
//  "桌面软件开发",
//  "服务器端开发"
//  ],
//  "joinTime": "2010-07-14 17:15:55",
//  "lastLoginTime": "2013-10-21 10:55:36",
//  "portrait": "http://www.oschina.net/uploads/user/44/89964_50.jpg?t=1376365607000",
//  "fansCount": 19
//  "favoriteCount": 176,
//  "followersCount": 14,
//  "notice": {
//  "replyCount": 0,
//  "msgCount": 0,
//  "fansCount": 0,
//  "referCount": 0
//  },

  int uid;
  String name;
  int gender;
  String province;
  String city;
  List<dynamic> platforms;
  List<dynamic> expertise;
  String joinTime;
  String lastLoginTime;
  String portrait;
  int fansCount;
  int favoriteCount;
  int followersCount;
  Map<String, dynamic> notice;

  MyUserInfo({
    this.uid,
    this.name,
    this.gender,
    this.province,
    this.city,
    this.platforms,
    this.expertise,
    this.joinTime,
    this.lastLoginTime,
    this.portrait,
    this.fansCount,
    this.favoriteCount,
    this.followersCount,
    this.notice
});

}
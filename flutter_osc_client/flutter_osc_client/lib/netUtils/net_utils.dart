
import 'package:http/http.dart' as http ;
class NetUtils{

  ///get请求
  ///
  static Future<String> get(String url, Map<String, dynamic> parmas) async{
     if(url != null && parmas != null && parmas.isNotEmpty){
       StringBuffer sb = StringBuffer('?');
       parmas.forEach((key, value){
         sb.write('$key=$value&');
       });

       String paramsStr = sb.toString().substring(0, sb.length-1); //去掉最后一个&
       url+=paramsStr;
     }

     print("loginGet+$url");
     http.Response response = await http.get(url);
     return response.body;
  }

  ///post请求
  static Future<String> post (String url, Map<String, dynamic> params)async{
      if(url == null || params == null || params.isEmpty){
         return null;
      }
      http.Response response = await http.post(url, body: params);
      return response.body;

  }
}

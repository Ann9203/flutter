void main(){

  Function makeAddFunc(int a){
    return (int y )=> a+y;
  }

  var addFunc = makeAddFunc(12);
  print(addFunc(223));

  MyFunc mFnc = adds(11, 1);

}

typedef MyFunc(int a , int b);


 adds (int a, int b ){
  print('${a+b}');
}

divide(int a , int b) {
  print('${a / b}');

  String s;
  print(s?.length);
}

class Point{
  num x;
  num y;
  Point(this.x, this.y);
  Point.fromjson(Map json){
     x = json['x'];
     y = json['y'];
  }
}
void main(){

}

class Sington{
  String name;
   static Sington _cach;

  //工廠構造函數無法訪問this
//  factory Sington([String name = 'Sington']){
//     if(Sington._cach == null){
//       Sington._cach =  Sington._newObject(name);
//     }
//     return Sington._cach ??= Sington._newObject(name);
//  }

  factory Sington([String name = 'Sington']) => Sington._cach??=Sington._newObject(name);

  Sington._newObject(this.name);
}

class Rectangle{
  //上下左右宽高
  num left;
  num top;

  num width;
  num height;

  num get right => left +width;
  num get bottom => top+height;
  set right(value)=> left = value - width;

  set bottom(value)=> top = value - height;




}

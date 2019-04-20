void main() {}


//顶级函数  工厂模式
Massage massageFactory(String type) {
  switch (type) {
    case 'foot':
      return new FootMassage();
    case 'back':
      return BackMassage();
    case 'special':
      return SpecialMassage();
  }
}

abstract class Massage {
  void doMassage();
}

//abstract class Massage {
//  //工厂模式
//  factory Massage(String type){
//    switch(type){
////      case'foot':
////        return new FootMassage();
////      case 'back':
////        return BackMassage();
////      case 'special':
////        return SpecialMassage();
////
////    }
////  }
//  void doMassage();
//}

class SpecialMassage implements Massage {
  @override
  doMassage() {
    // TODO: implement doMassage
    print('特殊按摩');
  }
}

class FootMassage implements Massage {
  @override
  void doMassage() {
    // TODO: implement doMassage
    print('足底按摩');
  }
}

class BackMassage implements Massage {
  @override
  void doMassage() {
    // TODO: implement doMassage
    print('推背按摩');
  }
}

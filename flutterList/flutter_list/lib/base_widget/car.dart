void main(){}

abstract class Transpotation{
  void tranport();
}

class Bicycle extends Transpotation{
  String safeIndex() => 'low';
  String powerUnit()=> '2个轮子';
  String energy()=> '脚蹬';
  @override
  void tranport() {
    // TODO: implement tranport
  }

}

class Motocycle extends Transpotation{
  @override
  void tranport() {
    // TODO: implement tranport
  }

}

class Car extends Transpotation{
  @override
  void tranport() {
    // TODO: implement tranport
  }

}

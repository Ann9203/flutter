import 'dart:async';
void main()
{

  var iterator = getsyncGenerator(5).iterator;
  while(iterator.moveNext()){
    print(iterator.current);
  }
 StreamSubscription subscription =  getAsyncGenerator(5).listen(null);
  subscription.onData((value){
    print('value');
    if(value > 2){
    subscription.pause();
    }
  });

}

//生成器 同步和异步

//同步生成器
Iterable<int> getsyncGenerator(int n ) sync*{
   int k = n;
   while (k>0){


     yield k--;
   }
}



Stream<int> getAsyncGenerator(int n ) async*{
  print('start');
  int k = 0;
  while (k < n){
    yield k--;
  }
  print('end');
}

//递归生成器
Iterable<int> getSyncGenerator(int n ) sync*{
  if(n > 0)
    {
      yield n;
      yield* getSyncGenerator(n-1);
    }
}

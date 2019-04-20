import 'dart:async';
void main()
{
  new  Future(()=>futureTask())
      .then((i)=>'abs$i')
      .then((m)=>print('$m'))
      .then((_)=>new Future.error('出错误了'))
      .whenComplete(()=>print('whenComplete'))
      .catchError((e)=>print(e));

}

futureTask() {
  return 10;
}


void testScheduleMicrotask(){
  scheduleMicrotask(()=> print('s1')); //微任务
  //delay延迟
  new Future.delayed(new Duration(seconds: 1), ()=>print('s2'));

  new Future(() => print('s3')).then((_){
    print('s4');
    scheduleMicrotask(()=>print('s5'));
  }).then((_)=>print('s6'));

  new Future(()=>print('s7'));
  scheduleMicrotask(()=>print('s8'));
  print('s9');
}



//async await

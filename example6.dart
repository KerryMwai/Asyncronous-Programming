void main(List<String> args)async {
  int sum0=0;
  await for(final age in getAllAges()){
    sum0+=age;
  }

  final sum=await getAllAges().reduce(add);
  final sum2=await getAllAges().reduce((a,b)=>a+b);

  print(sum0);
  print(sum);
  print(sum2);
}

int add(int a,int b)=>a+b;

Stream<int> getAllAges() async*{
  yield 10;
  yield 20;
  yield 30;
  yield 40;
  yield 50;
}
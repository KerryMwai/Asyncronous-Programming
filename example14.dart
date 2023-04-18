void main(List<String> args) async{
  final names=getNames().asyncExpand((name) => nameTimes3(name));

  await for(final name in names){
    print(name);
  }
}

Stream<String> getNames()async*{
  yield 'Bob';
  yield 'Alice';
  yield 'Joe';
}

Stream<String> nameTimes3(String value)=>Stream.fromIterable(
  Iterable.generate(3,(_)=>value)
);
import 'dart:async';

void main(List<String> args) async{
  final controller=StreamController();

  controller.sink.add("Kenya");
  controller.sink.add("Uganda");
  controller.sink.add("Tanzania");
  controller.sink.add("Somalia");

  await for(final country in controller.stream){
    print(country);
  }

  controller.close();
}
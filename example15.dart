import 'dart:async';

void main(List<String> args) async {
  await nonBroadcastStreamExaple();
  await broadcastStreamExaple();
}

Future<void> nonBroadcastStreamExaple() async {
  final controller = StreamController();
  controller.add("Bob");
  controller.add("Alice");
  controller.add("Joe");

  try {
    await for (final name in controller.stream) {
      print(name);
      await for (final name in controller.stream) {
        print(name);
      }
    }
  } catch (e) {
    print(e);
  }
}

Future<void> broadcastStreamExaple() async {
  late final StreamController<String> controller;

  controller = StreamController<String>.broadcast();

  final sub1 = controller.stream.listen((name) {
    print("sub1: $name");
  });

  final sub2 = controller.stream.listen((name) {
    print("sub2 : $name");
  });

  controller.add("Bob");
  controller.add("Alice");
  controller.add("Joe");
  controller.close();

  controller.onCancel=() {
    print("onCancel");
    sub1.cancel();
    sub2.cancel();
  };
}


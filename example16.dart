import 'dart:async';

void main(List<String> args) async {
  try {
    await for (final name in getNames().withTimouteBetweenEvents(const Duration(
      seconds: 3,
    ))) {
      print(name);
    }
  } on TimeoutBetweenEventsException catch (e, stacktrace) {
    print("TimeoutBetweenEventsException: $e");
    print("Stack trace: $stacktrace");
  }
}

Stream<String> getNames() async* {
  yield "John";
  await Future.delayed(const Duration(seconds: 1));
  yield "Bob";
  await Future.delayed(const Duration(seconds: 2));
  yield "Jane";
  await Future.delayed(const Duration(seconds: 10));
  yield "Alice";
}

extension WithTimouteBetweenEvents<T> on Stream<T> {
  Stream<T> withTimouteBetweenEvents(Duration duration) =>
      transform(TimeoutBetweenEvents(duration: duration));
}

class TimeoutBetweenEvents<E> extends StreamTransformerBase<E, E> {
  final Duration duration;

  const TimeoutBetweenEvents({required this.duration});

  @override
  Stream<E> bind(Stream<E> stream) {
    StreamController<E>? controller;
    StreamSubscription<E>? subscription;
    Timer? timer;

    controller = StreamController(
      onListen: () {
        (data) {
          timer!.cancel();
          timer = Timer.periodic(
            duration,
            (timer) {
              controller!.addError(
                TimeoutBetweenEventsException(message: "Timeout"),
              );
            },
          );
          controller!.add(data);
        };
      },
      onCancel: () {
        subscription!.cancel();
        timer!.cancel();
      },
    );

    return controller.stream;
  }
}

class TimeoutBetweenEventsException implements Exception {
  final String message;
  TimeoutBetweenEventsException({required this.message});
}

import 'dart:async';

void main(List<String> args) async {
  // await for(final name in names.map((name) => name.toUpperCase())){
  //   print(name);
  // }
  await for (final capitalizeName in names.capitalized) {
    print(capitalizeName);
  }
  print("_______________________");
  await for (final capitalizeName in names.capitalizeUsingMap) {
    print(capitalizeName);
  }
}

Stream<String> names =
    Stream.fromIterable(["Nairobi", "New York", "Cairo", "Beijing", "Dodoma"]);

extension on Stream<String> {
  Stream<String> get capitalized => transform(ToUpperCase());

  Stream<String> get capitalizeUsingMap => map((name) => name.toUpperCase());
}

class ToUpperCase extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.map((name) => name.toUpperCase());
  }
}

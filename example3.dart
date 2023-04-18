void main(List<String> args) async {
  final len1=await calculateLength(await getFullName());
  print(len1);
  getFullName().then((value) => calculateLength(value)).then((value) => print("**$value**"));
  
}

Future<String> getFullName() =>
    Future.delayed(const Duration(seconds: 1), () => "John Doe");

Future<int> calculateLength(String value) =>
    Future.delayed(const Duration(seconds: 1), () => value.length);

void main(List<String> args)async {
  print(await getName());
  print(await getsecondname());
  print(await getAddress());
  print(await getPhonenumber());
  print(await getZipcode());
}

Future<String> getName() async=>"John";
Future<String> getsecondname()=>Future.value("Doe");

Future<String> getAddress()=>Future.delayed(const Duration(seconds: 2), ()=>"johndoe@testing.com");

Future<String> getPhonenumber()async{
  await Future.delayed(const Duration(seconds: 1));
  return"555-5555-5555";
}
// async does not really contribute to anything in this exapmle
Future<String> getZipcode() async=>Future.delayed(const Duration(seconds: 3), (() => "12345"));
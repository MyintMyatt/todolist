class AppUserData {
  String userName;
  String gender;
  String occupation;
  DateTime birthday;
  int age;

  AppUserData(
      {required this.userName,
      required this.gender,
      required this.occupation,
      required this.birthday,
      required this.age});

  Map<String, Object> toJson() {
    return {
      'userName': userName,
      'gender': gender,
      'occupation': occupation,
      'birthday' : birthday.toIso8601String().split('T').first,
      'age': age
    };
  }
}

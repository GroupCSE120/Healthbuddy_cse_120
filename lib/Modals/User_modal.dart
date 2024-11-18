class UserModal {
  String name;
  DateTime dob;
  String sex;
  double height;
  double weight;

  Map<String, bool> healthMap;

  UserModal(
      {required this.name,
      required this.dob,
      required this.sex,
      required this.height,
      required this.weight,
      required this.healthMap});
}

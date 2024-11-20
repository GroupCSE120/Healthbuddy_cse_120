import 'package:hive/hive.dart';

class UserModal {
  String name;
  DateTime dob;
  String sex;
  double height;
  double weight;
  bool isDiabetes;
  bool isBP;
  bool isDisability;

  UserModal({
    required this.name,
    required this.dob,
    required this.sex,
    required this.height,
    required this.weight,
    required this.isDiabetes,
    required this.isBP,
    required this.isDisability,
  });
}

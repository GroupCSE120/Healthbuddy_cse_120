
import 'package:hive/hive.dart';
part 'user_modal.g.dart';

@HiveType(typeId: 0)
class UserModal {
  @HiveField(0)
  String name;
  @HiveField(1)
  DateTime dob;
  @HiveField(2)
  String sex;
  @HiveField(3)
  double height;
  @HiveField(4)
  double weight;
  @HiveField(5)
  Map<String, bool> healthMap;

  UserModal(
      {required this.name,
      required this.dob,
      required this.sex,
      required this.height,
      required this.weight,
      required this.healthMap});
}

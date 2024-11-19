import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../Modals/user_modal.dart';

class GetStartedController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  DateTime? dob;
  String sex = "";
  Map<String, bool> healthMap = {
    'Diabetes': false,
    'BP': false,
    'Disability': false,
  };

  void saveUserData() async {
    var userBox = await Hive.openBox<UserModal>('userBox');
    await userBox.put(
        "userData",
        UserModal(
          name: nameController.text,
          dob: dob ?? DateTime.now(),
          sex: sex,
          height: double.parse(heightController.text),
          weight: double.parse(weightController.text),
          healthMap: healthMap,
        ));
    print("User data saved: ${nameController.text}");
  }
}

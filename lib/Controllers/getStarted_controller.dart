import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/extension/method_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartedController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  DateTime? dob;
  String sex = "";
  bool isDiabetes = false;
  bool isBP = false;
  bool isDisabilities = false;

  void saveUserData() async {
    if (nameController.text.isNotEmpty &&
        dob != null &&
        sex.isNotEmpty &&
        heightController.text.isNotEmpty &&
        weightController.text.isNotEmpty) {
      try {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('username', nameController.text);
        sharedPreferences.setString('dob', dob!.toFormattedString());
        sharedPreferences.setString('sex', sex);
        sharedPreferences.setDouble(
            'height', double.parse(heightController.text.toString().trim()));
        sharedPreferences.setDouble(
            'weight', double.parse(weightController.text.toString().trim()));
        sharedPreferences.setBool('isDiabetes', isDiabetes);
        sharedPreferences.setBool('isBP', isBP);
        sharedPreferences.setBool('isDisability', isDisabilities);

        print("User data saved: ${nameController.text}");
      } catch (e) {
        print("Error saving user data: $e");
      }
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: 'Warning!!',
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        icon: Icon(
          Icons.warning_rounded,
          color: Colors.white,
          size: 30,
        ),
        borderRadius: 20,
        message: 'Please fill all of the above information.',
        duration: Duration(seconds: 2),
        backgroundColor: Colors.redAccent,
        dismissDirection: DismissDirection.horizontal,
      ));
    }
  }
}

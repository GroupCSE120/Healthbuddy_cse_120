import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalsController extends GetxController {

  TextEditingController calorieController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController fatController = TextEditingController();

  // Initialize with default values
  String calorieGoal = ""; // Default value for calorie goal
  String proteinsGoal = ""; // Default value for protein goal
  String fatGoal = ""; // Default value for fat goal

  HomeController homeController = Get.find<HomeController>();

  void saveGoals() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (calorieController.text.isNotEmpty &&
        proteinController.text.isNotEmpty && fatController.text.isNotEmpty) {
      try {
        calorieGoal = calorieController.text.toString();
        proteinsGoal = proteinController.text.toString();
        fatGoal = fatController.text.toString();

        homeController.goalsCalories = int.parse(calorieGoal);
        homeController.goalsProteins = int.parse(proteinsGoal);
        homeController.goalsFats = int.parse(fatGoal);

        sharedPreferences.setInt('calorieGoal', int.parse(calorieGoal));
        sharedPreferences.setInt('proteinsGoal', int.parse(proteinsGoal));
        sharedPreferences.setInt('fatsGoal', int.parse(fatGoal));

        print("${homeController.goalsCalories}===${homeController
            .goalsProteins}===${homeController.goalsFats}");
      }
      catch (e) {
        print("error saving goals : $e");
      }
    }
    else {
      Get.showSnackbar(const GetSnackBar(
        title: "Warning!",
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
    update();
  }

// // Set and get methods for Calorie Goals
// void setCalories(double calorieGoal) {
//   this.calorieGoal = calorieGoal;
//   update(); // Notify listeners of changes
// }
//
// double get calories {
//   return calorieGoal;
// }
//
// // Set and get methods for Protein Goals
// void setProtein(double proteinsGoal) {
//   this.proteinsGoal = proteinsGoal;
//   update(); // Notify listeners of changes
// }
//
// double get proteins {
//   return proteinsGoal;
// }
//
// // Set and get methods for Fat Goals
// void setFats(double fatGoal) {
//   this.fatGoal = fatGoal;
//   update(); // Notify listeners of changes
// }
//
// double get fats {
//   return fatGoal;
// }
}

import 'package:get/get.dart';

class GoalsController extends GetxController {
  // Initialize with default values
  double calorieGoal = 2000; // Default value for calorie goal
  double proteinsGoal = 50;  // Default value for protein goal
  double fatGoal = 70;       // Default value for fat goal

  // Set and get methods for Calorie Goals
  void setCalories(double calorieGoal) {
    this.calorieGoal = calorieGoal;
    update(); // Notify listeners of changes
  }

  double get calories {
    return calorieGoal;
  }

  // Set and get methods for Protein Goals
  void setProtein(double proteinsGoal) {
    this.proteinsGoal = proteinsGoal;
    update(); // Notify listeners of changes
  }

  double get proteins {
    return proteinsGoal;
  }

  // Set and get methods for Fat Goals
  void setFats(double fatGoal) {
    this.fatGoal = fatGoal;
    update(); // Notify listeners of changes
  }

  double get fats {
    return fatGoal;
  }
}

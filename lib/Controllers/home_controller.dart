
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Modals/food_modal.dart';
import 'package:health_buddy/repository/load_data.dart';
import 'package:hive/hive.dart';

import '../Modals/user_modal.dart';

class HomeController extends GetxController {
  int currentPageIndex = 0;
  PageController pageController = PageController();
  bool isDarkMode = false;
  late UserModal user;
  late List<FoodModal> foodList;

  List<FoodModal> breakfastItems = [];
  List<FoodModal> dinnerItems = [];
  List<FoodModal> lunchItems = [];

  final LoadData _loadData = LoadData();

  @override
  void onReady() {             // All data fetching function runs heres at the start when controller is initialized.
    getUserData();
    getFoodItemList();
    super.onReady();
  }

  void changePage(int index) {          // this is for changing the page don use this i have already settle this.
    currentPageIndex = index;
    pageController.animateToPage(
      currentPageIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    update();
  }

  void changeTheme(bool value) {         // From this we can change the theme its optional
    isDarkMode = !isDarkMode;
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    update();
  }

  void getUserData() async {                          // From this we get the user data from local storage
    var userBox = await Hive.openBox<UserModal>('userBox');
    user = userBox.get('userData') ??
        UserModal(
          name: "404",
          dob: DateTime.now(),
          sex: "404",
          height: 404,
          weight: 404,
          healthMap: {},
        );
    update();
  }

  void getFoodItemList() async {                // From this we get the data I have them in
    foodList = await _loadData.getCsvData();    // onReady state u can directly access the foodList
    update();
  }

  void addItemsToMealList(List<FoodModal> food, int mealCount) {      // Use this to add items to list
    if (mealCount == 0) {
      breakfastItems.forEach((element) => food.add(element),);
    } else if (mealCount == 1) {
      dinnerItems.forEach((element) => food.add(element),);
    } else if (mealCount == 3) {
      lunchItems.forEach((element) => food.add(element),);
    }
    update();
  }

  double get breakfastCalories {          // Use this to get total breakfast calories
    double count = 0;
    for (var element in breakfastItems) {
      count += element.calories;
    }
    return count;
  }

  double get lunchCalories {          // Use this to get total lunch calories
    double count = 0;
    for (var element in lunchItems) {
      count += element.calories;
    }
    return count;
  }

  double get dinnerCalories {          // Use this to get total dinner calories
    double count = 0;
    for (var element in dinnerItems) {
      count += element.calories;
    }
    return count;
  }
}

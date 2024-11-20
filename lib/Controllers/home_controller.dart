import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Modals/food_modal.dart';
import 'package:health_buddy/extension/method_extensions.dart';
import 'package:health_buddy/repository/load_data.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Modals/user_modal.dart';
import '../constants/app_color.dart';

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
  void onReady() {
    // All data fetching function runs heres at the start when controller is initialized.
    getUserData();
    getFoodItemList();
    super.onReady();
  }

  void changePage(int index) {
    // this is for changing the page don use this i have already settle this.
    currentPageIndex = index;
    pageController.animateToPage(
      currentPageIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    update();
  }

  void changeTheme(bool value) {
    // From this we can change the theme its optional
    isDarkMode = !isDarkMode;
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    update();
  }

  void getUserData() async {
    // From this we get the user data from local storage

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String name = sharedPreferences.getString('username') ?? "";
    String dob = sharedPreferences.getString('dob') ?? "";
    String sex = sharedPreferences.getString('sex') ?? "";
    double height = sharedPreferences.getDouble('height') ?? 0.0;
    double weight = sharedPreferences.getDouble('weight') ?? 0.0;
    bool isDiabetes = sharedPreferences.getBool('isDiabetes') ?? false;
    bool isBP = sharedPreferences.getBool('isBP') ?? false;
    bool isDisability = sharedPreferences.getBool('isDisability') ?? false;

    user = UserModal(
      name: name,
      dob: dob.toDateTime() ?? DateTime.now(),
      sex: sex,
      height: height,
      weight: weight,
      isDiabetes: isDiabetes,
      isBP: isBP,
      isDisability: isDisability,
    );
    update();
  }

  void getFoodItemList() async {
    // From this we get the data I have them in
    foodList = await _loadData
        .getCsvData(); // onReady state u can directly access the foodList
    update();
  }

  void addItemsToMealList(List<FoodModal> food, int mealCount) {
    // Use this to add items to list
    if (mealCount == 0) {
      for (var element in breakfastItems) {
        food.add(element);
      }
    } else if (mealCount == 1) {
      for (var element in dinnerItems) {
        food.add(element);
      }
    } else if (mealCount == 3) {
      for (var element in lunchItems) {
        food.add(element);
      }
    }
    update();
  }

  void selectFood() {
    Get.bottomSheet(
      // isScrollControlled: true,

      Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: AppColors.cardColor),
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const Text(
                "+ Add Food",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              ...List.generate(
                foodList.length,
                (index) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Text(
                          foodList[index].foodName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          )),
    );
  }

  double get breakfastCalories {
    // Use this to get total breakfast calories
    double count = 0;
    for (var element in breakfastItems) {
      count += element.calories;
    }
    return count;
  }

  double get lunchCalories {
    // Use this to get total lunch calories
    double count = 0;
    for (var element in lunchItems) {
      count += element.calories;
    }
    return count;
  }

  double get dinnerCalories {
    // Use this to get total dinner calories
    double count = 0;
    for (var element in dinnerItems) {
      count += element.calories;
    }
    return count;
  }

  double get bmi {
    double heightInM = user.height / 100;
    double heightSquare = heightInM * heightInM;

    double bmi = user.weight / heightSquare;
    return bmi;
  }

// weight / (height/ 100)^2
}

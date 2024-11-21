import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Modals/food_modal.dart';
import 'package:health_buddy/extension/method_extensions.dart';
import 'package:health_buddy/repository/load_data.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Modals/user_modal.dart';
import '../constants/app_color.dart';
import '../modals/list_of_food.dart';

class HomeController extends GetxController {
  int currentPageIndex = 0;
  PageController pageController = PageController();
  bool isDarkMode = false;
  int dailyGoal = 0;
  late UserModal user;
  late List<FoodModal> foodList;

  List<FoodModal> breakfastItems = [];
  List<FoodModal> dinnerItems = [];
  List<FoodModal> lunchItems = [];

  List<FoodModal> commonBreakfastListItems = [];
  List<FoodModal> commonLunchListItems = [];
  List<FoodModal> commonDinnerListItems = [];
  List<FoodModal> commonFavouriteListItems = [];

  final LoadData _loadData = LoadData();

  @override
  void onReady() {
    // All data fetching function runs here's at the start when controller is initialized.
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

    try {
      var box = await Hive.openBox<ListOfFood>("listOfFood");
      var variable = box.get('list');
      print(variable);
    } catch (e) {
      print(e);
    }
  }

  void getFoodItemList() async {
    // From this we get the data I have them in
    foodList = await _loadData
        .getCsvData(); // onReady state u can directly access the foodList
    update();
  }

  void addItemsToMealList(FoodModal food, int mealCount) async {
    getMealList(mealCount).add(food);
    update();
  }

  void removeItemsToMealList(FoodModal food, int mealCount) async {
    getMealList(mealCount).remove(food);
    update();
  }

  List<FoodModal> getMealList(int mealCount) {
    if (mealCount == 0) {
      return breakfastItems;
    } else if (mealCount == 1) {
      return lunchItems;
    } else if (mealCount == 2) {
      return dinnerItems;
    }
    return [];
  }

  void bmiBottomSheet() {
    Get.bottomSheet(
      const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "BMI : Body Mass Index",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'BMI is a measure of body fat based on height and weight. It helps assess if an individual is underweight, normal weight, overweight, or obese.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Underweight: Less than 18.5\nHealthy weight: 18.5 to 24.9\nOverweight: 25 to 29.9\nObesity: 30 or greater',
              style: TextStyle(fontSize: 16, color: Colors.white60),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
    );
  }

  void selectFood(int mealCount) async {
    List<FoodModal> tempList = foodList; // Default list
    String tempListName = "All Food List"; // Default dropdown value
    Map<String, int> itemCount = {};

    for (var item in getMealList(mealCount)) {
      itemCount[item.foodName] = (itemCount[item.foodName] ?? 0) + 1;
    }

    final waitToAdd = await Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: AppColors.cardColor,
        ),
        padding: const EdgeInsets.all(20),
        child: StatefulBuilder(
          builder: (context, setState) {
            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "+ Add Food",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    DropdownButton(
                      items: const [
                        DropdownMenuItem(
                          value: "All Food List",
                          child: Text("All Food List"),
                        ),
                        DropdownMenuItem(
                          value: "Favorite List",
                          child: Text("Favorite List"),
                        ),
                        DropdownMenuItem(
                          value: "Breakfast List",
                          child: Text("Breakfast List"),
                        ),
                        DropdownMenuItem(
                          value: "Lunch List",
                          child: Text("Lunch List"),
                        ),
                        DropdownMenuItem(
                          value: "Dinner List",
                          child: Text("Dinner List"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          if (value == "All Food List") {
                            tempList = foodList;
                          } else if (value == "Favorite List") {
                            tempList = commonFavouriteListItems;
                          } else if (value == "Breakfast List") {
                            tempList = commonBreakfastListItems;
                          } else if (value == "Lunch List") {
                            tempList = commonLunchListItems;
                          } else if (value == "Dinner List") {
                            tempList = commonDinnerListItems;
                          }
                          tempListName = value!;
                        });
                        print("Selected: $value");
                      },
                      value: tempListName,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      borderRadius: BorderRadius.circular(20),
                      dropdownColor: AppColors.cardColor,
                    ),
                  ],
                ),
                ...List.generate(
                  tempList.length,
                      (index) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                                color: Colors.white,
                                child: Image.asset("assets/images/logo.jpg")),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tempList[index].foodName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "Calories: ${tempList[index].calories}",
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    "Proteins: ${tempList[index].protiens}",
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    "Fats: ${tempList[index].fats}",
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.limeAccent.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: itemCount[tempList[index].foodName] != null &&
                                  itemCount[tempList[index].foodName]! > 0
                                  ? Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        removeItemsToMealList(
                                            tempList[index], mealCount);
                                        itemCount[tempList[index]
                                            .foodName] =
                                            (itemCount[tempList[index]
                                                .foodName]! -
                                                1)
                                                .clamp(0, double.infinity)
                                                .toInt();
                                      });
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${itemCount[tempList[index].foodName]}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        addItemsToMealList(
                                            tempList[index], mealCount);
                                        itemCount[tempList[index]
                                            .foodName] =
                                            (itemCount[tempList[index]
                                                .foodName] ??
                                                0) +
                                                1;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                                  : InkWell(
                                onTap: () {
                                  setState(() {
                                    addItemsToMealList(
                                        tempList[index], mealCount);
                                    itemCount[tempList[index].foodName] =
                                        (itemCount[tempList[index]
                                            .foodName] ??
                                            0) +
                                            1;
                                  });
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );

    if (waitToAdd == null) {
      update();
      print("Food selection completed.");
    }
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

  double get foodCalories {
    double count = 0;
    List<FoodModal> list = [...breakfastItems, ...lunchItems, ...dinnerItems];
    for (var element in list) {
      count += element.calories;
    }
    return count;
  }

  double get foodProtein {
    double count = 0;
    List<FoodModal> list = [...breakfastItems, ...lunchItems, ...dinnerItems];
    for (var element in list) {
      count += element.protiens;
    }
    return count;
  }

  double get foodFats {
    double count = 0;
    List<FoodModal> list = [...breakfastItems, ...lunchItems, ...dinnerItems];
    for (var element in list) {
      count += element.fats;
    }
    return count;
  }
=======
  String get status{
    if( bmi < 18.5){
      return " Underweight";
    }else if(bmi > 18.5 && bmi < 24.9){
      return "Health Weight";
    }else if (bmi > 25 && bmi < 29.9){
      return "Overweight";
    }else{
      return "Obesity";
    }
  }

// weight / (height/ 100)^2

}

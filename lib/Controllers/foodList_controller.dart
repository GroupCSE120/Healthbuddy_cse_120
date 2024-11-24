import 'dart:convert';

import 'package:get/get.dart';
import 'package:health_buddy/Controllers/home_controller.dart';
import 'package:health_buddy/Modals/food_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodListController extends GetxController {
  List<List<FoodModal>> userFoodLists = [];
  List<String> listTitles = [];

  List<FoodModal> foodList = [];
  List<bool> selectedItems = [];

  HomeController homeController = Get.find<HomeController>();

  @override
  void onInit() {
    foodList = homeController.foodList;
    userFoodLists = homeController.userCustomFoodLists;
    listTitles = homeController.userCustomFoodListTitles;

    selectedItems = List<bool>.filled(foodList.length, false);

    super.onInit();
  }


  void getFoodItemList() async {
    foodList = Get.find<HomeController>().foodList;
    selectedItems = List<bool>.filled(foodList.length, false);
    update();
  }

  void createFoodList(String title) {
    List<FoodModal> selectedFoods = [];
    for (int i = 0; i < foodList.length; i++) {
      if (selectedItems[i]) {
        selectedFoods.add(foodList[i]);
      }
    }
    if (selectedFoods.isNotEmpty) {
      userFoodLists.add(selectedFoods);
      listTitles.add(title);
      update();
    }
    saveData();
    update();
  }

  void saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("userCustomFoodListTitles", listTitles);

    List<String> userFoodListsJson = userFoodLists.map((list) {
      return jsonEncode(list.map((food) => food.toJson()).toList());
    }).toList();

    await sharedPreferences.setStringList("userCustomFoodList", userFoodListsJson);
  }

  void updateFoodList(String listname) {}
}

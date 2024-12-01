import 'dart:convert';

import 'package:flutter/material.dart';
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

  void refineFoodListByTempreature(double tempreature) {
    int tempRange;
    if (tempreature < 36.5) {
      tempRange = 1;
      Get.snackbar(
        "Temperature Alert",
        "Your body temperature is Low.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey.shade800,
        colorText: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        borderRadius: 10,
        borderColor: Colors.cyan,
        borderWidth: 2,
        icon: Icon(Icons.thermostat, color: Colors.cyan, size: 24),
        padding: const EdgeInsets.all(16),
        animationDuration: const Duration(milliseconds: 300),
        barBlur: 15,
        isDismissible: true,
        duration: const Duration(seconds: 5),


      );
    }
    else if (tempreature > 37.5){
      tempRange = 2;
      Get.snackbar(
        "Temperature Alert",
        "Your body temperature is High",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey.shade900,
        colorText: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        borderRadius: 10,
        borderColor: Colors.cyan,
        borderWidth: 2,
        icon: Icon(Icons.thermostat, color: Colors.cyan, size: 24),
        padding: const EdgeInsets.all(16),
        animationDuration: const Duration(milliseconds: 300),
        barBlur: 15,
        isDismissible: true,
        duration: const Duration(seconds: 5),
      );
    }
    else{
      tempRange = 0;
      Get.snackbar(
        "Temperature Alert",
        "Your body temperature is Normal.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey.shade800,
        colorText: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        borderRadius: 10,
        borderColor: Colors.cyan,
        borderWidth: 2,
        icon: Icon(Icons.thermostat, color: Colors.cyan, size: 24),
        padding: const EdgeInsets.all(16),
        animationDuration: const Duration(milliseconds: 300),
        barBlur: 15,
        isDismissible: true,
        duration: const Duration(seconds: 5),

      );
    }
    List<FoodModal> refinedList = [];
    if(tempRange == 1){
      refinedList =  foodList.where((food) => food.tempRate == 1).toList();
    }
    else if( tempRange == 2){
      refinedList = foodList.where((food) => food.tempRate == 2).toList();
    }
    else{
      refinedList = foodList;
    }

    update();

  }

  void saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("userCustomFoodListTitles", listTitles);

    List<String> userFoodListsJson = userFoodLists.map((list) {
      return jsonEncode(list.map((food) => food.toJson()).toList());
    }).toList();

    await sharedPreferences.setStringList(
        "userCustomFoodList", userFoodListsJson);
  }

  void updateFoodList(String listname) {}
}

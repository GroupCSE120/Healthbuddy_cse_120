import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Modals/food_modal.dart';
import 'package:health_buddy/constants/app_color.dart';

import '../Controllers/home_controller.dart';

class Diet extends StatelessWidget {
  const Diet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        // Design the diet plan don't make any button functional just display it.
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          body: ListView(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.cardColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 15),
                      child: DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            value: 'Calories',
                            child: Text("Calories Remaining"),
                          ),
                          DropdownMenuItem(
                            value: 'Protein',
                            child: Text("Protein Remaining"),
                          ),
                          DropdownMenuItem(
                            value: 'Fats',
                            child: Text("Fats Remaining"),
                          ),
                        ],
                        value: "Protein",
                        onChanged: (value) {},
                        isExpanded: true,
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: AppColors.bgColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              controller.dailyGoal.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const Text(
                              'Goal',
                              style: TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                        const Text(
                          '-',
                          style: TextStyle(color: Colors.white70, fontSize: 30),
                        ),
                        Column(
                          children: [
                            Text(
                              controller.foodCalories.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const Text(
                              'Food',
                              style: TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                        const Text(
                          '+',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                        const Column(
                          children: [
                            Text(
                              '0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Exercise',
                              style: TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                        const Text(
                          '=',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 25,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '${controller.dailyGoal - controller.foodCalories}',
                              style: TextStyle(
                                color: AppColors.lightBlue,
                                fontSize: 20,
                              ),
                            ),
                            const Text(
                              'Remaining',
                              style: TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              selectFood("Breakfast", () {
                controller.selectFood(0);
              }, controller.breakfastItems),
              selectFood("Lunch", () {
                controller.selectFood(1);
              }, controller.lunchItems),
              selectFood("Dinner", () {
                controller.selectFood(2);
              }, controller.dinnerItems),
            ],
          ),
        );
      },
    );
  }

  Widget selectFood(
      String foodItem, VoidCallback addFood, List<FoodModal> list) {
    final Map<String, int> itemCount = {};
    for (var item in list) {
      itemCount[item.foodName] = (itemCount[item.foodName] ?? 0) + 1;
    }

    final List<FoodModal> uniqueItems = list.toSet().toList();

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: AppColors.cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 5),
            child: Text(
              foodItem,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const Divider(),
          ...List.generate(uniqueItems.length, (index) {
            return Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade800.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      child: Image.asset("assets/images/logo.jpg"),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            uniqueItems[index].foodName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Calories: ${uniqueItems[index].calories}",
                            style: const TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            "Proteins: ${uniqueItems[index].protiens}",
                            style: const TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            "Fats: ${uniqueItems[index].fats}",
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
                    flex: 2,
                    child:
                    Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.limeAccent.shade200,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    int count = 0;
                                    if (foodItem == "Breakfast") {
                                      count = 0;
                                    } else if (foodItem == "Lunch") {
                                      count = 1;
                                    } else if (foodItem == "Dinner") {
                                      count = 2;
                                    }
                                    Get.find<HomeController>().removeItemsToMealList(uniqueItems[index], count);
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "${itemCount[uniqueItems[index].foodName]}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    int count = 0;
                                    if (foodItem == "Breakfast") {
                                      count = 0;
                                    } else if (foodItem == "Lunch") {
                                      count = 1;
                                    } else if (foodItem == "Dinner") {
                                      count = 2;
                                    }
                                    Get.find<HomeController>().addItemsToMealList(uniqueItems[index], count);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ))
                  ),
                ],
              ),
            );
          }),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: addFood,
              child: const Text(
                "+ Add Food",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

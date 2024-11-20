import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
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
                              '0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
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
                              '0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Food',
                              style: TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                        Text(
                          '+',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                        Column(
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
                        Text(
                          '=',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 25,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '9999',
                              style: TextStyle(
                                color: AppColors.lightBlue,
                                fontSize: 20,
                              ),
                            ),
                            Text(
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
              selectFood("Breakfast", () {controller.selectFood();}),
              selectFood("Lunch", () {controller.selectFood();}),
              selectFood("Dinner", () {controller.selectFood();}),
            ],
          ),
        );
      },
    );
  }

  Widget selectFood(String foodItem, VoidCallback addFood) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: AppColors.cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 15),
            child: Text(
              foodItem,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const Divider(),
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

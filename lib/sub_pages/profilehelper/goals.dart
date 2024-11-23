import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Controllers/goal_controller.dart';
import 'package:health_buddy/constants/app_color.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoalsController>(
      // Initialize the controller
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Set your Goals accordingly...",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(height: 30),
                  _buildGoalSetter(
                    controller: controller.calorieController,
                    labelText: "Enter Your Daily Calories Goals",
                    title: 'Set Calories',
                    keyboardType: TextInputType.number,
                    unit: "Cal",
                  ),
                  const SizedBox(height: 20),
                  _buildGoalSetter(
                    controller: controller.proteinController,
                    labelText: "Enter Your Daily Protein Goals",
                    title: 'Set Proteins',
                    keyboardType: TextInputType.number,
                    unit: "g",
                  ),
                  const SizedBox(height: 20),
                  _buildGoalSetter(
                    controller: controller.fatController,
                    labelText: "Enter Your Daily Fats Goals",
                    title: 'Set Fats',
                    keyboardType: TextInputType.number,
                    unit: "g",
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Container(
            margin: const EdgeInsets.all(12),
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  backgroundColor:
                      WidgetStatePropertyAll(Colors.indigo.shade900)),
              onPressed: () {
                controller.saveGoals();

                Get.snackbar(
                  'Goals Updated',
                  'Your Goals are set successfully!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 3)
                );

              },
              child: const Text(
                'Save My Goals',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildGoalSetter({
    required TextEditingController controller,
    required String labelText,
    required String title,
    TextInputType keyboardType = TextInputType.number,
    required String unit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title :",
          style: TextStyle(
            color: Colors.indigo.shade400,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: labelText,
                  hintStyle: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "$unit.",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

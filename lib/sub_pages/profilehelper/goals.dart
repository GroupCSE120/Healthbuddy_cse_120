import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:health_buddy/Controllers/goal_controller.dart';
import 'package:health_buddy/constants/app_color.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoalsController>(
      init: GoalsController(), // Initialize the controller
      builder: (controller) {
        final calorieController =
        TextEditingController(text: controller.calories.toString());
        final proteinController =
        TextEditingController(text: controller.proteins.toString());
        final fatController =
        TextEditingController(text: controller.fats.toString());

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: AppBar(
            title: const Text('Set Goals'),
            backgroundColor: AppColors.darkBlue,
          ),
          body: SingleChildScrollView(
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
                  controller: calorieController,
                  title: 'Set Calories',
                  keyboardType: TextInputType.number,
                  unit: "Cal",
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.setCalories(double.parse(value));
                    }
                  },
                ),
                const SizedBox(height: 20),
                _buildGoalSetter(
                  controller: proteinController,
                  title: 'Set Proteins',
                  keyboardType: TextInputType.number,
                  unit: "g",
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.setProtein(double.parse(value));
                    }
                  },
                ),
                const SizedBox(height: 20),
                _buildGoalSetter(
                  controller: fatController,
                  title: 'Set Fats',
                  keyboardType: TextInputType.number,
                  unit: "g",
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.setFats(double.parse(value));
                    }
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: Container(
            width: double.infinity,
            height: 85,
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                controller.setCalories(double.tryParse(calorieController.text) ?? 0.0);
                controller.setProtein(double.tryParse(proteinController.text) ?? 0.0);
                controller.setFats(double.tryParse(fatController.text) ?? 0.0);

                Get.snackbar('Goals Updated',
                    'Your Goals are set successfully!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
                controller.update();

                // Get.back();
                // controller.proteins = proteinController.text;
                // Get.off(
                //   const HomePage(),
                //   binding: HomeBinder(),
                //   transition: Transition.leftToRightWithFade,
                // );
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
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildGoalSetter({
    required TextEditingController controller,
    required String title,
    TextInputType keyboardType = TextInputType.number,
    required String unit,
    required Function(String) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white60, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title :",
            style: TextStyle(color: AppColors.lightBlue, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.lightBlue,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text("${unit}.",style: TextStyle(color: Colors.white, fontSize: 24),),
            ],
          ),
        ],
      ),
    );
  }
}

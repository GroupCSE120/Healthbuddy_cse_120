import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/binders/home_binder.dart';
import 'package:health_buddy/constants/app_color.dart';
import 'package:health_buddy/Controllers/getStarted_controller.dart';
import 'package:health_buddy/pages/home_page.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetStartedController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                'Let\'s Get Started!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please fill out the following details:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.65),
                ),
              ),
              const SizedBox(height: 24),

              textfieldWidget(controller.nameController, "Name", Icons.person,
                  TextInputType.name),
              const SizedBox(height: 24),

              textfieldWidget(controller.dobController, "Date of Birth",
                  Icons.person, TextInputType.datetime, isReadOnly: true,
                  action: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: controller.dob,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  controller.dob = pickedDate;
                  controller.dobController.text =
                      controller.dob.toString().split(' ')[0];
                  controller.update();
                }
              }),
              const SizedBox(height: 24),

              DropdownButtonFormField<String>(
                value: null,
                dropdownColor: AppColors.darkBg,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => controller.sex = value ?? '',
                decoration: InputDecoration(
                  labelText: 'Sex',
                  prefixIcon:
                      const Icon(Icons.transgender, color: Colors.white),
                  labelStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    borderSide:
                        BorderSide(color: AppColors.lightBlue, width: 2),
                  ),
                ),
                items: ['Male', 'Female', 'Other']
                    .map(
                      (sex) => DropdownMenuItem(
                        value: sex,
                        child: Text(sex),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: textfieldWidget(
                      controller.heightController,
                      "Height (cm)",
                      Icons.height,
                      TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: textfieldWidget(
                        controller.weightController,
                        "Weight (kg)",
                        Icons.fitness_center,
                        TextInputType.number),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Health Conditions
              Text(
                'Health Conditions',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CheckboxListTile(
                title: const Text(
                  "Diabetes",
                  style: TextStyle(color: Colors.white),
                ),
                value: controller.isDiabetes,
                onChanged: (value) {
                  controller.isDiabetes = value ?? false;
                  controller.update();
                },
                activeColor: AppColors.green,
                checkColor: Colors.black,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                title: const Text(
                  "BP",
                  style: TextStyle(color: Colors.white),
                ),
                value: controller.isBP,
                onChanged: (value) {
                  controller.isBP = value ?? false;
                  controller.update();
                },
                activeColor: AppColors.green,
                checkColor: Colors.black,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                title: const Text(
                  "Disability",
                  style: TextStyle(color: Colors.white),
                ),
                value: controller.isDisabilities,
                onChanged: (value) {
                  controller.isDisabilities = value ?? false;
                  controller.update();
                },
                activeColor: AppColors.green,
                checkColor: Colors.black,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 24),

              // Get Started Button
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
              controller.saveUserData();
              Get.off(
                const HomePage(),
                binding: HomeBinder(),
                transition: Transition.leftToRightWithFade,
              );
            },
            child: const Text(
              'Get Started',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  Widget textfieldWidget(TextEditingController controller, String label,
      IconData icon, TextInputType type,
      {VoidCallback? action, bool isReadOnly = false}) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      readOnly: isReadOnly,
      onTap: action,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.white),
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: AppColors.lightBlue,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: AppColors.lightBlue,
            width: 2,
          ),
        ),
      ),
    );
  }
}

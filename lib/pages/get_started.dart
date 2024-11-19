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
        backgroundColor: AppColors.darkBg,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 24),

              // Name Field
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.lightBlue, width: 1.5),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Date of Birth Field
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.lightBlue, width: 1.5),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextFormField(

                  style: const TextStyle(color: Colors.white),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: controller.dob,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      controller.dob = pickedDate;
                      controller.update();
                    }
                  },
                  decoration: InputDecoration(
                    labelText:
                    'Date of Birth: ${controller.dob.toString().split(' ')[0]}',
                    prefixIcon:
                    const Icon(Icons.calendar_today, color: Colors.white),
                    labelStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Sex Field
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.lightBlue, width: 1.5),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: DropdownButtonFormField<String>(
                  value: null,
                  dropdownColor: AppColors.darkBg,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) => controller.sex = value ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Sex',
                    prefixIcon: Icon(Icons.transgender, color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
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
              ),
              const SizedBox(height: 16),

              // Height and Weight Fields
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.darkBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: AppColors.lightBlue, width: 1.5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        controller: controller.heightController,
                        style: const TextStyle(color: Colors.white),
                        // onChanged: (value) => controller.height.value =
                        //     double.tryParse(value) ?? 0.0,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Height (cm)',
                          prefixIcon: Icon(Icons.height, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.darkBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: AppColors.lightBlue, width: 1.5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        controller: controller.weightController,
                        style: const TextStyle(color: Colors.white),
                        // onChanged: (value) => controller.weight.value =
                        //     double.tryParse(value) ?? 0.0,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Weight (kg)',
                          prefixIcon:
                              Icon(Icons.fitness_center, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
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
              Column(
                children: ['Diabetes', 'BP', 'Disability']
                    .map(
                      (condition) => CheckboxListTile(
                        title: Text(
                          condition,
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: controller.healthMap[condition] ?? false,
                        onChanged: (value) {
                          controller.healthMap[condition] = value ?? false;
                          controller.update();
                        },
                        activeColor: AppColors.green,
                        checkColor: Colors.black,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),

              // Get Started Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightBlue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    controller.saveUserData();
                    Get.off(const HomePage(), binding: HomeBinder());
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
            ],
          ),
        ),
      );
    });
  }
}

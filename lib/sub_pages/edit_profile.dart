import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Controllers/home_controller.dart';
import 'package:health_buddy/constants/app_color.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        final nameController = TextEditingController(text: controller.user.name);
        final heightController =
        TextEditingController(text: controller.user.height.toString());
        final weightController =
        TextEditingController(text: controller.user.weight.toString());

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: AppBar(
            title: const Text('Edit Profile'),
            backgroundColor: AppColors.darkBlue,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildSectionTitle("Basic Information"),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: nameController,
                  label: "Name",
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                _buildDatePickerField(
                  context: context,
                  label: "Date of Birth",
                  value:
                  "${controller.user.dob.day}-${controller.user.dob.month}-${controller.user.dob.year}",
                  icon: Icons.calendar_today,
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: controller.user.dob,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      controller.user.dob = selectedDate;
                      controller.update();
                    }
                  },
                ),
                const SizedBox(height: 20),
                _buildDropdownField(
                  value: controller.user.sex,
                  label: "Gender",
                  icon: Icons.transgender,
                  items: ['Male', 'Female', 'Other'],
                  onChanged: (value) {
                    if (value != null) {
                      controller.user.sex = value;
                      controller.update();
                    }
                  },
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: heightController,
                  label: "Height (cm)",
                  icon: Icons.height,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: weightController,
                  label: "Weight (kg)",
                  icon: Icons.monitor_weight,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30),
                _buildSectionTitle("Health Conditions"),
                const SizedBox(height: 10),
                _buildSwitchTile(
                  title: "Diabetes",
                  value: controller.user.isDiabetes,
                  onChanged: (value) {
                    controller.user.isDiabetes = value;
                    controller.update();
                  },
                ),
                _buildSwitchTile(
                  title: "Blood Pressure",
                  value: controller.user.isBP,
                  onChanged: (value) {
                    controller.user.isBP = value;
                    controller.update();
                  },
                ),
                _buildSwitchTile(
                  title: "Disability",
                  value: controller.user.isDisability,
                  onChanged: (value) {
                    controller.user.isDisability = value;
                    controller.update();
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      // Save user data
                      controller.user.name = nameController.text;
                      controller.user.height =
                          double.tryParse(heightController.text) ?? 0.0;
                      controller.user.weight =
                          double.tryParse(weightController.text) ?? 0.0;


                      Get.snackbar(
                        'Profile Updated',
                        'Your changes have been saved successfully!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.green,
                        colorText: Colors.white,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  // Common TextField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: AppColors.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  // Common Date Picker Widget
  Widget _buildDatePickerField({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white70),
          filled: true,
          fillColor: AppColors.cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          value,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // Common Dropdown Widget
  Widget _buildDropdownField({
    required String value,
    required String label,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map(
            (e) => DropdownMenuItem(
          value: e,
          child: Text(e),
        ),
      )
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: AppColors.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      dropdownColor: AppColors.cardColor,
      style: const TextStyle(color: Colors.white),
    );
  }

  // Common Switch Tile Widget
  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.green,
      tileColor: AppColors.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

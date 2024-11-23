import 'package:flutter/material.dart';
import 'package:health_buddy/constants/app_color.dart';

class CalorieCalculator extends StatefulWidget {
  const CalorieCalculator({super.key});

  @override
  State<CalorieCalculator> createState() => _CalorieCalculatorState();
}

class _CalorieCalculatorState extends State<CalorieCalculator> {
  late double BMR;
  double TDEE = 0.0; // Initialize with a default value
  late double height;
  late double weight;
  late double age;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController ageController;

  String gender = 'Male';
  double PAL = 1.2; // Default sedentary activity level

  @override
  void initState() {
    super.initState();
    heightController = TextEditingController();
    weightController = TextEditingController();
    ageController = TextEditingController();
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    super.dispose();
  }

  // Calculate BMR based on the gender
  double calculateBMR() {
    double weightInKg = double.parse(weightController.text);
    double heightInCm = double.parse(heightController.text);
    double ageInYears = double.parse(ageController.text);

    if (gender == 'Male') {
      // BMR for Men
      return 88.362 +
          (13.397 * weightInKg) +
          (4.799 * heightInCm) -
          (5.677 * ageInYears);
    } else {
      // BMR for Women
      return 447.593 +
          (9.247 * weightInKg) +
          (3.098 * heightInCm) -
          (4.330 * ageInYears);
    }
  }

  // Calculate TDEE based on PAL
  double calculateTDEE() {
    BMR = calculateBMR();
    return BMR * PAL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Center(
                    child: Text(
                      "Calorie Calculator",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Height input
                textfieldWidget(heightController, "Height (cm)", Icons.height,
                    TextInputType.number),
                const SizedBox(height: 10),
                // Weight input
                textfieldWidget(weightController, "Weight (kg)",
                    Icons.fitness_center_rounded, TextInputType.number),
                const SizedBox(height: 10),
                // Age input
                textfieldWidget(ageController, "Age (years)", Icons.numbers,
                    TextInputType.number),
                const SizedBox(height: 20),

                // Gender Selection
                Row(
                  children: [
                    const Text(
                      "Gender: ",
                      style: TextStyle(color: Colors.white),
                    ),
                    Radio<String>(
                      value: 'Male',
                      groupValue: gender,
                      fillColor: const WidgetStatePropertyAll(Colors.lightBlue),
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    const Text(
                      "Male",
                      style: TextStyle(color: Colors.white),
                    ),
                    Radio<String>(
                      value: 'Female',
                      groupValue: gender,
                      fillColor: const WidgetStatePropertyAll(Colors.lightBlue),
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    const Text(
                      "Female",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // PAL Selection
                DropdownButton<double>(
                  value: PAL,
                  style: const TextStyle(color: Colors.white),
                  borderRadius: BorderRadius.circular(25),
                  dropdownColor: AppColors.cardColor,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: 1.2,
                      child: Text('Sedentary (1.2)'),
                    ),
                    DropdownMenuItem(
                      value: 1.375,
                      child: Text('Lightly Active (1.375)'),
                    ),
                    DropdownMenuItem(
                      value: 1.55,
                      child: Text('Moderately Active (1.55)'),
                    ),
                    DropdownMenuItem(
                      value: 1.725,
                      child: Text('Very Active (1.725)'),
                    ),
                    DropdownMenuItem(
                      value: 1.9,
                      child: Text('Super Active (1.9)'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      PAL = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Calculate button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.indigo.shade900),
                    ),
                    onPressed: () {
                      setState(() {
                        TDEE =
                            calculateTDEE(); // Update TDEE only when the button is pressed
                      });
                    },
                    child: const Text(
                      "Calculate Calories",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Display Result
                if (TDEE > 0)
                  Text(
                    'Your Total Daily Energy Expenditure (TDEE) is: ${TDEE.toStringAsFixed(2)} Calories',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
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

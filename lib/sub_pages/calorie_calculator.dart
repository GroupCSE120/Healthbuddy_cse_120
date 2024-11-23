import 'package:flutter/material.dart';

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
  double PAL = 1.2;  // Default sedentary activity level

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
      return 88.362 + (13.397 * weightInKg) + (4.799 * heightInCm) - (5.677 * ageInYears);
    } else {
      // BMR for Women
      return 447.593 + (9.247 * weightInKg) + (3.098 * heightInCm) - (4.330 * ageInYears);
    }
  }

  // Calculate TDEE based on PAL
  double calculateTDEE() {
    BMR = calculateBMR();
    return BMR * PAL;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Height input
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Height (cm)"),
            ),
            const SizedBox(height: 10),
            // Weight input
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Weight (kg)"),
            ),
            const SizedBox(height: 10),
            // Age input
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age (years)"),
            ),
            const SizedBox(height: 20),

            // Gender Selection
            Row(
              children: [
                Text("Gender: "),
                Radio<String>(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                const Text("Male"),
                Radio<String>(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                const Text("Female"),
              ],
            ),

            const SizedBox(height: 20),

            // PAL Selection
            DropdownButton<double>(
              value: PAL,
              items: [
                DropdownMenuItem(child: Text('Sedentary (1.2)'), value: 1.2),
                DropdownMenuItem(child: Text('Lightly Active (1.375)'), value: 1.375),
                DropdownMenuItem(child: Text('Moderately Active (1.55)'), value: 1.55),
                DropdownMenuItem(child: Text('Very Active (1.725)'), value: 1.725),
                DropdownMenuItem(child: Text('Super Active (1.9)'), value: 1.9),
              ],
              onChanged: (value) {
                setState(() {
                  PAL = value!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Calculate button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  TDEE = calculateTDEE();  // Update TDEE only when the button is pressed
                });
              },
              child: const Text("Calculate Calories"),
            ),
            const SizedBox(height: 20),

            // Display Result
            if (TDEE > 0)
              Text(
                'Your Total Daily Energy Expenditure (TDEE) is: ${TDEE.toStringAsFixed(2)} Calories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

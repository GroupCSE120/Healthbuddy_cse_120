import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Dietai extends StatefulWidget {
  const Dietai({super.key});

  @override
  State<Dietai> createState() => _DietaiState();
}

class _DietaiState extends State<Dietai> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController excludeController = TextEditingController();

  String? gender;
  String? physicalActivity;
  String? goal;
  String? dietType;

  bool isLoading = false;
  String? assistantMessage;
  bool isResponseGenerated = false;

  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> activities = ['Sedentary', 'Moderate', 'Active'];
  final List<String> goals = ['Weight Loss', 'Maintain Weight', 'Weight Gain'];
  final List<String> dietTypes = ['Vegetarian', 'Vegan', 'Keto', 'Low Carb', 'Paleo'];
  List<Map<String, String>> savedPlans = [];

  Future<void> saveDietPlanToLocal(String id, String plan) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, plan);
    setState(() {
      savedPlans.add({'id': id, 'plan': plan});
    });
  }

  Future<void> loadSavedPlans() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    setState(() {
      savedPlans = keys.map((id) => {'id': id, 'plan': prefs.getString(id)!}).toList();
    });
  }

  Future<void> generateDietPlan() async {
    setState(() {
      isLoading = true;
      assistantMessage = null;
      isResponseGenerated = false;
    });

    String prompt = "Generate a weekly diet plan based on the following data:\n"
        "Age: ${ageController.text}\n"
        "Height: ${heightController.text}\n"
        "Weight: ${weightController.text}\n"
        "Gender: $gender\n"
        "Physical Activity: $physicalActivity\n"
        "Goal: $goal\n"
        "Diet Type: $dietType\n"
        "Foods to Exclude: ${excludeController.text}\n\n"
        "The plan should be structured as follows:\n"
        "Day:\n"
        "    Breakfast:\n"
        "    Lunch:\n"
        "    Dinner:\n\n"
        "Include meals for all 7 days of the week in this format.\n"
        "do not give me any code , just a normal text";

    String payload = jsonEncode({
      'model': 'meta-llama/Meta-Llama-3.1-8B-Instruct-Turbo',
      "prompt": prompt,
    });

    final String apiKey = "81ae561ed7fe920dd7d30a96b82a793feab87f4e3c1cb138d6283f3df5e1e3a8";
    final String apiUrl = 'https://api.together.xyz/v1/chat/completions';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: payload,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'];

        setState(() {
          assistantMessage = content;
          isResponseGenerated = true;
        });

        final String uniqueId = DateTime.now().toIso8601String();
        await saveDietPlanToLocal(uniqueId, content);
      } else {
        throw Exception('Failed to generate diet plan');
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate diet plan: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadSavedPlans();
  }

  void showSavedPlanModal(String id, String plan) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Diet Plan - $id', style: const TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Text(plan, style: const TextStyle(color: Colors.white)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Diet Planner'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (savedPlans.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Saved Diet Plans',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: savedPlans.length,
                      itemBuilder: (context, index) {
                        final plan = savedPlans[index];
                        return ListTile(
                          title: Text(plan['id']!,
                              style: const TextStyle(color: Colors.white)),
                          trailing: IconButton(
                            icon: const Icon(Icons.visibility, color: Colors.blue),
                            onPressed: () => showSavedPlanModal(plan['id']!, plan['plan']!),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              if (isResponseGenerated)
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isResponseGenerated = false;
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Generate Another Plan'),
                    ),
                    const SizedBox(height: 20),
                    if (assistantMessage != null)
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          assistantMessage!,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                  ],
                ),
              if (!isResponseGenerated)
                Column(

                  children: [
                    buildTextField('Age', ageController, TextInputType.number),
                    buildTextField('Height (cm)', heightController, TextInputType.number),
                    buildTextField('Weight (kg)', weightController, TextInputType.number),
                    buildDropdown('Gender', genders, gender, (value) => gender = value),
                    buildDropdown('Physical Activity', activities, physicalActivity,
                            (value) => physicalActivity = value),
                    buildDropdown('Goal', goals, goal, (value) => goal = value),
                    buildDropdown('Diet Type', dietTypes, dietType, (value) => dietType = value),
                    buildTextField('Foods to Exclude', excludeController, TextInputType.text),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(

                        onPressed: isLoading ? null : generateDietPlan,
                        icon: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Icon(Icons.fastfood),
                        label: const Text('Generate Diet Plan'),
                      ),
                    ),
                    const SizedBox(height: 50,),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.edit),
        ),
        keyboardType: inputType,
      ),
    );
  }

  Widget buildDropdown(String label, List<String> items, String? value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }
}

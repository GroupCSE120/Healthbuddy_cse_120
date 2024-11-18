import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Controllers/getStarted_controller.dart';

class Getstarted extends StatelessWidget {
  const Getstarted({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetStartedController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Center(

          child: Form(
              child: Column(
            children: [
              TextFormField(
                onChanged: (value) => controller.name.value = value,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                  labelStyle: TextStyle(color: Colors.white)
                ),
              ),
              const SizedBox(height: 16),

              // Date of Birth Field
              Obx(() => TextFormField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.dob.value,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    controller.dob.value = pickedDate;
                  }
                },
                decoration: InputDecoration(
                  labelText:
                  'Date of Birth: ${controller.dob.value.toLocal()}',
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
              )),
              const SizedBox(height: 16),

              // Sex Field
              DropdownButtonFormField<String>(
                value: null,
                onChanged: (value) => controller.sex.value = value ?? '',
                decoration: const InputDecoration(
                  labelText: 'Sex',
                  prefixIcon: Icon(Icons.transgender),
                ),
                items: ['Male', 'Female', 'Other']
                    .map((sex) => DropdownMenuItem(
                  value: sex,
                  child: Text(sex),
                ))
                    .toList(),
              ),
              const SizedBox(height: 16),

              // Height Field
              TextFormField(
                onChanged: (value) =>
                controller.height.value = double.tryParse(value) ?? 0.0,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height (cm)',
                  prefixIcon: Icon(Icons.height),
                ),
              ),
              const SizedBox(height: 16),

              // Weight Field
              TextFormField(
                onChanged: (value) =>
                controller.weight.value = double.tryParse(value) ?? 0.0,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                  prefixIcon: Icon(Icons.fitness_center),
                ),
              ),
              const SizedBox(height: 16),

              // Health Conditions
              Text('Health Conditions', style: Theme.of(context).textTheme.bodyLarge),
              Obx(() => Column(
                children: ['Diabetes', 'BP', 'Disability']
                    .map((condition) => CheckboxListTile(
                  title: Text(condition),
                  value: controller.healthMap[condition] ?? false,
                  onChanged: (value) =>
                  controller.healthMap[condition] = value ?? false,
                  controlAffinity: ListTileControlAffinity.leading,
                ))
                    .toList(),
              )),
              const SizedBox(height: 24),
              FilledButton(
                  onPressed: (){
                    controller.saveUserData();
                  },
                  child: Text('Get Started'),
              )],
          )),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Pages/splash_screen.dart';
import 'package:health_buddy/modals/food_modal.dart';
import 'package:health_buddy/modals/list_of_food.dart';
import 'package:health_buddy/modals/user_modal.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(FoodModalAdapter());
  await Hive.openBox<List<FoodModal>>("foodModal");

  Hive.registerAdapter(ListOfFoodAdapter());
  await Hive.openBox<ListOfFood>("listOfFood");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Buddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
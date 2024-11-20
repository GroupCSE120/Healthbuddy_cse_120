import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Pages/splash_screen.dart';
import 'package:health_buddy/modals/user_modal.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // try {
  //   await Hive.initFlutter();
  //   Hive.registerAdapter(UserModalAdapter());
  //   debugPrint('Initializing the app: ${Hive.isAdapterRegistered(0)}');
  //
  // } catch (e) {
  //   debugPrint('Error initializing the app: $e');
  // }
  //
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
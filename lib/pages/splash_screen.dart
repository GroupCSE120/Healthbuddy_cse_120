import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/binders/home_binder.dart';
import 'package:health_buddy/constants/app_color.dart';
import 'package:health_buddy/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Binders/getStarted_binder.dart';
import 'get_started.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool isFirstTime = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Scale animation for logo
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    // Start animation
    _controller.forward();

    checkTheNewUser();

    // Navigate after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (!isFirstTime) {
        Get.off(const GetStarted(), binding: GetStartedBinder());
      } else {
        Get.off(const HomePage(), binding: HomeBinder());
      }
    });
  }

  Future<void> checkTheNewUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString('username') != null) {
      print("true");
      isFirstTime = true;
    } else {
      print("false");
      isFirstTime = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightBlue.withOpacity(0.2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.darkBlue.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/logo.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Health Buddy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: AppColors.green,
                    shadows: [
                      Shadow(
                        color: AppColors.lightBlue,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

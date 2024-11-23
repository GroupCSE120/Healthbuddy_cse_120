import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/sub_pages/another.dart';
import 'package:health_buddy/sub_pages/calorie_calculator.dart';
import 'package:health_buddy/sub_pages/diet.dart';
import 'package:health_buddy/sub_pages/home.dart';
import 'package:health_buddy/sub_pages/profile.dart';

import '../Controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: PageView.builder(
            controller: controller.pageController,
            itemCount: 4,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Home();
              } else if (index == 1) {
                return const Diet();
              } else if (index == 2){
                return const CalorieCalculator();
              }else if (index == 3){
                return const Profile();
              }
              return const Center(child: Text("Error 404: Page Not Found"));
            },
            onPageChanged: (value) {
              controller.currentPageIndex = value;
              controller.update();
            },
          ),
          extendBody: true,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: const [
              Icons.home_filled,
              Icons.food_bank,
              Icons.calculate,
              Icons.person_rounded,
            ],
            activeIndex: controller.currentPageIndex,
            onTap: (value) {
              controller.changePage(value);
            },
            activeColor: Colors.amber,
            inactiveColor: Colors.white54,
            backgroundColor: const Color(0xff232327),
            gapLocation: GapLocation.none,
            notchSmoothness: NotchSmoothness.softEdge,
            notchMargin: 12,
            leftCornerRadius: 25,
            rightCornerRadius: 25,
            height: 65,
            splashSpeedInMilliseconds: 250,
          ),
        );
      },
    );
  }
}

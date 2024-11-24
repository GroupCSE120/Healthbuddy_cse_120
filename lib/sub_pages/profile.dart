import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Binders/foodList_binder.dart';
import 'package:health_buddy/Binders/goal_binder.dart';
import 'package:health_buddy/Controllers/home_controller.dart';
import 'package:health_buddy/constants/app_color.dart';
import 'package:health_buddy/sub_pages/profilehelper/foodList.dart';
import 'package:health_buddy/sub_pages/profilehelper/goals.dart';

import 'profilehelper/edit_profile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
          backgroundColor: AppColors.bgColor,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                          image: AssetImage(
                              "assets/images/doctor-5216835_640.webp"),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.cardColor,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${controller.user.name[0].toUpperCase()}${controller.user.name.substring(1).toLowerCase()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                      onPressed: () => {Get.to(() => const EditProfile())},
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.grey.shade900),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action for "Set Goals"
                    Get.to(
                      const Goals(),
                      binding: GoalBinder(),
                      transition: Transition.leftToRight,
                    )?.then(
                      (value) => controller.update(),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(AppColors.cardColor),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.gavel_outlined, color: Colors.white),
                      SizedBox(width: 30),
                      Expanded(
                        child: Text(
                          'Set Goals',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Get.to(const Foodlist(),
                        binding: FoodListbinder(),
                        transition: Transition.leftToRight);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(AppColors.cardColor),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.list_alt_outlined, color: Colors.white),
                      SizedBox(width: 30),
                      Expanded(
                        child: Text(
                          'Create Food Lists',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    // Action for "Personal Notes"
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(AppColors.cardColor),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.note_alt_sharp, color: Colors.white),
                      SizedBox(width: 30),
                      Expanded(
                        child: Text(
                          'Personal Notes',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }
}

class ProfileMenuWidget {}

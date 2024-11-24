import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Controllers/home_controller.dart';
import 'package:health_buddy/constants/app_color.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        if (!controller.isLoading) {
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            body: Stack(
              children: [
                Positioned(
                  top: 100,
                  left: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hey!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        '${controller.user.name[0].toUpperCase()}${controller.user.name.substring(1).toLowerCase()}',
                        style: TextStyle(
                          color: AppColors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      const Text(
                        'This is your Health Buddy.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 0,
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/greeting_img1.png'),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 1.35,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      ),
                      color: AppColors.cardColor,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade800,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "BMI Status",
                                style: TextStyle(
                                  color: AppColors.lightBlue,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildStatCard(
                                    context,
                                    icon: Icons.height,
                                    value: '${controller.user.height}',
                                    label: 'Height (cm)',
                                  ),
                                  _buildStatCard(
                                    context,
                                    icon: Icons.fitness_center,
                                    value: '${controller.user.weight}',
                                    label: 'Weight (kg)',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "BMI : ${controller.bmi.toString().substring(0, 5)}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.bmiBottomSheet();
                                    },
                                    icon: Icon(
                                      Icons.help_outline_rounded,
                                      color: Colors.lightBlueAccent.shade100,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "Status: ${controller.status}",
                                style: TextStyle(
                                  color: AppColors.lightGreen,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        CarouselSlider(
                          items: controller.foodList.map((i) {
                            return Builder(
                              builder: (context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                    border: Border.all(color: AppColors.lightBlue, width: 1.5,),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Text("${i.foodName}", style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold),),
                                      Text("Glycemic Index : ${i.glycemicIndex}", style: TextStyle(color: Colors.white70),),
                                      Text("Calories : ${i.calories} cal.", style: TextStyle(color: Colors.white70),),
                                      Text("Proteins : ${i.protiens} g.", style: TextStyle(color: Colors.white70),),
                                      Text("Fats : ${i.fats} g.", style: TextStyle(color: Colors.white70),),
                                      Text("Carbohydrates : ${i.carbohydrates} g.", style: TextStyle(color: Colors.white70),),
                                      Text("Sodium (Na) : ${i.sodium} g.", style: TextStyle(color: Colors.white70),),
                                      Text("Potassium (K) : ${i.pottasium} g.", style: TextStyle(color: Colors.white70),),
                                      Text("Magnesium (Mg) : ${i.magnesium} g.", style: TextStyle(color: Colors.white70),),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 250,
                            aspectRatio: 18 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.2,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildStatCard(BuildContext context, {required IconData icon, required String value, required String label}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 145,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade800.withOpacity(0.5),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 35),
              const SizedBox(width: 8),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Controllers/home_controller.dart';
import 'package:health_buddy/constants/app_color.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
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
                      '${controller.user.name[0].toUpperCase()}${controller.user
                          .name.substring(1).toLowerCase()}',
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
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 1.35,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      ),
                      color: AppColors.cardColor,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
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
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 145,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              color: Colors.grey.shade800
                                                  .withOpacity(0.5)),
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.height,
                                                color: Colors.white,
                                                size: 35,
                                              ),
                                              Text(
                                                '${controller.user.height}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Text(
                                          'Height (cm)',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 145,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              color: Colors.grey.shade800
                                                  .withOpacity(0.5)),
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.fitness_center,
                                                color: Colors.white,
                                                size: 35,
                                              ),
                                              Text(
                                                '${controller.user.weight}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Text(
                                          'Weight (kg)',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "BMI : ${controller.bmi.toString()
                                          .substring(0, 4)}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          backgroundColor: AppColors.cardColor,
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "BMI : Body Mass Index",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    'BMI is a measure of body fat based on height and weight. It helps assess if an individual is underweight, normal weight, overweight, or obese.',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Text('Underweight: Less than 18.5\nHealthy weight: 18.5 to 24.9\nOverweight: 25 to 29.9\nObesity: 30 or greater', style: TextStyle(fontSize: 16, color: Colors.white60),),
                                                  const SizedBox(height: 20),
                                                  Center(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context); // Close the modal
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.blue,
                                                      ),
                                                      child: const Text('Close',style: TextStyle(color: Colors.white),),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.help, color: Colors.white),
                                    ),

                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Note: BMI is in normal range, maintain it",
                                  style: TextStyle(
                                    color: AppColors.lightGreen,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}

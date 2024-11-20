import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Controllers/home_controller.dart';
import 'package:health_buddy/constants/app_color.dart';

import 'profilehelper/edit_profile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
          backgroundColor: AppColors.bgColor,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                              image: AssetImage("assets/images/doctor-5216835_640.webp")),
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
                          child: Icon(
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
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () => {
                          Get.to(()=> const EditProfile())
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightBlue,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Edit Profile', style: TextStyle(color: AppColors.darkBg, fontSize: 18,),),
                            Icon(Icons.edit, color: AppColors.bgColor,),
                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 30,),
                  const Divider(),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){

                    },
                    child: Card(
                      color: AppColors.cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.gavel_outlined, color: Colors.white,),
                            SizedBox(width: 30,),
                            Text('Set Goals', style: TextStyle(fontSize: 24, color: Colors.white),),
                            SizedBox(width: 30,),
                            IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right, color: Colors.white,)),
                          ],

                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){

                    },
                    child: Card(
                      color: AppColors.cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.list_alt_outlined, color: Colors.white,),
                            SizedBox(width: 30,),
                            Text('Create Food Lists', style: TextStyle(fontSize: 24, color: Colors.white),),
                            SizedBox(width: 30,),
                            IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right, color: Colors.white,)),
                          ],

                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){

                    },
                    child: Card(
                      color: AppColors.cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.note_alt_sharp, color: Colors.white,),
                            SizedBox(width: 30,),
                            Text('Personal Notes', style: TextStyle(fontSize: 24, color: Colors.white),),
                            SizedBox(width: 30,),
                            IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right, color: Colors.white,)),
                          ],

                        ),
                      ),
                    ),
                  )




                ],
              ),
            ),
          ));
    });
  }
}

class ProfileMenuWidget {
}

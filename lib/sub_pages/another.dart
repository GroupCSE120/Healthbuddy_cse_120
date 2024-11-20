
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../Controllers/home_controller.dart';

class Another extends StatelessWidget{
  const Another({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {      // Design the diet plan don't make any button functional just display it.
        return const Scaffold();
      },
    );
  }

}
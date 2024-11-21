import 'package:get/get.dart';
import 'package:health_buddy/Controllers/goal_controller.dart';

class GoalBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> GoalsController());
  }

}
import 'package:get/get.dart';
import 'package:health_buddy/Controllers/foodList_controller.dart';

class FoodListbinder extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> FoodListController());
  }

}
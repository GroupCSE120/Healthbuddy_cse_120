import 'package:get/get.dart';
import 'package:health_buddy/Controllers/home_controller.dart';

class HomeBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(),);
  }

}
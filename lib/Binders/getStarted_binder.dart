import 'package:get/get.dart';
import 'package:health_buddy/Controllers/getStarted_controller.dart';

class GetStartedBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> GetStartedController());
  }

}
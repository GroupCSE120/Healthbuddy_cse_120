import 'package:get/get.dart';

import '../Modals/User_modal.dart';

class GetStartedController extends GetxController{
  final name = ''.obs;
  final dob = DateTime.now().obs;
  final sex = ''.obs;
  final height = 0.0.obs;
  final weight = 0.0.obs;
  final healthMap = <String, bool>{}.obs;


  void saveUserData(){
    // saving of userData
    final user = UserModal(
      name: name.value,
      dob: dob.value,
      sex: sex.value,
      height: height.value,
      weight: weight.value,
      healthMap: healthMap,
    );
    print("user data saved: $user");
  }
}
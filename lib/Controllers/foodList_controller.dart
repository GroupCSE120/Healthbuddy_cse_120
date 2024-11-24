import 'package:get/get.dart';
import 'package:health_buddy/Controllers/home_controller.dart';
import 'package:health_buddy/Modals/food_modal.dart';
import 'package:health_buddy/repository/load_data.dart';

class FoodListController extends GetxController{
  late List<List<FoodModal>> userFoodLists = [];
  late List<String> listTitles = [];
  List<FoodModal> foodList = [];
  late List<bool> selectedItems = [];
  HomeController obj = HomeController();



  @override
  void onInit() {
    foodList = Get.find<HomeController>().foodList;
    selectedItems = List<bool>.filled(foodList.length,false);

    super.onInit();
  }

  @override
  void onReady(){
    super.onReady();
    // getFoodItemList();
  }




  void getFoodItemList() async{
    foodList = Get.find<HomeController>().foodList;
    selectedItems = List<bool>.filled(foodList.length,false);
    update();
  }



  void createFoodList(String title){
    List<FoodModal> selectedFoods = [];
    for(int i=0; i<foodList.length; i++){
      if(selectedItems[i]){
        selectedFoods.add(foodList[i]);
      }
    }
    if(selectedFoods.isNotEmpty){
      userFoodLists.add(selectedFoods);
      listTitles.add(title);
      update();
    }
    update();


  }

  void updateFoodList(String listname){}

}
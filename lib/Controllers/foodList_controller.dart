import 'package:get/get.dart';
import 'package:health_buddy/Controllers/home_controller.dart';
import 'package:health_buddy/Modals/food_modal.dart';
import 'package:health_buddy/repository/load_data.dart';

class FoodListController extends GetxController{
  late List<List<FoodModal>> foodLists = [];
  late List<String> listTitles = [];
  late List<FoodModal> foodList = [];
  late List<bool> selectedItems = [];
  HomeController obj = HomeController();

  LoadData _loadData = LoadData();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(_loadData.allFoodItemsList);
  }

  @override
  void onReady(){
    super.onReady();
    getFoodItemList();
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
      foodLists.add(selectedFoods);
      listTitles.add(title);
      update();
    }
    update();


  }

  void updateFoodList(String listname){}




}
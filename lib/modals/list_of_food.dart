
import 'package:health_buddy/modals/food_modal.dart';
import 'package:hive/hive.dart';

part 'list_of_food.g.dart';
@HiveType(typeId: 2)
class ListOfFood {
  @HiveField(0)
  List<FoodModal> foodList;
  
  ListOfFood({required this.foodList});
}
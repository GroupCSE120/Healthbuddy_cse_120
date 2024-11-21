import 'package:hive/hive.dart';

part 'food_modal.g.dart';
@HiveType(typeId: 1)
class FoodModal{
  @HiveField(0)
  String foodName;
  @HiveField(1)
  double glycemicIndex;
  @HiveField(2)
  double calories;
  @HiveField(3)
  double carbohydrates;
  @HiveField(4)
  double protiens;
  @HiveField(5)
  double fats;
  @HiveField(6)
  double sodium;
  @HiveField(7)
  double pottasium;
  @HiveField(8)
  double magnesium;
  @HiveField(9)
  double calcium ;
  @HiveField(10)
  double fiber;
  @HiveField(11)
  bool sugar;
  @HiveField(12)
  bool bp;

  FoodModal({
    required this.foodName,
    required this.glycemicIndex,
    required this.calories,
    required this.carbohydrates,
    required this.protiens,
    required this.fats,
    required this.sodium,
    required this.pottasium,
    required this.magnesium,
    required this.calcium,
    required this.fiber,
    required this.sugar,
    required this.bp,

  });

}
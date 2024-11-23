import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:health_buddy/Modals/food_modal.dart';

class LoadData {
  List<FoodModal> allFoodItemsList = [];

  Future<List<FoodModal>> getCsvData() async {
    try {
      final rawData =
          await rootBundle.loadString("assets/csv/food_list_csv.csv");
      List<List<dynamic>> data = const CsvToListConverter().convert(rawData);
      print(data);
      allFoodItemsList = _mapDataFromCsv(data);
      return allFoodItemsList; // Map and returns data after loading CSV
    } catch (e) {
      print("Error loading CSV: $e");
      return [];
    }
  }

  List<FoodModal> _mapDataFromCsv(List<List<dynamic>> data) {
    List<FoodModal> foodList = [];
    // Iterate through the CSV rows and map them to the FoodModal list
    for (var i = 1; i < data.length; i++) {
      var row = data[i];
      try {
        foodList.add(FoodModal(
          foodName: row[0],
          glycemicIndex: double.parse(row[1].toString()),
          calories: double.parse(row[2].toString()),
          carbohydrates: double.parse(row[3].toString()),
          protiens: double.parse(row[4].toString()),
          fats: double.parse(row[5].toString()),
          sodium: double.parse(row[8].toString()),
          pottasium: double.parse(row[9].toString()),
          magnesium: double.parse(row[10].toString()),
          calcium: double.parse(row[11].toString()),
          fiber: double.parse(row[12].toString()),
          sugar: row[6].toString() == "1",
          bp: row[7].toString() == "1",
          id: int.parse(row[13].toString()),
        ));
      } catch (e) {
        print("Error parsing row $i: $e");
        print("$row");
      }
    }

    return foodList;
  }

  List<FoodModal> returnListFromIds(List<String> list) {
    List<FoodModal> foodList = [];

    for (var element in list) {
      int index = int.parse(element) - 1;
      foodList.add(allFoodItemsList[index]);
    }
    return foodList;
  }
}

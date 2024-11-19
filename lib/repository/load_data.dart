import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:health_buddy/Modals/food_modal.dart';

class LoadData {
  Future<List<FoodModal>> getCsvData() async {
    try {
      final rawData = await rootBundle.loadString("assets/CSV/prd4.csv");
      List<List<dynamic>> data = const CsvToListConverter().convert(rawData);
      return _mapDataFromCsv(data); // Map and returns data after loading CSV
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
          glycemicIndex: row[1].toDouble(),
          calories: row[2].toDouble(),
          carbohydrates: row[3].toDouble(),
          protiens: row[4].toDouble(),
          fats: row[5].toDouble(),
          sodium: row[8].toDouble(),
          pottasium: row[9].toDouble(),
          magnesium: row[10].toDouble(),
          calcium: row[11].toDouble(),
          fiber: row[12].toDouble(),
          sugar: row[6] == 1,
          bp: row[7] == 1,
        ));
      } catch (e) {
        print("Error parsing row $i: $e");
      }
    }

    return foodList;
  }
}

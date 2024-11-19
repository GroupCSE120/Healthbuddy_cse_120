import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:health_buddy/Modals/Food_modal.dart';

class LoadData {
  List<List<dynamic>> _csvList = [];
  List<FoodModal> foodList = [];

  Future<void> getCsvData() async {
    try {
      final rawData = await rootBundle.loadString("assets/CSV/prd4.csv");
      List<List<dynamic>> csvList = const CsvToListConverter().convert(rawData);
      _csvList = csvList;
      _mapDataFromCsv(); // Map data after loading CSV
    } catch (e) {
      print("Error loading CSV: $e");
    }
  }

  void _mapDataFromCsv() {
    // Iterate through the CSV rows and map them to the FoodModal list
    for (var i = 1; i < _csvList.length; i++) { // Skipping the header row
      var row = _csvList[i];
      try {
        foodList.add(FoodModal(
          foodName: row[0] as String,
          glycemicIndex: (row[1] as num).toDouble(),
          calories: (row[2] as num).toDouble(),
          carbohydrates: (row[3] as num).toDouble(),
          protiens: (row[4] as num).toDouble(),
          fats: (row[5] as num).toDouble(),
          sodium: (row[8] as num).toDouble(),
          pottasium: (row[9] as num).toDouble(),
          magnesium: (row[10] as num).toDouble(),
          calcium: (row[11] as num).toDouble(),
          fiber: (row[12] as num).toDouble(),
          sugar: row[6] == 1,
          bp: row[7] == 1,
        ));
      } catch (e) {
        print("Error parsing row $i: $e");
      }
    }
  }

}
class FoodModal {
  String foodName;
  double glycemicIndex;
  double calories;
  double carbohydrates;
  double protiens;
  double fats;
  double sodium;
  double pottasium;
  double magnesium;
  double calcium;
  double fiber;
  bool sugar;
  bool bp;
  int id;
  int tempRate;

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
    required this.id,
    required this.tempRate,
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'foodName': foodName,
      'glycemicIndex': glycemicIndex,
      'calories': calories,
      'carbohydrates': carbohydrates,
      'protiens': protiens,
      'fats': fats,
      'sodium': sodium,
      'pottasium': pottasium,
      'magnesium': magnesium,
      'calcium': calcium,
      'fiber': fiber,
      'sugar': sugar,
      'bp': bp,
      'id': id,
      'temp_rate' : tempRate,
    };
  }

  // Convert JSON to object
  factory FoodModal.fromJson(Map<String, dynamic> json) {
    return FoodModal(
      foodName: json['foodName'],
      glycemicIndex: json['glycemicIndex'],
      calories: json['calories'],
      carbohydrates: json['carbohydrates'],
      protiens: json['protiens'],
      fats: json['fats'],
      sodium: json['sodium'],
      pottasium: json['pottasium'],
      magnesium: json['magnesium'],
      calcium: json['calcium'],
      fiber: json['fiber'],
      sugar: json['sugar'],
      bp: json['bp'],
      id: json['id'],
      tempRate: json['temp_rate'],
    );
  }
}

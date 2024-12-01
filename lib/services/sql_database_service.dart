import 'package:health_buddy/Modals/food_modal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDatabaseService {
  Database? _db1;
  Database? _db2;
  Database? _db3;
  static final SqlDatabaseService instance = SqlDatabaseService._constructor();

  SqlDatabaseService._constructor();

  final String _databaseName = "health_db";
  final String _tableName1 = "breakfast_table";
  final String _tableName2 = "lunchlist_table";
  final String _tableName3 = "dinnerlist_table";
  final String _columnIdName = "id";
  final String _columnFoodName = "food";
  final String _columnGlycemicName = "glycemic";
  final String _columnCaloriesName = "calories";
  final String _columnCarbohydratesName = "carbohydrates";
  final String _columnProtiensName = "protiens";
  final String _columnFatsName = "fats";
  final String _columnSodiumName = "sodium";
  final String _columnPottasiumName = "pottasium";
  final String _columnMagnesiumName = "magnesium";
  final String _columnCalciumName = "calcium";
  final String _columnFiberName = "fiber";
  final String _columnSugarName = "sugar";
  final String _columnBPName = "bp";
  final String _columnTimeStampName = "timestamp";
  final String _columnTempRateName = 'temp_rate';

  Future<Database> get database1 async {
    if (_db1 != null) return _db1!;
    _db1 = await getDatabase(_tableName1);
    return _db1!;
  }

  Future<Database> get database2 async {
    if (_db2 != null) return _db2!;
    _db2 = await getDatabase(_tableName2);
    return _db2!;
  }

  Future<Database> get database3 async {
    if (_db3 != null) return _db3!;
    _db3 = await getDatabase(_tableName3);
    return _db3!;
  }

  Future<Database> getDatabase(String tableName) async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, _databaseName);

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            $_columnIdName INTEGER PRIMARY KEY,
            $_columnFoodName TEXT NOT NULL,
            $_columnGlycemicName REAL NOT NULL,
            $_columnCaloriesName REAL NOT NULL,
            $_columnCarbohydratesName REAL NOT NULL,
            $_columnProtiensName REAL NOT NULL,
            $_columnFatsName REAL NOT NULL,
            $_columnSodiumName REAL NOT NULL,
            $_columnPottasiumName REAL NOT NULL,
            $_columnMagnesiumName REAL NOT NULL,
            $_columnCalciumName REAL NOT NULL,
            $_columnFiberName REAL NOT NULL,
            $_columnSugarName INTEGER NOT NULL,
            $_columnBPName INTEGER NOT NULL,
            $_columnTimeStampName INTEGER NOT NULL,
            $_columnTempRateName INTEGER NOT NULL,
            date TEXT NOT NULL,
          )
          ''');
      },
    );
    return database;
  }

  Future<List<FoodModal>> getList(
      Future<Database> database, String tableName, String whereArgs) async {
    final db = await database;
    final data =
        await db.query(tableName, where: "date = ?", whereArgs: [whereArgs]);

    List<FoodModal> list = data
        .map(
          (e) => FoodModal(
            foodName: e[_columnIdName] as String,
            glycemicIndex: e[_columnGlycemicName] as double,
            calories: e[_columnCaloriesName] as double,
            carbohydrates: e[_columnCarbohydratesName] as double,
            protiens: e[_columnProtiensName] as double,
            fats: e[_columnFatsName] as double,
            sodium: e[_columnSodiumName] as double,
            pottasium: e[_columnPottasiumName] as double,
            magnesium: e[_columnMagnesiumName] as double,
            calcium: e[_columnCalciumName] as double,
            fiber: e[_columnFiberName] as double,
            sugar: e[_columnSugarName] as int == 1,
            bp: e[_columnBPName] as int == 1,
            id: e[_columnIdName] as int,
            tempRate: e[_columnTempRateName] as int
          ),
        )
        .toList();

    return list;
  }

  Future<void> insertFoodList(
      Future<Database> database, List<FoodModal> foodList, String tableName) async {
    final db = await database;

    for(var food in foodList) {
      await db.insert(
        tableName,
        {
          _columnFoodName: food.foodName,
          _columnGlycemicName: food.glycemicIndex,
          _columnCaloriesName: food.calories,
          _columnCarbohydratesName: food.carbohydrates,
          _columnProtiensName: food.protiens,
          _columnFatsName: food.fats,
          _columnSodiumName: food.sodium,
          _columnPottasiumName: food.pottasium,
          _columnMagnesiumName: food.magnesium,
          _columnCalciumName: food.calcium,
          _columnFiberName: food.fiber,
          _columnSugarName: food.sugar ? 1 : 0,
          _columnBPName: food.bp ? 1 : 0,
          'date': DateTime.now().toIso8601String(),
        },
      );
    }
  }

  Future<void> updateFoodList(
      Future<Database> database, List<FoodModal> foodList, String tableName) async {
    final db = await database;

    for(var food in foodList) {
      await db.insert(
        tableName,
        {
          _columnFoodName: food.foodName,
          _columnGlycemicName: food.glycemicIndex,
          _columnCaloriesName: food.calories,
          _columnCarbohydratesName: food.carbohydrates,
          _columnProtiensName: food.protiens,
          _columnFatsName: food.fats,
          _columnSodiumName: food.sodium,
          _columnPottasiumName: food.pottasium,
          _columnMagnesiumName: food.magnesium,
          _columnCalciumName: food.calcium,
          _columnFiberName: food.fiber,
          _columnSugarName: food.sugar ? 1 : 0,
          _columnBPName: food.bp ? 1 : 0,
          'date': DateTime.now().toIso8601String(),
        },
      );
    }
  }
}

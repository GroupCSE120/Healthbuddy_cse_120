// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodModalAdapter extends TypeAdapter<FoodModal> {
  @override
  final int typeId = 1;

  @override
  FoodModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodModal(
      foodName: fields[0] as String,
      glycemicIndex: fields[1] as double,
      calories: fields[2] as double,
      carbohydrates: fields[3] as double,
      protiens: fields[4] as double,
      fats: fields[5] as double,
      sodium: fields[6] as double,
      pottasium: fields[7] as double,
      magnesium: fields[8] as double,
      calcium: fields[9] as double,
      fiber: fields[10] as double,
      sugar: fields[11] as bool,
      bp: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FoodModal obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.foodName)
      ..writeByte(1)
      ..write(obj.glycemicIndex)
      ..writeByte(2)
      ..write(obj.calories)
      ..writeByte(3)
      ..write(obj.carbohydrates)
      ..writeByte(4)
      ..write(obj.protiens)
      ..writeByte(5)
      ..write(obj.fats)
      ..writeByte(6)
      ..write(obj.sodium)
      ..writeByte(7)
      ..write(obj.pottasium)
      ..writeByte(8)
      ..write(obj.magnesium)
      ..writeByte(9)
      ..write(obj.calcium)
      ..writeByte(10)
      ..write(obj.fiber)
      ..writeByte(11)
      ..write(obj.sugar)
      ..writeByte(12)
      ..write(obj.bp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
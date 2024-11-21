// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_of_food.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListOfFoodAdapter extends TypeAdapter<ListOfFood> {
  @override
  final int typeId = 2;

  @override
  ListOfFood read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListOfFood(
      foodList: (fields[0] as List).cast<FoodModal>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListOfFood obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.foodList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListOfFoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

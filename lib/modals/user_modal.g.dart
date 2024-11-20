// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModalAdapter extends TypeAdapter<UserModal> {
  @override
  final int typeId = 0;

  @override
  UserModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModal(
      name: fields[0] as String,
      dob: fields[1] as DateTime,
      sex: fields[2] as String,
      height: fields[3] as double,
      weight: fields[4] as double,
      healthMap: (fields[5] as Map).cast<String, bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModal obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dob)
      ..writeByte(2)
      ..write(obj.sex)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.healthMap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

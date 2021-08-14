// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveFilmModelAdapter extends TypeAdapter<HiveFilmModel> {
  @override
  final int typeId = 0;

  @override
  HiveFilmModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveFilmModel(
      originalTitle: fields[0] as String,
      title: fields[1] as String,
      releseDate: fields[2] as DateTime?,
      posterPath: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveFilmModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.originalTitle)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.releseDate)
      ..writeByte(3)
      ..write(obj.posterPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveFilmModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

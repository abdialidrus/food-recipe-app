// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_recipe_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodRecipeTableAdapter extends TypeAdapter<FoodRecipeTable> {
  @override
  final int typeId = 0;

  @override
  FoodRecipeTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodRecipeTable(
      pk: fields[0] as int,
      title: fields[1] as String,
      publisher: fields[2] as String,
      featuredImage: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FoodRecipeTable obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.publisher)
      ..writeByte(3)
      ..write(obj.featuredImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodRecipeTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterModelAdapter extends TypeAdapter<CharacterModel> {
  @override
  final int typeId = 0;

  @override
  CharacterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterModel(
      id: fields[0] as int,
      name: fields[1] as String,
      height: fields[2] as String,
      mass: fields[3] as String,
      hairColor: fields[4] as String,
      skinColor: fields[5] as String,
      eyeColor: fields[6] as String,
      birthYear: fields[7] as String,
      gender: fields[8] as String,
      homeWorld: fields[9] as String,
      species: (fields[10] as List)?.cast<String>(),
      url: fields[11] as String,
      isFavorite: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.mass)
      ..writeByte(4)
      ..write(obj.hairColor)
      ..writeByte(5)
      ..write(obj.skinColor)
      ..writeByte(6)
      ..write(obj.eyeColor)
      ..writeByte(7)
      ..write(obj.birthYear)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.homeWorld)
      ..writeByte(10)
      ..write(obj.species)
      ..writeByte(11)
      ..write(obj.url)
      ..writeByte(12)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

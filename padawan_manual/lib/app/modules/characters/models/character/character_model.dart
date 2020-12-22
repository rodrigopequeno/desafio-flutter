import 'package:hive/hive.dart';

import '../../../../shared/utils/constants.dart';

part 'character_model.g.dart';

@HiveType(typeId: 0)
class CharacterModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String height;
  @HiveField(3)
  String mass;
  @HiveField(4)
  String hairColor;
  @HiveField(5)
  String skinColor;
  @HiveField(6)
  String eyeColor;
  @HiveField(7)
  String birthYear;
  @HiveField(8)
  String gender;
  @HiveField(9)
  String homeWorld;
  @HiveField(10)
  List<String> species = <String>[];
  @HiveField(11)
  String url;
  @HiveField(12)
  bool isFavorite;
  @HiveField(13)
  String homeWorldUrl;
  @HiveField(14)
  List<String> speciesUrl;

  CharacterModel({
    this.id,
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeWorld,
    this.species,
    this.url,
    this.isFavorite,
    this.homeWorldUrl,
    this.speciesUrl,
  });

  final regExpUrl = RegExp(kStandardUrlRegex);
  final regExpId = RegExp(r"\d{1,3}");

  CharacterModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    height = map['height'];
    mass = map['mass'];
    hairColor = map['hair_color'];
    skinColor = map['skin_color'];
    eyeColor = map['eye_color'];
    birthYear = map['birth_year'];
    gender = map['gender'];
    homeWorldUrl = map['homeworld'];
    isFavorite = map['isFavorite'] ?? false;
    if (map['species'] != null) {
      speciesUrl = map['species'].cast<String>();
    }
    url = map['url'];
    if (regExpUrl.hasMatch(url)) {
      var firstMatch = regExpId.firstMatch(url);
      id = int.parse(url.substring(firstMatch.start, firstMatch.end));
    } else {
      throw Exception("Does not have an id");
    }
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['height'] = height;
    data['mass'] = mass;
    data['hair_color'] = hairColor;
    data['skin_color'] = skinColor;
    data['eye_color'] = eyeColor;
    data['birth_year'] = birthYear;
    data['gender'] = gender;
    data['homeworld'] = homeWorld;
    data['species'] = species;
    data['url'] = url;
    data['isFavorite'] = isFavorite;
    data['id'] = id;
    data['homeWorldUrl'] = homeWorldUrl;
    data['speciesUrl'] = speciesUrl;
    return data;
  }

  @override
  String toString() {
    return '''CharacterModel(id: $id, name: $name, height: $height, mass: $mass, hairColor: $hairColor, skinColor: $skinColor, eyeColor: $eyeColor, birthYear: $birthYear, gender: $gender, homeWorld: $homeWorld, species: $species, url: $url, isFavorite: $isFavorite, homeWorldUrl: $homeWorldUrl, speciesUrl: $speciesUrl)''';
  }
}

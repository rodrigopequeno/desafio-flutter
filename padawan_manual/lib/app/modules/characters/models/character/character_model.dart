import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/utils/constants.dart';

part 'character_model.g.dart';
part 'character_model_adapter.dart';

class CharacterModel = _CharacterModelBase with _$CharacterModel;

abstract class _CharacterModelBase with Store {
  int id;
  String name;
  String height;
  String mass;
  String hairColor;
  String skinColor;
  String eyeColor;
  String birthYear;
  String gender;
  String homeWorld;
  List<String> species = <String>[];
  String url;
  String homeWorldUrl;
  List<String> speciesUrl;
  @observable
  bool isFavorite = false;

  _CharacterModelBase({
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
    this.isFavorite = false,
    this.homeWorldUrl,
    this.speciesUrl,
  });

  final regExpUrl = RegExp(kStandardUrlRegex);
  final regExpId = RegExp(r"\d{1,3}");

  // ignore: unused_element
  _CharacterModelBase.fromMap(Map<String, dynamic> map) {
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

  @action
  void setFavorite() {
    isFavorite = !isFavorite;
  }

  @override
  String toString() {
    return '''CharacterModel(id: $id, name: $name, height: $height, mass: $mass, hairColor: $hairColor, skinColor: $skinColor, eyeColor: $eyeColor, birthYear: $birthYear, gender: $gender, homeWorld: $homeWorld, species: $species, url: $url, isFavorite: $isFavorite, homeWorldUrl: $homeWorldUrl, speciesUrl: $speciesUrl)''';
  }
}

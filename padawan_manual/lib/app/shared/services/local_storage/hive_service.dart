import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../modules/characters/models/character/character_model.dart';

import 'interfaces/local_storage_service_interface.dart';

part 'hive_service.g.dart';

@Injectable()
class HiveService implements ILocalStorageService {
  static final HiveService _singleton = HiveService._internal();

  factory HiveService() {
    return _singleton;
  }

  HiveService._internal();

  @override
  void dispose() {}

  static bool _first = true;

  static const _boxCharacters = 'characters';
  static const _boxFavorites = 'favorites';
  static const _keyErrorSavingFavorites = 'errorSavingFavorites';

  static Future<void> initialize() async {
    if (_first) {
      await Hive.initFlutter();
      Hive.registerAdapter<CharacterModel>(CharacterModelAdapter());
      await Hive.openBox(_boxCharacters);
      await Hive.openBox(_boxFavorites);
      _first = false;
    }
  }

  @override
  void clearLocalData() {
    var box1 = Hive.box(_boxCharacters);
    var box2 = Hive.box(_boxFavorites);
    box1.clear();
    box2.clear();
  }

  @override
  List<CharacterModel> get characters {
    var box = Hive.box(_boxCharacters);
    var data = box.get(_boxCharacters, defaultValue: <CharacterModel>[]);
    return List<CharacterModel>.from(data);
  }

  @override
  set characters(List characters) {
    var box = Hive.box(_boxCharacters);
    box.put(_boxCharacters, characters);
  }

  @override
  Set<int> get favorites {
    var box = Hive.box(_boxFavorites);
    var data = box.get(_boxFavorites, defaultValue: <int>[]);
    return Set<int>.from(data);
  }

  @override
  set favorites(Set favorites) {
    var convertToList = List<int>.from(favorites);
    var box = Hive.box(_boxFavorites);
    box.put(_boxFavorites, convertToList);
  }

  @override
  Set<int> get errorSavingFavorites {
    var box = Hive.box(_boxFavorites);
    var data = box.get(_keyErrorSavingFavorites, defaultValue: <int>[]);
    return Set<int>.from(data);
  }

  @override
  set errorSavingFavorites(Set favorites) {
    var convertToList = List<int>.from(favorites);
    var box = Hive.box(_boxFavorites);
    box.put(_keyErrorSavingFavorites, convertToList);
  }
}

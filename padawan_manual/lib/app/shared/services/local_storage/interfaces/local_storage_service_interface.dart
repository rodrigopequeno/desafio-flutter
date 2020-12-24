import 'package:flutter_modular/flutter_modular.dart';
import '../../../../modules/characters/models/character/character_model.dart';

abstract class ILocalStorageService implements Disposable {
  Future<void> initialize();
  void clearLocalData();
  List<CharacterModel> get characters;
  set characters(List characters);
  Set<int> get favorites;
  set favorites(Set favorites);
  Set<int> get errorSavingFavorites;
  set errorSavingFavorites(Set favorites);
}

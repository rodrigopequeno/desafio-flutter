import 'package:flutter_modular/flutter_modular.dart';
import '../../../../modules/characters/models/character/character_model.dart';

abstract class ILocalStorageService implements Disposable {
  Future<void> initialize();
  void clearLocalData();
  List<CharacterModel> get characters;
  void setCharacters(List characters);
  Set<int> get favorites;
  void setFavorites(Set favorites);
  Set<int> get errorSavingFavorites;
  void setErrorSavingFavorites(Set favorites);
}

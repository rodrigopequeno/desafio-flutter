import 'package:flutter_modular/flutter_modular.dart';
import '../../../../modules/characters/models/character/character_model.dart';

abstract class ILocalStorageService implements Disposable {
  void clearLocalData();
  List<CharacterModel> get characters;
  set characters(List characters);
  List<int> get favorites;
  set favorites(List favorites);
  List<int> get errorSavingFavorites;
  set errorSavingFavorites(List favorites);
}

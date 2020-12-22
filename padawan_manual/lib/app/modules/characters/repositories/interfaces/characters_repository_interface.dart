import 'package:flutter_modular/flutter_modular.dart';

abstract class ICharactersRepository implements Disposable {
  Future fetchCharacters({int page = 1});
  Future fetchCharacterSpecies(String url);
  Future fetchCharacterHomeWord(String url);
}

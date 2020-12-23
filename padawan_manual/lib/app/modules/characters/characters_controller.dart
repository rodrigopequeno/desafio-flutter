import 'package:diacritic/diacritic.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/services/local_storage/interfaces/local_storage_service_interface.dart';

import 'models/character/character_model.dart';
import 'repositories/interfaces/characters_repository_interface.dart';

part 'characters_controller.g.dart';

// ignore_for_file: use_setters_to_change_properties
@Injectable()
class CharactersController = _CharactersControllerBase
    with _$CharactersController;

abstract class _CharactersControllerBase with Store {
  final ICharactersRepository _repository;
  final ILocalStorageService _localStorage;

  _CharactersControllerBase(this._repository, this._localStorage);

  int count = 0;

  @observable
  ObservableList<CharacterModel> characters;

  @observable
  String search;

  @observable
  int filter = 0;

  @observable
  String errorMessage;

  @observable
  String favoriteMessage;

  @computed
  bool get isReady => characters != null;

  @computed
  bool get isMaximum => !((characters?.length ?? 0) < count);

  int get nextPage {
    if (characters == null) {
      return 1;
    }
    return ((characters.length / 10) + 1).round();
  }

  @computed
  ObservableList<CharacterModel> get charactersFiltered {
    var filtered = characters;
    if (filter == 1) {
      filtered = characters
          .where((element) => element.isFavorite)
          .toList()
          .asObservable();
    } else if (filter == 2) {
      filtered = characters
          .where((element) => !element.isFavorite)
          .toList()
          .asObservable();
    }
    if (search != null && search.isNotEmpty) {
      return filtered
          ?.where((element) => removeDiacritics(element.name.toLowerCase())
              .contains(removeDiacritics(search.toLowerCase())))
          ?.toList()
          ?.asObservable();
    }
    return filtered;
  }

  @action
  void setSearch(String value) {
    search = value;
  }

  @action
  void setFilter(int value) {
    filter = value;
  }

  @action
  void setCharacters(List<CharacterModel> value) {
    characters = value;
    _localStorage.characters = characters.asObservable();
  }

  void setFavorite(CharacterModel character) {
    var favorites = _localStorage.favorites;
    character.setFavorite();
    if (character.isFavorite) {
      favorites.add(character.id);
    } else {
      favorites.remove(character.id);
    }
    _localStorage.favorites = favorites;
  }

  Future<void> getCharactersApi({bool forceNetwork = false}) async {
    try {
      if (!isMaximum || forceNetwork) {
        await _repository
            .fetchCharacters(page: forceNetwork ? 1 : nextPage)
            .then((value) {
          count = value['count'];
          var newCharacters = (value['results'] as List)
              .map((e) => CharacterModel.fromMap(e))
              .toList()
              .asObservable();
          newCharacters
              .map((element) => element.isFavorite =
                  _localStorage.favorites.contains(element.id))
              .toList();
          if (characters != null && !forceNetwork) {
            var filtered = newCharacters
                .where((element) => !characters
                    .map((element) => element.id)
                    .contains(element.id))
                .toList()
                .asObservable();
            characters.addAll(filtered);
            _localStorage.characters = characters;
          } else {
            setCharacters(newCharacters);
          }
        });
        errorMessage = null;
      }
    } on DioError catch (e) {
      characters = _localStorage.characters.asObservable();
      errorMessage =
          e.message.contains("SocketException") && e.message.contains("lookup")
              ? "No connection"
              : "An error occurred, please try again later";

      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      errorMessage = "An error occurred, please try again later";
    }
  }
}

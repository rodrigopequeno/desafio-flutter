import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';

import '../../shared/services/local_storage/interfaces/local_storage_service_interface.dart';
import '../../shared/utils/extensions/string/string.dart';
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

  _CharactersControllerBase(this._repository, this._localStorage) {
    resendRequestFavoriteError();
  }

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
          ?.where((element) => element.name
              .toLowerCase()
              .normalizeDiacritics()
              .contains(search.toLowerCase().normalizeDiacritics()))
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
    _localStorage.setCharacters(characters);
  }

  Future<void> setFavorite(CharacterModel character) async {
    var favorites = _localStorage.favorites;
    var errorSavingFavorites = _localStorage.errorSavingFavorites;
    character.setFavorite();
    if (character.isFavorite) {
      favorites.add(character.id);
      try {
        favoriteMessage = await _repository.saveFavorite(character.id);
      } on DioError catch (e) {
        if (e.response.statusCode == 400) {
          favoriteMessage = e.response.data['error_message'];
        } else {
          favoriteMessage = e.message.contains("SocketException") &&
                  e.message.contains("lookup")
              ? "No connection"
              : "An error occurred, please try again later";
        }
      }
    } else {
      favorites.remove(character.id);
      errorSavingFavorites.remove(character.id);
      _localStorage.setErrorSavingFavorites(errorSavingFavorites);
      favoriteMessage = "${character.name} removed from favorites";
    }
    _localStorage.setFavorites(favorites);

    Fluttertoast.showToast(
      msg: favoriteMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
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
            _localStorage.setCharacters(characters);
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

  Future<void> resendRequestFavoriteError() async {
    var currentErrorFavorites = _localStorage.errorSavingFavorites;
    _localStorage.setErrorSavingFavorites(<int>{});
    for (var indexFavorite in currentErrorFavorites) {
      try {
        await _repository.saveFavorite(indexFavorite);
        // ignore: avoid_catches_without_on_clauses
      } catch (_) {}
    }
  }
}

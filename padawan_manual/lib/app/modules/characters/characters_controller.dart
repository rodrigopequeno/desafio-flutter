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
  String errorMessage;

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
    if (search != null && search.isNotEmpty) {
      return characters
          ?.where((element) => removeDiacritics(element.name.toLowerCase())
              .contains(removeDiacritics(search.toLowerCase())))
          ?.toList()
          ?.asObservable();
    }
    return characters;
  }

  @action
  void setSearch(String value) {
    search = value;
  }

  @action
  void setCharacters(List<CharacterModel> value) {
    characters = value;
    _localStorage.characters = characters.asObservable();
  }

  Future<void> getCharactersApi({bool forceNetwork = false}) async {
    try {
      if (!isMaximum || forceNetwork) {
        await _repository
            .fetchCharacters(page: forceNetwork ? 1 : nextPage)
            .then((value) {
          count = value['count'];
          print(value['next']);
          var newCharacters = (value['results'] as List)
              .map((e) => CharacterModel.fromMap(e))
              .toList()
              .asObservable();
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

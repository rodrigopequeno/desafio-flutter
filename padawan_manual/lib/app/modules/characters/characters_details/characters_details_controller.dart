import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../models/character/character_model.dart';
import '../repositories/characters_repository.dart';

part 'characters_details_controller.g.dart';

@Injectable()
class CharactersDetailsController = _CharactersDetailsControllerBase
    with _$CharactersDetailsController;

abstract class _CharactersDetailsControllerBase with Store {
  final CharactersRepository _repository;

  _CharactersDetailsControllerBase(this._repository);

  @observable
  String errorMessage;

  @observable
  bool loaded = false;

  @action
  Future<void> setDetailsCharacter(CharacterModel characterModel) async {
    try {
      await _repository
          .fetchCharacterHomeWord(characterModel.homeWorldUrl)
          .then((value) => characterModel.homeWorld = value);
      characterModel.species = <String>[];
      for (var speciesUrl in characterModel.speciesUrl) {
        await _repository.fetchCharacterSpecies(speciesUrl).then((value) {
          characterModel.species.add(value);
        });
      }
      errorMessage = null;
      loaded = true;
    } on DioError catch (e) {
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

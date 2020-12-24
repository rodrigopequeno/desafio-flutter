import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/services/api_characters/api_characters_service.dart';
import '../../../shared/services/api_favorites/api_favorites_service.dart';

import 'interfaces/characters_repository_interface.dart';

part 'characters_repository.g.dart';

@Injectable()
class CharactersRepository implements ICharactersRepository {
  final ApiCharactersService clientCharacter;
  final ApiFavoritesService clientFavorites;

  CharactersRepository(this.clientCharacter, this.clientFavorites);

  Future<Map<String, dynamic>> fetchCharacters({int page = 1}) async {
    final response = await clientCharacter.get('/people/?page=$page');
    return response.data;
  }

  @override
  Future fetchCharacterHomeWord(String url) async {
    final response =
        await clientCharacter.get("", options: RequestOptions(baseUrl: "$url"));
    return response.data['name'];
  }

  @override
  Future fetchCharacterSpecies(String url) async {
    final response =
        await clientCharacter.get("", options: RequestOptions(baseUrl: "$url"));
    return response.data['name'];
  }

  @override
  void dispose() {}

  @override
  Future<String> saveFavorite(int id) async {
    final response = await clientFavorites.post("/favorite/$id");
    return response.data['message'];
  }
}

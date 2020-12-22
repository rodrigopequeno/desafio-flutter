import 'package:dio/native_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/characters_repository_interface.dart';

part 'characters_repository.g.dart';

@Injectable()
class CharactersRepository implements ICharactersRepository {
  final DioForNative client;

  CharactersRepository(this.client);

  Future<Map<String, dynamic>> fetchCharacters({int page = 1}) async {
    final response = await client.get('/people/?page=$page');
    return response.data;
  }

  @override
  void dispose() {}
}

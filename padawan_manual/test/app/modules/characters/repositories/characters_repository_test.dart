import 'package:flutter_test/flutter_test.dart';
import 'package:padawan_manual/app/modules/characters/repositories/interfaces/characters_repository_interface.dart';

import '../../../mocks/characters_repository_mock.dart';

void main() {
  ICharactersRepository repository;

  setUp(() {
    repository = CharactersRepositoryMock();
  });

  group('CharactersRepository Test', () {
    test("Creation of the CharactersRepository instance", () {
      expect(repository, isInstanceOf<ICharactersRepository>());
    });

    test('return Character HomeWorld', () async {
      final homeWorld = await repository.fetchCharacterHomeWorld("url");
      expect(homeWorld, "Tatooine");
    });

    test('return Character Species', () async {
      final species = await repository.fetchCharacterSpecies("url");
      expect(species, "Human");
    });

    test('return Map Result with Info Characters', () async {
      final characters = await repository.fetchCharacters();
      expect(characters.runtimeType, Map<String, dynamic>.from({}).runtimeType);
    });

    test('return message after bookmark', () async {
      final message = await repository.saveFavorite(0);
      expect(message, "May the force be with you");
    });
  });
}

import 'package:mockito/mockito.dart';
import 'package:padawan_manual/app/modules/characters/models/character/character_model.dart';
import 'package:padawan_manual/app/modules/characters/repositories/interfaces/characters_repository_interface.dart';

class CharacterRepositoryMock extends Mock implements ICharactersRepository {
  CharacterRepositoryMock() {
    var defaultModel = CharacterModel(
      name: "Luke Skywalker",
      height: "172",
      mass: "77",
      hairColor: "blond",
      skinColor: "fair",
      eyeColor: "blue",
      birthYear: "19BBY",
      gender: "male",
      homeWorldUrl: "https://swapi.dev/api/planets/1/",
      speciesUrl: ["https://swapi.dev/api/species/1/"],
      url: "https://swapi.dev/api/people/1/",
      id: 1,
      isFavorite: true,
    );

    when(fetchCharacterHomeWorld("url")).thenAnswer(
      (_) async => Future.value("Tatooine"),
    );

    when(fetchCharacterSpecies("url")).thenAnswer(
      (_) async => Future.value("Human"),
    );

    when(fetchCharacters()).thenAnswer(
      (_) async => Future.value(
        Future.value([defaultModel]),
      ),
    );
    when(saveFavorite(0)).thenAnswer(
      (_) async => Future.value(
        Future.value("May the force be with you"),
      ),
    );
  }
}

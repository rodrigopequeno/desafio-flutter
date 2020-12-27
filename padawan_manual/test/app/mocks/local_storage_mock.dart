import 'package:mockito/mockito.dart';
import 'package:padawan_manual/app/modules/characters/models/character/character_model.dart';
import 'package:padawan_manual/app/shared/services/local_storage/interfaces/local_storage_service_interface.dart';

class LocalStorageServiceMock extends Mock implements ILocalStorageService {
  LocalStorageServiceMock() {
    when(characters).thenReturn(
      <CharacterModel>[
        CharacterModel(
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
        )
      ],
    );
    when(favorites).thenReturn(<int>{0});
    when(errorSavingFavorites).thenReturn(<int>{0});
    when(initialize()).thenAnswer((_) async => null);
    when(clearLocalData()).thenAnswer((_) => null);
  }
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:padawan_manual/app/app_controller.dart';
import 'package:padawan_manual/app/app_module.dart';
import 'package:padawan_manual/app/modules/characters/characters_controller.dart';
import 'package:padawan_manual/app/modules/characters/characters_details/characters_details_controller.dart';

import 'package:padawan_manual/app/modules/characters/characters_module.dart';
import 'package:padawan_manual/app/modules/characters/models/character/character_model.dart';
import 'package:padawan_manual/app/modules/characters/repositories/interfaces/characters_repository_interface.dart';
import 'package:padawan_manual/app/shared/services/api_characters/api_characters_service.dart';
import 'package:padawan_manual/app/shared/services/api_favorites/api_favorites_service.dart';
import 'package:padawan_manual/app/shared/services/api_favorites/interceptors/api_favorites_interceptor.dart';
import 'package:padawan_manual/app/shared/services/local_storage/interfaces/local_storage_service_interface.dart';

import '../../../app_controller_test.dart';
import '../../../mocks/api_characters_service_mock.dart';
import '../../../mocks/api_favorites_interceptor_mock.dart';
import '../../../mocks/api_favorites_service_mock.dart';
import '../../../mocks/characters_repository_mock.dart';
import '../../../mocks/local_storage_mock.dart';

void main() {
  initModules([
    AppModule(),
    CharactersModule()
  ], changeBinds: [
    Bind<ILocalStorageService>((i) => LocalStorageServiceMock()),
    Bind<CharacterModelAdapter>((i) => CharacterModelAdapterMock()),
    Bind<ICharactersRepository>((i) => CharactersRepositoryMock()),
    Bind<ApiCharactersService>((i) => ApiCharactersServiceMock()),
    Bind<ApiFavoritesInterceptor>((i) => ApiFavoritesInterceptorMock()),
    Bind<ApiFavoritesService>((i) => ApiFavoritesServiceMock()),
    Bind((i) => CharactersDetailsController(i.get(), i.get())),
    Bind((i) => CharactersController(i.get(), i.get())),
  ]);

  CharactersDetailsController charactersDetails;
  CharacterModel characterModel;

  setUp(() async {
    await AppModule.to.get<AppController>().setupLocalStorage();
    charactersDetails = CharactersModule.to.get<CharactersDetailsController>();
    characterModel = CharacterModel(
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
      id: 0,
    );
  });

  group('CharactersDetailsController Test', () {
    test("Creation of the CharactersDetailsController instance", () {
      expect(charactersDetails, isInstanceOf<CharactersDetailsController>());
    });

    test(
        """Search for the name of the home planet and the species of the character.""",
        () async {
      expect(characterModel.homeWorld, null);
      expect(characterModel.species, null);
      await charactersDetails.setDetailsCharacter(characterModel);
      expect(characterModel.homeWorld, isNotNull);
      expect(characterModel.species, isNotNull);
    });
  });
}

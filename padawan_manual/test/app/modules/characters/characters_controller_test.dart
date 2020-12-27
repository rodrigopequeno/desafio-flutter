import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:padawan_manual/app/app_module.dart';
import 'package:padawan_manual/app/modules/characters/characters_controller.dart';
import 'package:padawan_manual/app/modules/characters/characters_module.dart';
import 'package:padawan_manual/app/modules/characters/models/character/character_model.dart';
import 'package:padawan_manual/app/modules/characters/repositories/interfaces/characters_repository_interface.dart';
import 'package:padawan_manual/app/shared/services/api_characters/api_characters_service.dart';
import 'package:padawan_manual/app/shared/services/api_favorites/api_favorites_service.dart';
import 'package:padawan_manual/app/shared/services/api_favorites/interceptors/api_favorites_interceptor.dart';
import 'package:padawan_manual/app/shared/services/local_storage/interfaces/local_storage_service_interface.dart';

import '../../app_controller_test.dart';
import '../../mocks/api_characters_service_mock.dart';
import '../../mocks/api_favorites_interceptor_mock.dart';
import '../../mocks/api_favorites_service_mock.dart';
import '../../mocks/characters_repository_mock.dart';
import '../../mocks/local_storage_mock.dart';

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
    Bind((i) => CharactersController(i.get(), i.get())),
  ]);

  CharactersController charactersController;
  ILocalStorageService localStorageService;

  setUp(() {
    charactersController = CharactersModule.to.get<CharactersController>();
    localStorageService = AppModule.to.get<ILocalStorageService>();
  });

  group('CharactersController Test', () {
    test("Creation of the CharactersController instance", () {
      expect(charactersController, isInstanceOf<CharactersController>());
    });

    test("""Search characters in the api""", () async {
      expect(charactersController.characters, null);
      await charactersController.getCharactersApi(forceNetwork: true);
      expect(charactersController.characters, isNotNull);
      expect(charactersController.characters.length, 2);
    });

    test("""Search for the character by name.""", () async {
      final search = "Luke";
      await charactersController.getCharactersApi(forceNetwork: true);
      await charactersController.setSearch(search);
      expect(charactersController.charactersFiltered.length, 1);
      expect(
          charactersController.charactersFiltered.first.name.contains(search),
          true);
    });

    test("""Data must be saved in a local database.""", () async {
      await charactersController.getCharactersApi(forceNetwork: true);
      verify(localStorageService.setCharacters(any)).called(greaterThan(0));
    });
  });
}

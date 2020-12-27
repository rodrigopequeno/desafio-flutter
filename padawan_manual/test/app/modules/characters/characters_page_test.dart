import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:padawan_manual/app/app_controller.dart';
import 'package:padawan_manual/app/app_module.dart';
import 'package:padawan_manual/app/modules/characters/characters_controller.dart';
import 'package:padawan_manual/app/modules/characters/characters_module.dart';
import 'package:padawan_manual/app/modules/characters/characters_page.dart';
import 'package:padawan_manual/app/modules/characters/models/character/character_model.dart';
import 'package:padawan_manual/app/modules/characters/repositories/interfaces/characters_repository_interface.dart';
import 'package:padawan_manual/app/modules/characters/widgets/character/character_widget.dart';
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

  setUp(() async {
    await AppModule.to.get<AppController>().setupLocalStorage();
    charactersController = CharactersModule.to.get<CharactersController>();
  });

  group("CharactersPage Test", () {
    test("Creation of the CharactersController instance", () {
      expect(charactersController, isInstanceOf<CharactersController>());
    });

    testWidgets("Has scroll infinite", (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          CharactersPage(),
        ),
      );
      await tester.pump();
      var finder = find.byType(ListView);
      expect(finder, findsOneWidget);
    });

    testWidgets("Has character widgets", (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          CharactersPage(),
        ),
      );
      await tester.pump();
      expect(charactersController.characters.length, isNotNull);
      var characterWidgets = tester.widgetList(find.byType(CharacterWidget));
      expect(characterWidgets.length, charactersController.characters.length);
    });
  });
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:padawan_manual/app/app_controller.dart';

import 'package:padawan_manual/app/app_module.dart';
import 'package:padawan_manual/app/modules/characters/models/character/character_model.dart';
import 'package:padawan_manual/app/shared/services/local_storage/interfaces/local_storage_service_interface.dart';

class LocalStorageServiceMock extends Mock implements ILocalStorageService {}

// ignore: must_be_immutable
class CharacterModelAdapterMock extends Mock implements CharacterModelAdapter {}

void main() {
  initModule(AppModule(), changeBinds: [
    Bind((i) => LocalStorageServiceMock()),
    Bind((i) => CharacterModelAdapterMock()),
  ]);

  AppController app;

  setUp(() {
    app = AppModule.to.get<AppController>();
  });

  group('AppController Test', () {
    test("Creation of the AppController instance", () {
      expect(app, isInstanceOf<AppController>());
    });

    test("Local storage initialization", () async {
      await app.setupLocalStorage();
      expect(app.isReady, true);
    });
  });
}

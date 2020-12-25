import 'package:flutter_test/flutter_test.dart';
import 'package:padawan_manual/app/shared/services/local_storage/hive_service.dart';
import 'package:padawan_manual/app/shared/services/local_storage/interfaces/local_storage_service_interface.dart';

import '../../../app_controller_test.dart';

void main() {
  ILocalStorageService service;

  setUp(() {
    service = HiveService(CharacterModelAdapterMock());
  });
//
  group('HiveService Test', () {
    test("Creation of the HiveService instance", () {
      expect(service, isInstanceOf<HiveService>());
    });
  });
}

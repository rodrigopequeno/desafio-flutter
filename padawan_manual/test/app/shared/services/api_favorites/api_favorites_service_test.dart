import 'package:flutter_test/flutter_test.dart';
import 'package:padawan_manual/app/shared/services/api_favorites/api_favorites_service.dart';

import '../../../mocks/api_favorites_interceptor_mock.dart';

void main() {
  ApiFavoritesService service;

  setUp(() {
    service = ApiFavoritesService(ApiFavoritesInterceptorMock());
  });

  group('ApiFavoritesService Test', () {
    test("Creation of the ApiFavoritesService instance", () {
      expect(service, isInstanceOf<ApiFavoritesService>());
    });
  });
}

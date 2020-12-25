import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:padawan_manual/app/shared/services/api_favorites/api_favorites_service.dart';
import 'package:padawan_manual/app/shared/services/api_favorites/interceptors/api_favorites_interceptor.dart';

class ApiFavoritesInterceptorMock extends Mock
    implements ApiFavoritesInterceptor {}

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

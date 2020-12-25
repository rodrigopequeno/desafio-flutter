import 'package:flutter_test/flutter_test.dart';
import 'package:padawan_manual/app/shared/services/api_characters/api_characters_service.dart';

void main() {
  ApiCharactersService service;

  setUp(() {
    service = ApiCharactersService();
  });
  group('ApiCharactersService Test', () {
    test("Creation of the ApiCharactersService instance", () {
      expect(service, isInstanceOf<ApiCharactersService>());
    });
  });
}

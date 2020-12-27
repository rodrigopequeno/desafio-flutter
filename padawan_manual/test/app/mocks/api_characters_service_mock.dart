import 'package:mockito/mockito.dart';
import 'package:padawan_manual/app/shared/services/api_characters/api_characters_service.dart';

import 'api_favorites_interceptor_mock.dart';

class ApiCharactersServiceMock extends Mock implements ApiCharactersService {
  ApiCharactersServiceMock() {
    when(get(any)).thenAnswer((_) async => ResponseMock());
  }
}

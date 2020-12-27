import 'package:mockito/mockito.dart';
import 'package:padawan_manual/app/shared/services/api_favorites/api_favorites_service.dart';

import 'api_favorites_interceptor_mock.dart';

class ApiFavoritesServiceMock extends Mock implements ApiFavoritesService {
  ApiFavoritesServiceMock() {
    var _response = ResponseMock();
    _response.statusCode = 200;
    _response.data = {'message': "testando"};
    when(post(any)).thenAnswer((_) async => _response);
  }
}

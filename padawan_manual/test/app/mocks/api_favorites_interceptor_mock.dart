import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:padawan_manual/app/shared/services/api_favorites/interceptors/api_favorites_interceptor.dart';

class ResponseMock extends Mock implements Response {}

class DioErrorMock extends Mock implements DioError {}

class ApiFavoritesInterceptorMock extends Mock
    implements ApiFavoritesInterceptor {
  ApiFavoritesInterceptorMock() {
    when(onError(any)).thenAnswer((realInvocation) async {
      var _response = ResponseMock();
      var _dioError = DioErrorMock();
      _response.statusCode = 400;
      _response.data = {"error_message": "error message"};
      _dioError.response = _response;
      return DioError(response: _response, error: _dioError);
    });
    when(onRequest(any)).thenAnswer((realInvocation) => Future.value());
    when(onResponse(any)).thenAnswer((realInvocation) => Future.value());
  }
}

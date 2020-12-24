import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'interceptors/api_favorites_interceptor.dart';

part 'api_favorites_service.g.dart';

@Injectable()
class ApiFavoritesService extends DioForNative {
  static const kApiUrl =
      "http://private-782d3-starwarsfavorites.apiary-mock.com";
  final ApiFavoritesInterceptor _apiFavoritesInterceptor;
  ApiFavoritesService(this._apiFavoritesInterceptor)
      : super(BaseOptions(
          baseUrl: kApiUrl,
          connectTimeout: 5000,
          receiveTimeout: 5000,
        )) {
    interceptors.add(_apiFavoritesInterceptor);
  }
}

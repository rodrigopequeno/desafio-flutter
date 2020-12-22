import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'api_characters_service.g.dart';

@Injectable()
class ApiCharactersService extends DioForNative {
  static const kApiUrl = "https://swapi.dev/api";
  ApiCharactersService()
      : super(
          BaseOptions(
            baseUrl: kApiUrl,
            connectTimeout: 5000,
            receiveTimeout: 5000,
          ),
        );
}

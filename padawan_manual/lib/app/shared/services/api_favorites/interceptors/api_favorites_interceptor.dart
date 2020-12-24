import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../local_storage/interfaces/local_storage_service_interface.dart';

part 'api_favorites_interceptor.g.dart';

@Injectable()
class ApiFavoritesInterceptor extends Interceptor {
  final regExpId = RegExp(r"\d{1,3}");
  final ILocalStorageService _localStorage;

  ApiFavoritesInterceptor(this._localStorage);

  @override
  Future onError(DioError err) async {
    if (err.response.statusCode == 400) {
      var errorList = _localStorage.errorSavingFavorites;
      var data = regExpId.stringMatch(err.request.path);
      var index = int.tryParse(data);
      errorList.add(index);
      _localStorage.errorSavingFavorites = errorList;
    }
    return err;
  }

  @override
  Future onRequest(RequestOptions options) async {
    var random = Random().nextBool();
    if (random) {
      options.headers = {"Prefer": "status=400"};
    }
    return options;
  }
}

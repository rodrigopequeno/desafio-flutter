import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../local_storage/interfaces/local_storage_service_interface.dart';

class ApiFavoritesInterceptor extends Interceptor {
  final regExpId = RegExp(r"\d{1,3}");

  @override
  Future onError(DioError err) async {
    var _localStorage = Modular.get<ILocalStorageService>();
    if (err.response.statusCode == 400) {
      var errorList = _localStorage.errorSavingFavorites;
      var data = regExpId.stringMatch(err.request.path);
      var index = int.tryParse(data);
      if (!errorList.contains(index)) {
        errorList.add(index);
      }
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

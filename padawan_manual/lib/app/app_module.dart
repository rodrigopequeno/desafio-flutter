import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/characters/characters_module.dart';
import 'shared/pages/splash_screen/splash_screen_controller.dart';
import 'shared/pages/splash_screen/splash_screen_page.dart';
import 'shared/services/api_characters/api_characters_service.dart';
import 'shared/services/api_favorites/api_favorites_service.dart';
import 'shared/services/api_favorites/interceptors/api_favorites_interceptor.dart';
import 'shared/services/local_storage/hive_service.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $ApiFavoritesService,
        $ApiFavoritesInterceptor,
        $HiveService,
        $ApiCharactersService,
        $SplashScreenController,
        $AppController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => SplashScreenPage(),
        ),
        ModularRouter('/character', module: CharactersModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}

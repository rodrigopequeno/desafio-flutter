import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/home/home_module.dart';
import 'shared/pages/splash_screen/splash_screen_controller.dart';
import 'shared/pages/splash_screen/splash_screen_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $SplashScreenController,
        $AppController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => SplashScreenPage(),
        ),
        ModularRouter('/home', module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}

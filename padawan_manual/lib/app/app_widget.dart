import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_controller.dart';

import 'shared/themes/theme_dark.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends ModularState<AppWidget, AppController> {
  @override
  void initState() {
    controller.setupLocalStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'PADAWAN MANUAL',
      theme: ThemeDark.themeData,
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}

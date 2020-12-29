import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../widgets/background/background_widget.dart';

import 'splash_screen_controller.dart';

/// Classe responsável pela construção da tela SplashScreen.
class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState
    extends ModularState<SplashScreenPage, SplashScreenController> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      opacity: 0.7,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Center(
            child: SizedBox(
              height: 200,
              width: 300,
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

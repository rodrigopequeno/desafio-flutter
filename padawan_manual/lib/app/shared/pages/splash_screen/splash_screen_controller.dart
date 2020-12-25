import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../app_controller.dart';

part 'splash_screen_controller.g.dart';

/// Classe responsável por realizar o controle do splash screen.
/// Ela aguarda 3(três) segundos e então verifica se os dados já
/// foram carregados.
@Injectable()
class SplashScreenController = _SplashScreenControllerBase
    with _$SplashScreenController;

abstract class _SplashScreenControllerBase extends Disposable with Store {
  final AppController _appController;

  @observable
  bool _timer = false;

  @observable
  bool _timerOverflow = false;

  Timer timer;
  Timer timerOverflow;

  _SplashScreenControllerBase(this._appController) {
    setupTimer();
    setupTimerOverflow();
    setupReactions();
  }

  void setupTimer() async {
    timer = Timer(Duration(seconds: 3), () => _timer = true);
  }

  void setupTimerOverflow() async {
    timerOverflow = Timer(Duration(seconds: 6), () => _timerOverflow = true);
  }

  void setupReactions() async {
    when((_) => (_appController.isReady && _timer || _timerOverflow), () {
      Modular.to.pushReplacementNamed('/character');
    });
  }

  @override
  void dispose() {
    timer.cancel();
    timerOverflow.cancel();
  }
}

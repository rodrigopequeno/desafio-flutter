import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'splash_screen_controller.g.dart';

/// Classe responsável por realizar o controle do splash screen.
/// Ela aguarda 3(três) segundos e então verifica se os dados já
/// foram carregados.
@Injectable()
class SplashScreenController = _SplashScreenControllerBase
    with _$SplashScreenController;

abstract class _SplashScreenControllerBase with Store {
  @observable
  bool _timer = false;

  @observable
  bool _timerOverflow = false;

  _SplashScreenControllerBase() {
    setupTimer();
    setupTimerOverflow();
    setupReactions();
  }

  void setupTimer() async {
    Timer(Duration(seconds: 3), () => _timer = true);
  }

  void setupTimerOverflow() async {
    Timer(Duration(seconds: 6), () => _timerOverflow = true);
  }

  void setupReactions() async {
    //* TODO: VERIFICAR SE OS DADOS FORAM CARREGADOS
    when((_) => (_timer || _timerOverflow), () {
      Modular.to.pushReplacementNamed('/home');
    });
  }
}

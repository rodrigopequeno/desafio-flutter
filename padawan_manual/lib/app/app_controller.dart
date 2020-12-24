import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'shared/services/local_storage/hive_service.dart';

part 'app_controller.g.dart';

@Injectable()
class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  bool _initializedLocalStorage = false;

  _AppControllerBase() {
    setupLocalStorage();
  }

  @computed
  bool get isReady => _initializedLocalStorage;

  void setupLocalStorage() async {
    await HiveService.initialize();
    _initializedLocalStorage = true;
  }
}

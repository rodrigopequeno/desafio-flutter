import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'shared/services/local_storage/interfaces/local_storage_service_interface.dart';

part 'app_controller.g.dart';

@Injectable()
class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final ILocalStorageService _localStorageService;
  @observable
  bool _initializedLocalStorage = false;

  _AppControllerBase(this._localStorageService);

  @computed
  bool get isReady => _initializedLocalStorage;

  Future<void> setupLocalStorage() async {
    await _localStorageService.initialize();
    _initializedLocalStorage = true;
  }
}

import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/services/api_characters/api_characters_service.dart';
import '../../shared/services/api_favorites/api_favorites_service.dart';
import '../../shared/services/api_favorites/interceptors/api_favorites_interceptor.dart';
import 'characters_controller.dart';
import 'characters_details/characters_details_controller.dart';
import 'characters_details/characters_details_page.dart';
import 'characters_page.dart';
import 'repositories/characters_repository.dart';
import 'repositories/interfaces/characters_repository_interface.dart';

class CharactersModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $CharactersDetailsController,
        Bind<ICharactersRepository>(
            (i) => CharactersRepository(i.get(), i.get())),
        $CharactersController,
        $ApiFavoritesService,
        $ApiCharactersService,
        $ApiFavoritesInterceptor,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => CharactersPage()),
        ModularRouter('/details',
            child: (_, args) => CharactersDetailsPage(
                  character: args.data,
                ),
            transition: TransitionType.rightToLeft),
      ];

  static Inject get to => Inject<CharactersModule>.of();
}

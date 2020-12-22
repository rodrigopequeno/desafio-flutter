import 'package:flutter_modular/flutter_modular.dart';

import 'characters_controller.dart';
import 'characters_details/characters_details_controller.dart';
import 'characters_details/characters_details_page.dart';
import 'characters_page.dart';
import 'repositories/characters_repository.dart';

class CharactersModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $CharactersDetailsController,
        $CharactersRepository,
        $CharactersController,
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

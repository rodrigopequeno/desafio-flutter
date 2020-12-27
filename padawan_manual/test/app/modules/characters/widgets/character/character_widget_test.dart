import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:padawan_manual/app/modules/characters/characters_controller.dart';
import 'package:padawan_manual/app/modules/characters/models/character/character_model.dart';

import 'package:padawan_manual/app/modules/characters/widgets/character/character_widget.dart';
import 'package:padawan_manual/app/shared/utils/extensions/string.dart';

import '../../../../mocks/characters_repository_mock.dart';
import '../../../../mocks/local_storage_mock.dart';

void main() {
  CharacterModel characterModel;
  CharactersController charactersController;

  setUp(() async {
    charactersController = CharactersController(
        CharactersRepositoryMock(), LocalStorageServiceMock());
    characterModel = CharacterModel(
        name: "Luke Skywalker",
        height: "172",
        mass: "77",
        hairColor: "blond",
        skinColor: "fair",
        eyeColor: "blue",
        birthYear: "19BBY",
        gender: "male",
        homeWorldUrl: "https://swapi.dev/api/planets/1/",
        speciesUrl: ["https://swapi.dev/api/species/1/"],
        url: "https://swapi.dev/api/people/1/",
        id: 1);
  });

  group("CharacterWidget Test", () {
    testWidgets('Show all character information', (tester) async {
      bool _checkTestPresentInCurrent(List<String> current, String test) {
        for (var present in current) {
          if (present.contains(test)) {
            return true;
          }
        }
        return false;
      }

      var requirements = [
        "${characterModel.name}",
        "${characterModel.height.toFirstLetterUpperCase()}",
        "${characterModel.mass.toFirstLetterUpperCase()}",
        "${characterModel.gender.toFirstLetterUpperCase()}",
      ].map((e) => e.toLowerCase()).toList();
      await tester.pumpWidget(buildTestableWidget(Material(
        child: CharacterWidget(
          characterModel: characterModel,
        ),
      )));
      var textWidgets = tester.widgetList<Text>(find.byType(Text));

      var current = textWidgets.map((e) => e.data.toLowerCase()).toList();
      for (var requirement in requirements) {
        expect(_checkTestPresentInCurrent(current, requirement), true);
      }
    });

    testWidgets('Has button favorite', (tester) async {
      await tester.pumpWidget(buildTestableWidget(Material(
        child: CharacterWidget(
          characterModel: characterModel,
          onFavorite: () async {
            await charactersController.setFavorite(characterModel);
          },
        ),
      )));

      var iconButtonFavoriteFinder = find.byType(IconButton);

      expect(characterModel.isFavorite, false);
      await tester.tap(iconButtonFavoriteFinder);
      expect(characterModel.isFavorite, true);
      await tester.tap(iconButtonFavoriteFinder);
      expect(characterModel.isFavorite, false);
    });
  });
}

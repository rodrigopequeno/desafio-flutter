import 'package:mockito/mockito.dart';
import 'package:padawan_manual/app/modules/characters/repositories/interfaces/characters_repository_interface.dart';

class CharactersRepositoryMock extends Mock implements ICharactersRepository {
  CharactersRepositoryMock() {
    var defaultMap1 = <String, dynamic>{
      "name": "Luke Skywalker",
      "height": "172",
      "mass": "77",
      "hair_color": "blond",
      "skin_color": "fair",
      "eye_color": "blue",
      "birth_year": "19BBY",
      "gender": "male",
      "homeworld": "http://swapi.dev/api/planets/1/",
      "films": [
        "http://swapi.dev/api/films/1/",
        "http://swapi.dev/api/films/2/",
        "http://swapi.dev/api/films/3/",
        "http://swapi.dev/api/films/6/"
      ],
      "species": [],
      "vehicles": [
        "http://swapi.dev/api/vehicles/14/",
        "http://swapi.dev/api/vehicles/30/"
      ],
      "starships": [
        "http://swapi.dev/api/starships/12/",
        "http://swapi.dev/api/starships/22/"
      ],
      "created": "2014-12-09T13:50:51.644000Z",
      "edited": "2014-12-20T21:17:56.891000Z",
      "url": "http://swapi.dev/api/people/1/"
    };

    var defaultMap2 = <String, dynamic>{
      "name": "C-3PO",
      "height": "167",
      "mass": "75",
      "hair_color": "n/a",
      "skin_color": "gold",
      "eye_color": "yellow",
      "birth_year": "112BBY",
      "gender": "n/a",
      "homeworld": "http://swapi.dev/api/planets/1/",
      "films": [
        "http://swapi.dev/api/films/1/",
        "http://swapi.dev/api/films/2/",
        "http://swapi.dev/api/films/3/",
        "http://swapi.dev/api/films/4/",
        "http://swapi.dev/api/films/5/",
        "http://swapi.dev/api/films/6/"
      ],
      "species": ["http://swapi.dev/api/species/2/"],
      "vehicles": [],
      "starships": [],
      "created": "2014-12-10T15:10:51.357000Z",
      "edited": "2014-12-20T21:17:50.309000Z",
      "url": "http://swapi.dev/api/people/2/"
    };

    var firstPage = <String, dynamic>{
      "count": 4,
      "next": "http://swapi.dev/api/people/?page=2",
      "previous": null,
      "results": [defaultMap1, defaultMap2]
    };

    var secondPage = <String, dynamic>{
      "count": 4,
      "next": null,
      "previous": "http://swapi.dev/api/people/?page=1",
      "results": [defaultMap1, defaultMap2]
    };

    when(fetchCharacterHomeWorld(any)).thenAnswer(
      (_) async => Future.value("Tatooine"),
    );

    when(fetchCharacterSpecies(any)).thenAnswer(
      (_) async => Future.value("Human"),
    );

    when(fetchCharacters(page: captureAnyNamed("page"))).thenAnswer(
      (invocation) async => Future.value(
          invocation.namedArguments["page"] == 2 ? secondPage : firstPage),
    );
    when(saveFavorite(any)).thenAnswer(
      (_) async => Future<String>.value("May the force be with you"),
    );
  }
}

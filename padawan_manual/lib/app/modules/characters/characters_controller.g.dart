// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $CharactersController = BindInject(
  (i) => CharactersController(
      i<ICharactersRepository>(), i<ILocalStorageService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CharactersController on _CharactersControllerBase, Store {
  Computed<bool> _$isReadyComputed;

  @override
  bool get isReady => (_$isReadyComputed ??= Computed<bool>(() => super.isReady,
          name: '_CharactersControllerBase.isReady'))
      .value;
  Computed<bool> _$isMaximumComputed;

  @override
  bool get isMaximum =>
      (_$isMaximumComputed ??= Computed<bool>(() => super.isMaximum,
              name: '_CharactersControllerBase.isMaximum'))
          .value;
  Computed<ObservableList<CharacterModel>> _$charactersFilteredComputed;

  @override
  ObservableList<CharacterModel> get charactersFiltered =>
      (_$charactersFilteredComputed ??=
              Computed<ObservableList<CharacterModel>>(
                  () => super.charactersFiltered,
                  name: '_CharactersControllerBase.charactersFiltered'))
          .value;

  final _$charactersAtom = Atom(name: '_CharactersControllerBase.characters');

  @override
  ObservableList<CharacterModel> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(ObservableList<CharacterModel> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  final _$searchAtom = Atom(name: '_CharactersControllerBase.search');

  @override
  String get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  final _$filterAtom = Atom(name: '_CharactersControllerBase.filter');

  @override
  int get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(int value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_CharactersControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$_CharactersControllerBaseActionController =
      ActionController(name: '_CharactersControllerBase');

  @override
  void setSearch(String value) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setSearch');
    try {
      return super.setSearch(value);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(int value) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCharacters(List<CharacterModel> value) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setCharacters');
    try {
      return super.setCharacters(value);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
characters: ${characters},
search: ${search},
filter: ${filter},
errorMessage: ${errorMessage},
isReady: ${isReady},
isMaximum: ${isMaximum},
charactersFiltered: ${charactersFiltered}
    ''';
  }
}

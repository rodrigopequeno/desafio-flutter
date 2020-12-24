// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_details_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $CharactersDetailsController = BindInject(
  (i) => CharactersDetailsController(
      i<CharactersRepository>(), i<CharactersController>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CharactersDetailsController on _CharactersDetailsControllerBase, Store {
  final _$errorMessageAtom =
      Atom(name: '_CharactersDetailsControllerBase.errorMessage');

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

  final _$loadedAtom = Atom(name: '_CharactersDetailsControllerBase.loaded');

  @override
  bool get loaded {
    _$loadedAtom.reportRead();
    return super.loaded;
  }

  @override
  set loaded(bool value) {
    _$loadedAtom.reportWrite(value, super.loaded, () {
      super.loaded = value;
    });
  }

  final _$setDetailsCharacterAsyncAction =
      AsyncAction('_CharactersDetailsControllerBase.setDetailsCharacter');

  @override
  Future<void> setDetailsCharacter(CharacterModel characterModel) {
    return _$setDetailsCharacterAsyncAction
        .run(() => super.setDetailsCharacter(characterModel));
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
loaded: ${loaded}
    ''';
  }
}

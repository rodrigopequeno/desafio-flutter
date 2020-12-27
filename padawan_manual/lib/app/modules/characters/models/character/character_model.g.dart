// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CharacterModel on _CharacterModelBase, Store {
  final _$isFavoriteAtom = Atom(name: '_CharacterModelBase.isFavorite');

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportRead();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.reportWrite(value, super.isFavorite, () {
      super.isFavorite = value;
    });
  }

  final _$_CharacterModelBaseActionController =
      ActionController(name: '_CharacterModelBase');

  @override
  void setFavorite() {
    final _$actionInfo = _$_CharacterModelBaseActionController.startAction(
        name: '_CharacterModelBase.setFavorite');
    try {
      return super.setFavorite();
    } finally {
      _$_CharacterModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFavorite: ${isFavorite}
    ''';
  }
}

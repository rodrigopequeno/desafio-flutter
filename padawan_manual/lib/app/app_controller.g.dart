// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $AppController = BindInject(
  (i) => AppController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppControllerBase, Store {
  Computed<bool> _$isReadyComputed;

  @override
  bool get isReady => (_$isReadyComputed ??= Computed<bool>(() => super.isReady,
          name: '_AppControllerBase.isReady'))
      .value;

  final _$_initializedLocalStorageAtom =
      Atom(name: '_AppControllerBase._initializedLocalStorage');

  @override
  bool get _initializedLocalStorage {
    _$_initializedLocalStorageAtom.reportRead();
    return super._initializedLocalStorage;
  }

  @override
  set _initializedLocalStorage(bool value) {
    _$_initializedLocalStorageAtom
        .reportWrite(value, super._initializedLocalStorage, () {
      super._initializedLocalStorage = value;
    });
  }

  @override
  String toString() {
    return '''
isReady: ${isReady}
    ''';
  }
}

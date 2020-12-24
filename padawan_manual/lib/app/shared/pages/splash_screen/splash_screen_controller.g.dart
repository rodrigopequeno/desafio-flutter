// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_screen_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $SplashScreenController = BindInject(
  (i) => SplashScreenController(i<AppController>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SplashScreenController on _SplashScreenControllerBase, Store {
  final _$_timerAtom = Atom(name: '_SplashScreenControllerBase._timer');

  @override
  bool get _timer {
    _$_timerAtom.reportRead();
    return super._timer;
  }

  @override
  set _timer(bool value) {
    _$_timerAtom.reportWrite(value, super._timer, () {
      super._timer = value;
    });
  }

  final _$_timerOverflowAtom =
      Atom(name: '_SplashScreenControllerBase._timerOverflow');

  @override
  bool get _timerOverflow {
    _$_timerOverflowAtom.reportRead();
    return super._timerOverflow;
  }

  @override
  set _timerOverflow(bool value) {
    _$_timerOverflowAtom.reportWrite(value, super._timerOverflow, () {
      super._timerOverflow = value;
    });
  }

  @override
  String toString() {
    return '''

    ''';
  }
}

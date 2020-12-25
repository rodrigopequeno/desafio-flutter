import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:padawan_manual/app/shared/widgets/button/button_widget.dart';

void main() {
  group("ButtonWidget Test", () {
    testWidgets('Has button with text', (tester) async {
      final textButton = "ButtonWidget";

      await tester.pumpWidget(buildTestableWidget(ButtonWidget(
        text: textButton,
      )));

      final buttonFinder = find.widgetWithText(FlatButton, textButton);
      expect(buttonFinder, findsOneWidget);
    });
  });
}

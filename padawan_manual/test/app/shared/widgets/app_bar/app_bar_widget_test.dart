import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:padawan_manual/app/shared/widgets/app_bar/app_bar_widget.dart';

void main() {
  group("AppBarWidget Test", () {
    testWidgets('Has logo image', (tester) async {
      await tester.pumpWidget(buildTestableWidget(AppBarWidget()));
      final appBarFinder = find.byType(Image);
      expect(appBarFinder, findsOneWidget);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:padawan_manual/app/shared/widgets/app_bar/app_bar_widget.dart';

void main() {
  group("AppBarWidget Test", () {
    testWidgets('Has logo image', (tester) async {
      await tester.pumpWidget(buildTestableWidget(AppBarWidget()));
      final appBarTitleFinder = tester.firstWidget<AppBar>(find.byType(AppBar));
      expect((appBarTitleFinder.title as Image).runtimeType, Image);
      expect(((appBarTitleFinder.title as Image).image as AssetImage).assetName,
          "assets/images/logo.png");
    });

    testWidgets('Has background image', (tester) async {
      await tester.pumpWidget(buildTestableWidget(AppBarWidget()));
      final appBarTitleFinder = tester.firstWidget<AppBar>(find.byType(AppBar));
      expect((appBarTitleFinder.flexibleSpace as Image).runtimeType, Image);
      expect(
          ((appBarTitleFinder.flexibleSpace as Image).image as AssetImage)
              .assetName,
          "assets/images/background.jpg");
    });
  });
}

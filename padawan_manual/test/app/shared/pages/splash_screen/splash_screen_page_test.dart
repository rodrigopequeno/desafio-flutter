import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:padawan_manual/app/app_module.dart';
import 'package:padawan_manual/app/shared/pages/splash_screen/splash_screen_page.dart';

class NavigatorObserverMock extends Mock implements NavigatorObserver {}

void main() {
  initModule(AppModule());

  group("SplashScreenPage Test", () {
    testWidgets('Has background image', (tester) async {
      await tester.pumpWidget(buildTestableWidget(SplashScreenPage()));
      final backgroundFinder =
          tester.firstWidget(find.byType(Container)) as Container;
      final decorationImage =
          (backgroundFinder.decoration as BoxDecoration).image;

      expect(decorationImage.image.runtimeType, AssetImage);
    });
    testWidgets('Has logo image', (tester) async {
      await tester.pumpWidget(buildTestableWidget(SplashScreenPage()));
      final logoImageFinder = find.byType(Image);
      expect(logoImageFinder, findsOneWidget);
    });
  });
}

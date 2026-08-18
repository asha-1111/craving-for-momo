import 'package:flutter_test/flutter_test.dart';
import 'package:craving_for_momo/main.dart';

void main() {
  testWidgets('Craving for Momo website loads successfully',
          (WidgetTester tester) async {
        // Build the Craving for Momo website.
        await tester.pumpWidget(const CravingForMomoApp());

        // Verify that the app has loaded.
        expect(find.byType(CravingForMomoApp), findsOneWidget);
      });
}
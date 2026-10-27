import 'package:flutter_test/flutter_test.dart';
import 'package:haloduniaku/main.dart';

void main() {
  testWidgets('Smoke test profile app loads properly', (WidgetTester tester) async {
    // Build NeoProfileApp
    await tester.pumpWidget(const NeoProfileApp());
    await tester.pumpAndSettle();

    // Verify name and Vibe Coding text are present on OpeningPage
    expect(find.text(kNamaLengkap), findsOneWidget);
    expect(find.text('NIM : $kNim'), findsOneWidget);
  });
}

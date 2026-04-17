import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_hello_world/main.dart';

void main() {
  testWidgets('Samarretes screen renders initial state', (WidgetTester tester) async {
    await tester.pumpWidget(const SamarretesApp());

    expect(find.text('Samarretes Studio'), findsOneWidget);
    expect(find.text('Comanda'), findsOneWidget);
    expect(find.text('Introdueix les dades per veure el preu final.'), findsOneWidget);
  });
}

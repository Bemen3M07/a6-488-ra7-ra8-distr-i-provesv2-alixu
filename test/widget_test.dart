// Importa el paquete de pruebas de Flutter
import 'package:flutter_test/flutter_test.dart';

// Importa la aplicación principal desde el paquete flutter_hello_world
import 'package:flutter_hello_world/main.dart';

// Función principal para ejecutar las pruebas
void main() {
  // Define una prueba de widgets que verifica el estado inicial de la pantalla de samarretes
  testWidgets('Samarretes screen renders initial state', (WidgetTester tester) async {
    // Construye y renderiza el widget SamarretesApp en el árbol de widgets de prueba
    await tester.pumpWidget(const SamarretesApp());

    // Verifica que el texto 'Samarretes Studio' aparezca exactamente una vez
    expect(find.text('Samarretes Studio'), findsOneWidget);
    // Verifica que el texto 'Comanda' aparezca exactamente una vez
    expect(find.text('Comanda'), findsOneWidget);
    // Verifica que el texto 'Introdueix les dades per veure el preu final.' aparezca exactamente una vez
    expect(find.text('Introdueix les dades per veure el preu final.'), findsOneWidget);
  });
}

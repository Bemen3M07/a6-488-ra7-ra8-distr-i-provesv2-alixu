// Importa el paquete de Flutter para widgets de Material Design
import 'package:flutter/material.dart';
// Importa la lógica de cálculo desde el archivo calculator.dart
import '../logic/calculator.dart';

// Clase principal del widget de pantalla para samarretes, extiende StatefulWidget porque maneja estado
class SamarretesScreen extends StatefulWidget {
  // Constructor con clave opcional para identificar el widget
  const SamarretesScreen({super.key}); // Afegeix el constructor amb super.key

  // Método que crea el estado asociado a este widget
  @override
  State<SamarretesScreen> createState() => _SamarretesScreenState();
}

// Clase privada del estado del widget SamarretesScreen
class _SamarretesScreenState extends State<SamarretesScreen> {
  // Variable para almacenar la cantidad de samarretes introducida por el usuario
  int? cantidad;
  // Variable para la talla seleccionada, con valor por defecto 'M'
  String tallaSeleccionada = 'M'; // Valor por defecto para la talla
  // Variable para el descuento seleccionado: 0 (ninguno), 1 (10%), 2 (20€ si >100€)
  int descompteSeleccionado = 0; // 0: Cap, 1: 10%, 2: 20€ (>100)

  // Lista estática de tallas disponibles
  static const List<String> _tallas = <String>['S', 'M', 'L', 'XL']; // Llista de talles disponibles

  // Mapa estático de opciones de descuento
  static const Map<int, String> _descomptes = <int, String>{
    0: 'Cap descompte', // Sin descuento
    1: 'Descompte 10%',
    2: '20 EUR per comandes > 100 EUR',
  };

  // Método build que construye la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    // Calcula el precio final solo si hay cantidad válida
    double? precioFinal;
    if (cantidad != null && cantidad! > 0) {
      // Llama a la función preuDefinitiu del archivo calculator.dart
      precioFinal = preuDefinitiu(cantidad!, tallaSeleccionada, descompteSeleccionado); // Calculamos el precio final usando la función del archivo calculator.dart
    }

    // Retorna el Scaffold principal con fondo transparente
    return Scaffold(
      // Fondo transparente para mostrar el gradiente del contenedor
      backgroundColor: Colors.transparent, // Fondo transparente para mostrar el gradiente del contenedor
      // Usa SafeArea para evitar áreas de sistema
      body: SafeArea(
        // Contenedor con gradiente de fondo
        child: Container(
          // Decoración con gradiente lineal
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFEFF8F6), Color(0xFFF6F3EA)],
            ),
          ),
          // SingleChildScrollView para permitir scroll si es necesario
          child: SingleChildScrollView(
            // Padding alrededor del contenido
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            // Centra el contenido
            child: Center(
              // ConstrainedBox para limitar el ancho máximo
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                // Columna principal con elementos alineados a la izquierda
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contenedor del encabezado con gradiente
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: <Color>[Color(0xFF0D5D56), Color(0xFF2F7F66)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        // Sombra para el contenedor
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x32000000),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      // Columna dentro del contenedor del encabezado
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Texto del título
                          Text(
                            'Samarretes Studio',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          // Espacio entre elementos
                          const SizedBox(height: 8),
                          // Texto descriptivo
                          const Text(
                            'Calcula preu base i descompte en segons.',
                            style: TextStyle(color: Color(0xFFE9FFF8), fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    // Espacio entre secciones
                    const SizedBox(height: 16),
                    // Card para la sección de pedido
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // Padding dentro de la card
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        // Columna dentro de la card
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Título de la sección
                            Text(
                              'Comanda',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            // Espacio
                            const SizedBox(height: 12),
                            // Campo de texto para la cantidad
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Numero de samarretes',
                                prefixIcon: const Icon(Icons.shopping_bag_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              // Actualiza la cantidad al cambiar el texto
                              onChanged: (val) =>
                                  setState(() => cantidad = int.tryParse(val)),
                            ),
                            // Espacio
                            const SizedBox(height: 18),
                            // Texto para la sección de talla
                            const Text('Talla'),
                            // Espacio
                            const SizedBox(height: 8),
                            // Wrap para los chips de selección de talla
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: _tallas
                                  .map(
                                    (talla) => ChoiceChip(
                                      label: Text(talla),
                                      selected: tallaSeleccionada == talla,
                                      // Actualiza la talla seleccionada
                                      onSelected: (_) =>
                                          setState(() => tallaSeleccionada = talla),
                                    ),
                                  )
                                  .toList(),
                            ),
                            // Espacio
                            const SizedBox(height: 18),
                            // Dropdown para seleccionar descuento
                            DropdownButtonFormField<int>(
                              initialValue: descompteSeleccionado,
                              isExpanded: true,
                              decoration: InputDecoration(
                                labelText: 'Descompte',
                                prefixIcon: const Icon(Icons.local_offer_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              // Items del dropdown
                              items: _descomptes.entries
                                  .map(
                                    (entry) => DropdownMenuItem<int>(
                                      value: entry.key,
                                      child: Text(entry.value),
                                    ),
                                  )
                                  .toList(),
                              // Actualiza el descuento seleccionado
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => descompteSeleccionado = val);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Espacio
                    const SizedBox(height: 16),
                    // AnimatedSwitcher para mostrar el precio o el hint
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      switchInCurve: Curves.easeOutBack,
                      switchOutCurve: Curves.easeIn,
                      // Muestra el precio si está disponible, sino el hint
                      child: precioFinal != null
                          ? Container(
                              key: ValueKey<String>('result-${precioFinal.toStringAsFixed(2)}'),
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFFF2FFF9),
                                border: Border.all(color: const Color(0xFFAFD8C7)),
                              ),
                              // Columna para el precio final
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Texto "Preu final"
                                  const Text(
                                    'Preu final',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2A5A4F),
                                    ),
                                  ),
                                  // Espacio
                                  const SizedBox(height: 6),
                                  // Texto del precio
                                  Text(
                                    '${precioFinal.toStringAsFixed(2)} EUR',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(color: const Color(0xFF0D5D56)),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              key: const ValueKey<String>('hint'),
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              // Texto del hint
                              child: const Text(
                                'Introdueix les dades per veure el preu final.',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
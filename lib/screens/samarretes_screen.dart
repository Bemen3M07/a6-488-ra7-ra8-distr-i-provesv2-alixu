import 'package:flutter/material.dart';
import '../logic/calculator.dart';

class SamarretesScreen extends StatefulWidget {
  const SamarretesScreen({super.key});

  @override
  State<SamarretesScreen> createState() => _SamarretesScreenState();
}

class _SamarretesScreenState extends State<SamarretesScreen> {
  int? cantidad;
  String tallaSeleccionada = 'M';
  int descompteSeleccionado = 0; // 0: Cap, 1: 10%, 2: 20€ (>100)

  static const List<String> _tallas = <String>['S', 'M', 'L', 'XL'];

  static const Map<int, String> _descomptes = <int, String>{
    0: 'Cap descompte',
    1: 'Descompte 10%',
    2: '20 EUR per comandes > 100 EUR',
  };

  @override
  Widget build(BuildContext context) {
    // Calculamos el precio solo si tenemos los datos necesarios
    double? precioFinal;
    if (cantidad != null && cantidad! > 0) {
      precioFinal = preuDefinitiu(cantidad!, tallaSeleccionada, descompteSeleccionado);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFEFF8F6), Color(0xFFF6F3EA)],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x32000000),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Samarretes Studio',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Calcula preu base i descompte en segons.',
                            style: TextStyle(color: Color(0xFFE9FFF8), fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Comanda',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Numero de samarretes',
                                prefixIcon: const Icon(Icons.shopping_bag_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (val) =>
                                  setState(() => cantidad = int.tryParse(val)),
                            ),
                            const SizedBox(height: 18),
                            const Text('Talla'),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: _tallas
                                  .map(
                                    (talla) => ChoiceChip(
                                      label: Text(talla),
                                      selected: tallaSeleccionada == talla,
                                      onSelected: (_) =>
                                          setState(() => tallaSeleccionada = talla),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 18),
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
                              items: _descomptes.entries
                                  .map(
                                    (entry) => DropdownMenuItem<int>(
                                      value: entry.key,
                                      child: Text(entry.value),
                                    ),
                                  )
                                  .toList(),
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
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      switchInCurve: Curves.easeOutBack,
                      switchOutCurve: Curves.easeIn,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Preu final',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2A5A4F),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
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
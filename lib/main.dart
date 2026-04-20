// Importa el paquete de Flutter para widgets de Material Design
import 'package:flutter/material.dart';
// Importa la pantalla de samarretes desde el directorio screens
import 'screens/samarretes_screen.dart'; // Importas tu nueva pantalla

// Función principal que inicia la aplicación
void main() {
  // Ejecuta la aplicación con el widget SamarretesApp
  runApp(const SamarretesApp());
}

// Clase principal de la aplicación, extiende StatelessWidget porque no maneja estado
class SamarretesApp extends StatelessWidget {
  // Constructor con clave opcional
  const SamarretesApp({super.key});

  // Método build que construye la aplicación
  @override
  Widget build(BuildContext context) {
    // Define el color semilla para el esquema de colores
    const seed = Color(0xFF0D5D56);

    // Retorna el MaterialApp con la configuración de la aplicación
    return MaterialApp(
      // Oculta el banner de debug en la esquina superior derecha
      debugShowCheckedModeBanner: false,
      // Título de la aplicación
      title: 'Samarretes',
      // Tema de la aplicación
      theme: ThemeData(
        // Esquema de colores generado a partir del color semilla
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        // Usa Material Design 3
        useMaterial3: true,
        // Tema de texto personalizado
        textTheme: const TextTheme(
          // Estilo para títulos grandes
          headlineMedium: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
            fontFamily: 'Georgia',
          ),
          // Estilo para títulos medianos
          titleLarge: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            fontFamily: 'Georgia',
          ),
          // Estilo para texto del cuerpo grande
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          // Estilo para texto del cuerpo mediano
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      // Pantalla inicial de la aplicación
      home: const SamarretesScreen(),
    );
  }
}
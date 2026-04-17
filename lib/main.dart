import 'package:flutter/material.dart';
import 'screens/samarretes_screen.dart'; // Importas tu nueva pantalla

void main() {
  runApp(const SamarretesApp());
}

class SamarretesApp extends StatelessWidget {
  const SamarretesApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF0D5D56);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Samarretes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
            fontFamily: 'Georgia',
          ),
          titleLarge: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            fontFamily: 'Georgia',
          ),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      home: const SamarretesScreen(),
    );
  }
}
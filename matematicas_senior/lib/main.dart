// Importa el paquete principal de Flutter para crear interfaces de usuario
import 'package:flutter/material.dart';

// Importa la librería de Google Fonts para aplicar tipografías personalizadas
import 'package:google_fonts/google_fonts.dart';

// Importa la pantalla principal (home) de la aplicación
import 'package:MatematicasSenior/screens/home_screen.dart';


// Función principal: punto de entrada del programa
void main() {
  // Ejecuta la aplicación Flutter
  runApp(const BrainMathSeniorApp());
}


// Widget principal de la aplicación
class BrainMathSeniorApp extends StatelessWidget {
  // Constructor constante (mejora el rendimiento al no crear nuevas instancias innecesarias)
  const BrainMathSeniorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Devuelve el widget raíz de tipo MaterialApp (estructura base de apps Flutter)
    return MaterialApp(
      // Título de la aplicación (aparece en algunos contextos del sistema)
      title: 'Matemáticas Senior',

      // Tema visual de la aplicación
      theme: ThemeData(
        // Aplica la fuente “Rubik” de Google Fonts a todos los textos de la app
        textTheme: GoogleFonts.rubikTextTheme(),

        // Activa el estilo Material Design 3 (versión más moderna del diseño de Google)
        useMaterial3: true,
      ),

      // Pantalla inicial que se mostrará al abrir la app
      home: const HomeScreen(),

      // Oculta la cinta de "debug" roja que aparece en la esquina superior derecha
      debugShowCheckedModeBanner: false,
    );
  }
}

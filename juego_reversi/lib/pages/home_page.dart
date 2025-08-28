// lib/pages/home_page.dart
// Página inicial con botones estilizados y sin botón de retroceso.
// Logo movido a AppBar en CustomScaffold.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:go_router/go_router.dart'; // Para navegación

import '../widgets/custom_scaffold.dart'; // Scaffold personalizado

// Clase para la pantalla inicial de la app
class HomePage extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el ancho de la pantalla para diseño responsivo
    final screenWidth = MediaQuery.of(context).size.width;

    // Usamos un scaffold personalizado para la estructura de la pantalla
    return CustomScaffold(
      leading: null, // Sin botón de retroceso en la pantalla principal
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos verticalmente
          children: [
            // Botón para navegar a la pantalla del juego
            _buildGradientButton(
              context,
              text: 'Jugar',
              onPressed: () => context.go('/game'), // Navega a la ruta del juego
              width: screenWidth * 0.6, // Ancho relativo al 60% de la pantalla
            ),
            const SizedBox(height: 8), // Espacio vertical
            // Botón para navegar a la pantalla de instrucciones
            _buildGradientButton(
              context,
              text: 'Instrucciones',
              onPressed: () => context.go('/instructions'), // Navega a la ruta de instrucciones
              width: screenWidth * 0.6, // Ancho relativo
            ),
            const SizedBox(height: 8), // Espacio vertical
            // Botón para navegar a la pantalla "Acerca de"
            _buildGradientButton(
              context,
              text: 'Acerca de',
              onPressed: () => context.go('/about'), // Navega a la ruta de "Acerca de"
              width: screenWidth * 0.6, // Ancho relativo
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir un botón con gradiente
  Widget _buildGradientButton(
    BuildContext context, {
    required String text, // Texto del botón
    required VoidCallback onPressed, // Acción al presionar
    required double width, // Ancho del botón
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary], // Gradiente
          begin: Alignment.topLeft, // Inicio del gradiente
          end: Alignment.bottomRight, // Fin del gradiente
        ),
        borderRadius: BorderRadius.circular(12), // Bordes redondeados
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)), // Sombra
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed, // Acción al presionar
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Fondo transparente para mostrar el gradiente
          shadowColor: Colors.transparent, // Sin sombra adicional
          minimumSize: Size(width, 36), // Tamaño mínimo del botón
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), // Estilo del texto
        ),
        child: Text(text), // Texto del botón
      ),
    );
  }
}
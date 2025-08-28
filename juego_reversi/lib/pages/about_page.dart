// lib/pages/about_page.dart
// Página Acerca de con información del autor (Sergi Garcia) y botón de retroceso explícito.
// Logo movido a AppBar en CustomScaffold.

import 'package:flutter/gestures.dart'; // Para manejar gestos de toque
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:go_router/go_router.dart'; // Para navegación
import 'package:url_launcher/url_launcher.dart'; // Para abrir enlaces externos

import '../widgets/custom_scaffold.dart'; // Scaffold personalizado

// Clase para la pantalla "Acerca de"
class AboutPage extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const AboutPage({super.key});

  // Método para abrir URLs en un navegador externo
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url); // Convierte la URL en un objeto Uri
    if (await canLaunchUrl(uri)) { // Verifica si se puede abrir la URL
      await launchUrl(uri, mode: LaunchMode.externalApplication); // Abre en navegador externo
    }
  }

  @override
  Widget build(BuildContext context) {
    // Usamos un scaffold personalizado para la estructura de la pantalla
    return CustomScaffold(
      // Botón de retroceso explícito
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Icono de flecha atrás
        onPressed: () => context.go('/'), // Navega a la pantalla principal
        tooltip: 'Volver', // Texto de ayuda para accesibilidad
      ),
      // Cuerpo de la pantalla, centrado
      body: Center(
        child: Card(
          elevation: 4, // Sombra de la tarjeta
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Espacio interno
            child: Column(
              mainAxisSize: MainAxisSize.min, // Tamaño mínimo para el contenido
              children: [
                // Título de la app
                Text(
                  'Reversi Game v1.0', // Nombre y versión de la app
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold, // Negrita
                        color: Theme.of(context).colorScheme.primary, // Color del tema
                        fontSize: 18, // Tamaño de fuente
                      ),
                ),
                const SizedBox(height: 4), // Espacio vertical
                // Información del autor con enlace
                RichText(
                  textAlign: TextAlign.center, // Centra el texto
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 14, // Tamaño de fuente
                        ),
                    children: [
                      const TextSpan(text: 'Desarrollado con Flutter por '), // Texto estático
                      TextSpan(
                        text: 'Sergi Garcia', // Nombre del autor
                        style: TextStyle(
                          decoration: TextDecoration.underline, // Subrayado
                          color: Theme.of(context).colorScheme.secondary, // Color secundario
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _launchUrl('https://github.com/sergarb1'), // Abre enlace a GitHub
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
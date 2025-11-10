import 'package:flutter/material.dart';

/// ===============================================================
/// WIDGET PERSONALIZADO: CustomScaffold
/// ===============================================================
/// Este widget **envuelve todas las pantallas** de la app (Home, Game, Result).
///
/// **Objetivo principal:**
/// - Crear una **apariencia consistente** en toda la aplicación
/// - Evitar **repetir código** (DRY: Don't Repeat Yourself)
/// - Facilitar el **mantenimiento** y **actualizaciones de diseño**
///
/// **¿Qué hace?**
/// 1. **AppBar personalizado** con:
///    - Logo centrado
///    - Título opcional debajo
///    - Altura grande (100 píxeles)
/// 2. **Fondo con gradiente** azul → violeta en todo el cuerpo
/// 3. **SafeArea automático** (protegido por `Scaffold`)
///
/// **Uso en otras pantallas:**
/// ```dart
/// return CustomScaffold(
///   title: 'Juego',
///   body: MiContenido(),
/// );
/// ```
/// ===============================================================

class CustomScaffold extends StatelessWidget {
  // =======================================================
  // PARÁMETROS DE ENTRADA
  // =======================================================

  /// **Obligatorio**: El contenido principal de la pantalla
  /// Puede ser cualquier widget (Column, ListView, etc.)
  final Widget body;

  /// **Opcional**: Título que aparece debajo del logo
  /// Si es `null`, no se muestra
  final String? title;

  // Constructor con `body` obligatorio y `title` opcional
  const CustomScaffold({super.key, required this.body, this.title});

  @override
  Widget build(BuildContext context) {
    // =======================================================
    // Scaffold: Estructura base de pantalla en Flutter
    // =======================================================
    return Scaffold(
      // ===================================================
      // 1. APPBAR PERSONALIZADA
      // ===================================================
      appBar: AppBar(
        // Altura total del AppBar: 100 píxeles (más grande que el estándar)
        toolbarHeight: 100,

        // Color de fondo del AppBar
        backgroundColor: const Color(0xFF6C5CE7), // Azul violeta

        // Sin sombra inferior (mejor integración con gradiente)
        elevation: 0,

        // Centrar el título (logo + texto)
        centerTitle: true,

        // ===============================================
        // CONTENIDO DEL APPBAR: LOGO + TÍTULO
        // ===============================================
        title: Column(
          children: [
            // -----------------------------
            // LOGO DE LA APP
            // -----------------------------
            ClipRRect(
              // Bordes redondeados del logo
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/logo.png', // Ruta al archivo de imagen
                height: 70,               // Altura del logo
                width: 70,                // Anchura del logo
                fit: BoxFit.contain,      // Ajuste: mantiene proporción
              ),
            ),

            // -----------------------------
            // TÍTULO OPCIONAL
            // -----------------------------
            // Solo se muestra si `title` no es null
            if (title != null) ...[
              const SizedBox(height: 8), // Espacio entre logo y texto
              Text(
                title!, // El símbolo ! fuerza el uso (title no es null aquí)
                style: const TextStyle(
                  fontSize: 24,           // Tamaño grande
                  fontWeight: FontWeight.bold,
                  color: Colors.white,    // Alto contraste
                ),
              ),
            ],
          ],
        ),
      ),

      // ===================================================
      // 2. CUERPO DE LA PANTALLA (con gradiente)
      // ===================================================
      body: Container(
        // Fondo con degradado vertical
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,    // Empieza arriba
            end: Alignment.bottomCenter,   // Termina abajo
            colors: [
              Color(0xFF6C5CE7), // Azul violeta (mismo que AppBar)
              Color(0xFFA29BFE), // Violeta claro
            ],
          ),
        ),
        // Aquí se inserta el contenido real de cada pantalla
        child: body,
      ),
    );
  }
}
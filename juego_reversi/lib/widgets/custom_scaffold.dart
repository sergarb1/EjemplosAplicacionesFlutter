// lib/widgets/custom_scaffold.dart
// Scaffold personalizado con logo centrado en la AppBar y soporte para un widget leading personalizado.
// Sin título de texto, logo más grande, layout compacto.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'logo_widget.dart'; // Widget del logo

// Clase para un scaffold personalizado
class CustomScaffold extends StatelessWidget {
  final Widget body; // Contenido principal de la página
  final Widget? leading; // Widget opcional para el lado izquierdo de la barra

  // Constructor: requiere el body, leading es opcional
  const CustomScaffold({
    super.key,
    required this.body,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    // Construimos un Scaffold con una AppBar personalizada
    return Scaffold(
      appBar: AppBar(
        title: const LogoWidget(appBar: true), // Logo centrado en la AppBar
        centerTitle: true, // Asegura que el logo esté centrado en todas las plataformas
        backgroundColor: Theme.of(context).colorScheme.primaryContainer, // Color de fondo de la barra
        elevation: 4, // Sombra de la barra
        leading: leading, // Usa el widget leading personalizado (ej. botón de retroceso)
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width > 600 ? 16 : 8, // Padding horizontal responsivo
            vertical: 8, // Padding vertical compacto
          ),
          child: body, // Contenido específico de la página
        ),
      ),
    );
  }
}
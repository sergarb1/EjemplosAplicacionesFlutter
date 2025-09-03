// lib/widgets/custom_scaffold.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Widget personalizado que proporciona un Scaffold con AppBar y cuerpo estilizados.
// Muestra solo el logo con bordes redondeados en la AppBar, con un botón de volver opcional.
class CustomScaffold extends StatelessWidget {
  final Widget body; // Contenido del cuerpo.
  final bool showBackButton; // Mostrar botón de volver.
  final Widget? floatingActionButton; // Botón flotante opcional.

  const CustomScaffold({
    super.key,
    required this.body,
    this.showBackButton = true,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar con solo el logo (redondeado) y botón de volver (si aplica).
      appBar: AppBar(
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.go('/'), // Navega a la página principal.
                tooltip: 'Volver',
              )
            : null,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8), // Bordes redondeados para el logo.
          child: Image.asset(
            'assets/images/logo.png',
            height: 40,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.restaurant_menu, color: Colors.white, size: 40),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[700],
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange[700]!, Colors.orange[500]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
      ),
      // Cuerpo con degradado y bordes redondeados.
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange[100]!, Colors.white],
          ),
          borderRadius: BorderRadius.circular(20), // Bordes redondeados.
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Asegura que el contenido respete los bordes.
          child: body,
        ),
      ),
      // Botón flotante pasado como parámetro.
      floatingActionButton: floatingActionButton,
    );
  }
}

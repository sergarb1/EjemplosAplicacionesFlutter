// Widget reutilizable para botones personalizados. Parametrizable con texto, color, onPressed.

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text; // Texto del botón
  final VoidCallback onPressed; // Acción al presionar
  final Color? color; // Color opcional

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).colorScheme.primary, // Color suave por defecto
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados modernos
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding responsivo
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Tipografía legible
      ),
    );
  }
}
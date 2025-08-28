// lib/pages/instructions_page.dart
// Página de instrucciones con estilo moderno.
// Usa CustomScaffold con botón de retroceso explícito.

import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:go_router/go_router.dart'; // Para navegación

import '../widgets/custom_scaffold.dart'; // Scaffold personalizado

// Clase para la pantalla de instrucciones
class InstructionsPage extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const InstructionsPage({super.key});

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
      // Cuerpo de la pantalla con desplazamiento
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espacio alrededor
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Alinea contenido a la izquierda
            children: [
              // Tarjeta con las reglas del juego
              Card(
                elevation: 4, // Sombra de la tarjeta
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bordes redondeados
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Espacio interno
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título de las reglas
                      Text(
                        'Reglas del Reversi',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold, // Negrita
                              color: Theme.of(context).primaryColor, // Color principal
                            ),
                      ),
                      const SizedBox(height: 16), // Espacio vertical
                      // Reglas individuales
                      _buildRuleItem(
                        context,
                        'Objetivo del juego:',
                        'El jugador con más piezas de su color al final del juego gana.',
                      ),
                      _buildRuleItem(
                        context,
                        'Preparación:',
                        'El tablero es 8x8. Se colocan 4 piezas iniciales: 2 blancas y 2 negras en el centro, alternadas.',
                      ),
                      _buildRuleItem(
                        context,
                        'Inicio del juego:',
                        'Las piezas negras siempre comienzan primero.',
                      ),
                      _buildRuleItem(
                        context,
                        'Cómo moverse:',
                        'En tu turno, debes colocar una pieza de tu color en una casilla vacía que "flanquee" una o más piezas del oponente.',
                      ),
                      _buildRuleItem(
                        context,
                        'Qué es flanquear:',
                        'Flanquear significa que tu pieza debe encerrar una o más piezas contrarias entre tu nueva pieza y otra pieza tuya ya colocada, en línea recta (horizontal, vertical o diagonal).',
                      ),
                      _buildRuleItem(
                        context,
                        'Limitaciones para moverse:',
                        'Solo puedes colocar una ficha en posiciones donde captures al menos una ficha del oponente. Si no hay movimientos válidos, debes pasar tu turno.',
                      ),
                      _buildRuleItem(
                        context,
                        'Captura de piezas:',
                        'Cuando colocas tu pieza y flanqueas piezas del oponente, todas esas piezas se voltean y se convierten en piezas de tu color.',
                      ),
                      _buildRuleItem(
                        context,
                        'Fin del juego:',
                        'El juego termina cuando ningún jugador puede hacer un movimiento legal. Esto ocurre cuando todas las casillas están ocupadas o cuando ningún movimiento es posible para ninguno de los jugadores.',
                      ),
                      const SizedBox(height: 8), // Espacio vertical
                      // Consejo estratégico
                      Text(
                        '¡Recuerda que las estrategias en las esquinas y bordes del tablero suelen ser cruciales para ganar!',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontStyle: FontStyle.italic, // Cursiva
                              color: Colors.grey[700], // Color grisáceo
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16), // Espacio vertical
              // Tarjeta con ejemplo visual
              Card(
                elevation: 4, // Sombra de la tarjeta
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bordes redondeados
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0), // Espacio interno
                  child: Text(
                    'Ejemplo visual: Coloca una pieza negra de forma que encierre una o más piezas blancas entre otra pieza negra. Todas las piezas blancas encerradas se voltearán y se convertirán en negras.',
                    semanticsLabel: 'Ejemplo visual de movimiento en Reversi', // Etiqueta para accesibilidad
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir un elemento de regla
  Widget _buildRuleItem(BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0), // Espacio inferior
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold, // Negrita
                  color: Colors.black87, // Color oscuro
                ),
          ),
          const SizedBox(height: 4), // Espacio vertical
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.4, // Interlineado
                ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:MatematicasSenior/screens/game_screen.dart';
import 'package:MatematicasSenior/widgets/custom_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Título superior
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '¡Entrena tu mente!',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 6,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '20 sumas, restas y mutiplicaciones fáciles\n3 opciones por pregunta\n¡Diseñado para ti!',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              // Espacio central (logo ya está en AppBar)

              // Botón JUGAR grande
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const GameScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 12,
                    shadowColor: Colors.orange.withAlpha(140),
                    textStyle: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('¡JUGAR!'),
                ),
              ),

              // Pie de página (opcional)
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Matemáticas Senior © 2025',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
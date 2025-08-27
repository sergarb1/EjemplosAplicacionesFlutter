// lib/pages/home_page.dart
// Página principal de la app.
// Incluye un Slider con referencia visual del número de dados (1 a 20, default 4) y un pie de página con atribución a Icons8.

import 'package:flutter/gestures.dart'; // Para manejar gestos de toque
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:provider/provider.dart'; // Para consumir el provider
import 'package:url_launcher/url_launcher.dart'; // Para abrir enlaces externos

import '../providers/dados_provider.dart'; // Proveedor para manejar el estado de los dados
import '../widgets/dado_widget.dart'; // Widget para mostrar cada dado
import '../widgets/logo_widget.dart'; // Widget para mostrar el logo

// Clase para la pantalla principal de la app
class HomePage extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const HomePage({super.key});

  // Método para abrir URLs en un navegador externo
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url); // Convierte la URL en un objeto Uri
    if (await canLaunchUrl(uri)) { // Verifica si se puede abrir la URL
      await launchUrl(uri, mode: LaunchMode.externalApplication); // Abre en navegador externo
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor de datos para los dados
    final dadosProvider = Provider.of<DadosProvider>(context);
    // Obtenemos el ancho de la pantalla para diseño responsivo
    final screenWidth = MediaQuery.of(context).size.width;

    // Construimos un Scaffold para la estructura de la pantalla
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados Cuentacuentos'), // Título de la barra superior
        backgroundColor: Theme.of(context).colorScheme.primaryContainer, // Color de fondo
        elevation: 2, // Sombra de la barra
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determina cuántos dados por fila según el ancho de la pantalla
          int crossAxisCount = screenWidth > 1200
              ? 6 // Escritorio: 6 dados por fila
              : screenWidth > 600
                  ? 5 // Tableta/web: 5 dados por fila
                  : 4; // Móvil: 4 dados por fila

          // Contenedor con desplazamiento para el contenido
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0), // Espacio alrededor
            child: Column(
              children: [
                // Logo de la app
                const LogoWidget(),
                const SizedBox(height: 20), // Espacio vertical
                // Instrucciones para el usuario
                Text(
                  'Tira los dados y cuenta una historia en el orden que salgan.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: screenWidth > 600 ? 20 : 16, // Tamaño responsivo
                      ),
                  semanticsLabel: 'Instrucciones para contar historia', // Accesibilidad
                  textAlign: TextAlign.center, // Centra el texto
                ),
                const SizedBox(height: 20), // Espacio vertical
                // Selector de número de dados con slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${dadosProvider.numberOfDados} dados seleccionados', // Muestra número de dados
                      style: const TextStyle(fontSize: 16),
                      semanticsLabel: '${dadosProvider.numberOfDados} dados seleccionados', // Accesibilidad
                    ),
                    const SizedBox(width: 10), // Espacio horizontal
                    SizedBox(
                      width: screenWidth > 600 ? 300 : 180, // Ancho responsivo del slider
                      child: Slider(
                        value: dadosProvider.numberOfDados.toDouble(), // Valor actual
                        min: 1, // Mínimo 1 dado
                        max: 20, // Máximo 20 dados
                        divisions: 19, // Divisiones para valores enteros
                        label: '${dadosProvider.numberOfDados}', // Etiqueta con el número
                        onChanged: (value) {
                          dadosProvider.setNumberOfDados(value.round()); // Actualiza número de dados
                        },
                        activeColor: Theme.of(context).colorScheme.primary, // Color del slider activo
                        inactiveColor: Theme.of(context).colorScheme.primary.withValues(alpha:0.3), // Color inactivo
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Espacio vertical
                // Muestra los dados o un mensaje si no hay dados tirados
                dadosProvider.dadosTirados.isEmpty
                    ? const Center(
                        child: Text(
                          'Presiona el botón para tirar los dados.', // Mensaje inicial
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true, // Ajusta el tamaño al contenido
                        physics: const NeverScrollableScrollPhysics(), // Desactiva desplazamiento propio
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount, // Número de columnas
                          crossAxisSpacing: 6, // Espacio horizontal entre dados
                          mainAxisSpacing: 6, // Espacio vertical entre dados
                          childAspectRatio: 1, // Proporción cuadrada para dados
                        ),
                        itemCount: dadosProvider.dadosTirados.length, // Número de dados
                        itemBuilder: (context, index) {
                          // Crea un widget para cada dado
                          return DadoWidget(dado: dadosProvider.dadosTirados[index]);
                        },
                      ),
                const SizedBox(height: 20), // Espacio vertical
                // Pie de página con atribución a Icons8
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10), // Espacio vertical
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      children: [
                        // Enlace a la página del icono Clover
                        TextSpan(
                          text: 'Clover',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _launchUrl('https://icons8.com/icon/576/clover'),
                        ),
                        const TextSpan(text: ' icon by '),
                        // Enlace a la página principal de Icons8
                        TextSpan(
                          text: 'Icons8',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _launchUrl('https://icons8.com'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // Botón flotante para tirar los dados
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await dadosProvider.rollDados(); // Ejecuta la acción de tirar dados
        },
        backgroundColor: Theme.of(context).colorScheme.secondary, // Color del botón
        tooltip: 'Tirar dados', // Texto de ayuda
        child: const Icon(Icons.casino), // Icono de dado
      ),
    );
  }
}
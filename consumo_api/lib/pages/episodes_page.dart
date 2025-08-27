// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:go_router/go_router.dart'; // Para navegar entre pantallas
import 'package:google_fonts/google_fonts.dart'; // Para fuentes personalizadas
import 'package:provider/provider.dart'; // Para manejar el estado con Provider
import 'package:consumo_api/providers/api_provider.dart'; // Proveedor con datos de la API
import 'package:consumo_api/widgets/custom_scaffold.dart'; // Widget personalizado
import 'package:consumo_api/widgets/episode_card.dart'; // Widget para mostrar episodios

// Clase para la pantalla que muestra la lista de episodios
class EpisodesPage extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const EpisodesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor de datos para acceder a los episodios
    final apiProvider = context.watch<ApiProvider>();
    // Obtenemos el tema de la app para usar colores y estilos
    final theme = Theme.of(context);

    // Usamos un scaffold personalizado para la estructura de la pantalla
    return CustomScaffold(
      // Botón para regresar a la pantalla principal
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Icono de flecha atrás
        onPressed: () => context.go('/'), // Navega a la ruta principal
      ),
      // Cuerpo de la pantalla con una columna
      body: Column(
        children: [
          // Título de la pantalla
          Padding(
            padding: const EdgeInsets.all(16.0), // Espacio alrededor
            child: Text(
              'Episodios', // Texto del título
              style: GoogleFonts.poppins(
                fontSize: 24, // Tamaño de fuente
                fontWeight: FontWeight.bold, // Negrita
                color: theme.colorScheme.primary, // Color del tema
              ),
            ),
          ),
          // Si está cargando datos, mostramos un indicador de carga
          if (apiProvider.isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator())),
          // Si hay un error, mostramos el mensaje de error
          if (apiProvider.error != null)
            Expanded(
              child: Center(
                child: Text(
                  apiProvider.error!, // Mensaje de error
                  style: GoogleFonts.poppins(fontSize: 16), // Estilo de fuente
                ),
              ),
            ),
          // Si no está cargando y no hay error, mostramos la lista de episodios
          if (!apiProvider.isLoading && apiProvider.error == null)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0), // Espacio alrededor
                itemCount: apiProvider.episodes.length, // Número de episodios
                itemBuilder: (context, index) {
                  // Crea una tarjeta para cada episodio
                  return EpisodeCard(episode: apiProvider.episodes[index]);
                },
              ),
            ),
          // Si hay una página siguiente, mostramos un botón para cargar más
          if (apiProvider.episodeInfo?.next != null)
            Padding(
              padding: const EdgeInsets.all(16.0), // Espacio alrededor
              child: ElevatedButton(
                // Acción al presionar el botón
                onPressed: () {
                  // Obtenemos el número de la siguiente página desde la URL
                  final nextPage = int.parse(Uri.parse(apiProvider.episodeInfo!.next!).queryParameters['page']!);
                  // Cargamos los episodios de la siguiente página
                  apiProvider.loadEpisodes(page: nextPage);
                },
                // Estilo del botón
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary, // Color de fondo
                  foregroundColor: theme.colorScheme.onPrimary, // Color del texto
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
                ),
                child: Text('Cargar más', style: GoogleFonts.poppins(fontSize: 16)), // Texto del botón
              ),
            ),
        ],
      ),
    );
  }
}
// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:google_fonts/google_fonts.dart'; // Para fuentes personalizadas
import 'package:provider/provider.dart'; // Para manejar el estado con Provider
import 'package:curriculum/providers/cv_provider.dart'; // Proveedor de datos del CV
import 'package:curriculum/widgets/custom_scaffold.dart'; // Scaffold personalizado
import 'package:go_router/go_router.dart'; // Para navegar entre pantallas

// Clase para la pantalla de contacto
class ContactScreen extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor de datos del CV
    final cvProvider = context.watch<CvProvider>();
    // Obtenemos el tema de la app para usar estilos
    final theme = Theme.of(context);

    // Si los datos del CV no están disponibles, mostramos un indicador de carga
    if (cvProvider.cvData == null) {
      return const CustomScaffold(
        body: Center(child: CircularProgressIndicator()), // Indicador de carga
      );
    }

    // Obtenemos los datos del CV
    final cv = cvProvider.cvData!;

    // Usamos un scaffold personalizado para la estructura de la pantalla
    return CustomScaffold(
      // Botón para regresar a la pantalla principal
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Icono de flecha atrás
        onPressed: () => context.go('/'), // Navega a la ruta principal
      ),
      // Cuerpo de la pantalla con padding
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espacio alrededor del contenido
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinea contenido a la izquierda
          children: [
            // Título de la pantalla
            Text(
              'Contacto', // Texto del título
              style: GoogleFonts.poppins(
                fontSize: 24, // Tamaño de fuente
                fontWeight: FontWeight.bold, // Negrita
                color: theme.colorScheme.primary, // Color del tema
              ),
            ),
            const SizedBox(height: 16), // Espacio vertical
            // Tarjeta para mostrar el correo electrónico
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
              elevation: 4, // Sombra de la tarjeta
              child: ListTile(
                leading: const Icon(Icons.email), // Icono de correo
                title: Text(
                  cv.email, // Correo del CV
                  style: GoogleFonts.poppins(fontSize: 16), // Estilo de fuente
                ),
              ),
            ),
            const SizedBox(height: 8), // Espacio vertical
            // Tarjeta para mostrar el número de teléfono
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
              elevation: 4, // Sombra de la tarjeta
              child: ListTile(
                leading: const Icon(Icons.phone), // Icono de teléfono
                title: Text(
                  cv.phone, // Teléfono del CV
                  style: GoogleFonts.poppins(fontSize: 16), // Estilo de fuente
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
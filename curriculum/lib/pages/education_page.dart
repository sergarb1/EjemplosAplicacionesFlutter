// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:google_fonts/google_fonts.dart'; // Para fuentes personalizadas
import 'package:provider/provider.dart'; // Para manejar el estado con Provider
import 'package:curriculum/providers/cv_provider.dart'; // Proveedor de datos del CV
import 'package:curriculum/widgets/custom_scaffold.dart'; // Scaffold personalizado
import 'package:go_router/go_router.dart'; // Para navegar entre pantallas

// Clase para la pantalla de formación académica
class EducationScreen extends StatelessWidget {
  // Constructor constante, no requiere parámetros
  const EducationScreen({super.key});

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

    // Obtenemos la lista de educación del CV
    final education = cvProvider.cvData!.education;

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
              'Formación Académica', // Texto del título
              style: GoogleFonts.poppins(
                fontSize: 24, // Tamaño de fuente
                fontWeight: FontWeight.bold, // Negrita
                color: theme.colorScheme.primary, // Color del tema
              ),
            ),
          ),
          // Lista de elementos de educación
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0), // Espacio alrededor
              itemCount: education.length, // Número de elementos de educación
              itemBuilder: (context, index) {
                // Obtenemos el elemento de educación en el índice actual
                final edu = education[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0), // Margen vertical
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
                  elevation: 4, // Sombra de la tarjeta
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0), // Espacio interno
                    // Título: grado académico
                    title: Text(
                      edu.degree,
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold), // Estilo de fuente
                    ),
                    // Subtítulo: institución y período
                    subtitle: Text(
                      '${edu.institution}\n${edu.period}', // Muestra institución y período
                      style: GoogleFonts.poppins(fontSize: 14), // Estilo de fuente
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// Importamos el paquete para manejar rutas
import 'package:go_router/go_router.dart'; // Herramienta para navegación
import 'package:curriculum/pages/contact_page.dart'; // Página de contacto
import 'package:curriculum/pages/education_page.dart'; // Página de formación
import 'package:curriculum/pages/experience_page.dart'; // Página de experiencia
import 'package:curriculum/pages/home_page.dart'; // Página principal
import 'package:curriculum/pages/skills_page.dart'; // Página de habilidades

// Definimos el enrutador de la app
final GoRouter router = GoRouter(
  routes: [
    // Ruta principal: muestra la pantalla de inicio
    GoRoute(
      path: '/', // URL base
      builder: (context, state) => const HomeScreen(), // Carga HomeScreen
    ),
    // Ruta para la pantalla de formación académica
    GoRoute(
      path: '/education', // URL para formación
      builder: (context, state) => const EducationScreen(), // Carga EducationScreen
    ),
    // Ruta para la pantalla de experiencia laboral
    GoRoute(
      path: '/experience', // URL para experiencia
      builder: (context, state) => const ExperienceScreen(), // Carga ExperienceScreen
    ),
    // Ruta para la pantalla de habilidades
    GoRoute(
      path: '/skills', // URL para habilidades
      builder: (context, state) => const SkillsScreen(), // Carga SkillsScreen
    ),
    // Ruta para la pantalla de contacto
    GoRoute(
      path: '/contact', // URL para contacto
      builder: (context, state) => const ContactScreen(), // Carga ContactScreen
    ),
  ],
);
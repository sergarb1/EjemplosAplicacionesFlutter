// Importamos paquetes necesarios para la app
import 'package:flutter/material.dart'; // Herramientas básicas de Flutter
import 'package:curriculum/models/cv_model.dart'; // Modelo para los datos del CV

// Clase para manejar el estado de los datos del currículum
class CvProvider extends ChangeNotifier {
  // Propiedad para almacenar los datos del CV
  CvModel? cvData;

  // Método para cargar los datos del CV
  Future<void> loadCvData() async {
    // Asignamos un objeto CvModel con datos predefinidos
    cvData = CvModel(
      name: 'Juan Pérez García', // Nombre completo
      title: 'Desarrollador de Aplicaciones Multiplataforma', // Título profesional
      profileImage: 'assets/images/profile.png', // Ruta de la imagen de perfil
      summary:
          'Estudiante de CFGS en Desarrollo de Aplicaciones Multiplataforma con pasión por la tecnología y el desarrollo de software. Experto en múltiples lenguajes y frameworks, con habilidades en trabajo en equipo, resolución de problemas y comunicación efectiva.', // Resumen profesional
      education: [
        // Estudios realizados
        Education(
          degree: 'CFGS Desarrollo de Aplicaciones Multiplataforma',
          institution: 'IES Serra Perenxisa, Torrent - Valencia',
          period: '2023 - 2025',
        ),
        Education(
          degree: 'Bachillerato Tecnológico',
          institution: 'IES Serra Perenxisa, Torrent',
          period: '2021 - 2023',
        ),
      ],
      experience: [
        // Experiencias laborales
        Experience(
          position: 'Desarrollador Junior (Prácticas)',
          company: 'TechSolutions SL',
          period: 'Jun 2024 - Sep 2024',
          description: 'Desarrollo de una app móvil en Flutter para gestión de inventarios. Implementación de APIs REST y testing unitario.',
        ),
        Experience(
          position: 'Colaborador en Proyecto Open Source',
          company: 'GitHub Community',
          period: 'Ene 2024 - May 2024',
          description: 'Contribución a un proyecto de app web en React. Corrección de bugs y optimización de componentes.',
        ),
      ],
      technicalSkills: [
        // Habilidades técnicas
        'Flutter/Dart', 'React', 'Node.js', 'JavaScript', 'TypeScript', 'Python',
        'Java', 'Kotlin', 'Swift', 'SQL', 'Firebase', 'MongoDB', 'REST APIs',
        'GraphQL', 'Docker', 'Git', 'CI/CD', 'Unit Testing', 'Agile/Scrum',
      ],
      softSkills: [
        // Habilidades blandas
        'Trabajo en equipo', 'Resolución de problemas', 'Comunicación efectiva',
        'Adaptabilidad', 'Gestión del tiempo', 'Pensamiento crítico',
      ],
      languages: [
        // Idiomas
        Language(name: 'Español', level: 'Nativo'),
        Language(name: 'Valenciano', level: 'Nativo'),
        Language(name: 'Inglés', level: 'C1 - Avanzado'),
      ],
      email: 'juan.perez@correofalso.com', // Correo electrónico
      phone: '+34 123 456 789', // Número de teléfono
    );
    notifyListeners(); // Notifica a los widgets que los datos han cambiado
  }
}
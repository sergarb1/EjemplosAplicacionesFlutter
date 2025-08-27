// Clase para representar un currículum (CV)
class CvModel {
  // Propiedades del currículum, todas son requeridas
  final String name; // Nombre completo de la persona
  final String title; // Título profesional (ej. "Desarrollador de Software")
  final String profileImage; // Ruta o URL de la imagen de perfil
  final String summary; // Resumen profesional o descripción personal
  final List<Education> education; // Lista de estudios realizados
  final List<Experience> experience; // Lista de experiencias laborales
  final List<String> technicalSkills; // Lista de habilidades técnicas
  final List<String> softSkills; // Lista de habilidades blandas
  final List<Language> languages; // Lista de idiomas
  final String email; // Correo electrónico
  final String phone; // Número de teléfono

  // Constructor: requiere todas las propiedades
  CvModel({
    required this.name,
    required this.title,
    required this.profileImage,
    required this.summary,
    required this.education,
    required this.experience,
    required this.technicalSkills,
    required this.softSkills,
    required this.languages,
    required this.email,
    required this.phone,
  });
}

// Clase para representar un elemento de educación
class Education {
  // Propiedades de la educación
  final String degree; // Título obtenido (ej. "Ingeniería en Informática")
  final String institution; // Nombre de la institución educativa
  final String period; // Período de estudio (ej. "2018 - 2022")

  // Constructor: requiere todas las propiedades
  Education({
    required this.degree,
    required this.institution,
    required this.period,
  });
}

// Clase para representar una experiencia laboral
class Experience {
  // Propiedades de la experiencia
  final String position; // Puesto de trabajo (ej. "Desarrollador Junior")
  final String company; // Nombre de la empresa
  final String period; // Período de trabajo (ej. "2022 - Presente")
  final String description; // Descripción de las responsabilidades

  // Constructor: requiere todas las propiedades
  Experience({
    required this.position,
    required this.company,
    required this.period,
    required this.description,
  });
}

// Clase para representar un idioma
class Language {
  // Propiedades del idioma
  final String name; // Nombre del idioma (ej. "Inglés")
  final String level; // Nivel de dominio (ej. "Avanzado")

  // Constructor: requiere todas las propiedades
  Language({
    required this.name,
    required this.level,
  });
}
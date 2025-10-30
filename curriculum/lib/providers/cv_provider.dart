// Importamos las librerías necesarias
import 'dart:convert'; // Para decodificar el contenido del archivo JSON
import 'package:flutter/services.dart'; // Para acceder a los archivos en assets
import 'package:flutter/material.dart'; // Para poder usar ChangeNotifier
import 'package:curriculum/models/cv_model.dart'; // Importamos nuestras clases de modelo (CvModel, Education, etc.)

// Creamos una clase CvProvider que se encargará de cargar los datos del CV
// Esta clase extiende ChangeNotifier para que los widgets puedan escuchar los cambios
class CvProvider extends ChangeNotifier {
  // Creamos una propiedad que contendrá el objeto CvModel con los datos del currículum
  CvModel? cvData;

  // Método que cargará los datos desde el archivo JSON
  Future<void> loadCvData() async {
    // Leemos el contenido del archivo JSON como un String
    // La ruta debe coincidir con la definida en pubspec.yaml
    final String jsonString = await rootBundle.loadString('assets/data/data.json');

    // Convertimos el texto JSON a un mapa de clave-valor (Map<String, dynamic>)
    final Map<String, dynamic> json = jsonDecode(jsonString);

    // Creamos una instancia de CvModel a partir de los datos del mapa JSON
    // Convertimos también las listas de educación, experiencia, habilidades e idiomas
    cvData = CvModel(
      name: json['name'], // Accedemos al valor del campo "name"
      title: json['title'], // Accedemos al título profesional
      profileImage: json['profileImage'], // Ruta de la imagen de perfil
      summary: json['summary'], // Resumen profesional

      // Mapeamos la lista de educación (cada elemento es un Map) a objetos Education
      education: (json['education'] as List)
          .map((e) => Education(
                degree: e['degree'],
                institution: e['institution'],
                period: e['period'],
              ))
          .toList(), // Convertimos el resultado a lista

      // Mapeamos la lista de experiencias a objetos Experience
      experience: (json['experience'] as List)
          .map((e) => Experience(
                position: e['position'],
                company: e['company'],
                period: e['period'],
                description: e['description'],
              ))
          .toList(),

      // Las habilidades técnicas y blandas ya son listas de String
      technicalSkills: List<String>.from(json['technicalSkills']),
      softSkills: List<String>.from(json['softSkills']),

      // Mapeamos la lista de idiomas a objetos Language
      languages: (json['languages'] as List)
          .map((l) => Language(
                name: l['name'],
                level: l['level'],
              ))
          .toList(),

      // Datos de contacto
      email: json['email'],
      phone: json['phone'],
    );

    // Notificamos a los widgets que están escuchando para que se actualicen
    notifyListeners();
  }
}

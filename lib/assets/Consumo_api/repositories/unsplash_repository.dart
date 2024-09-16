import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:technical_challenge/assets/Consumo_api/models/photo_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Clase UnsplashRepository que maneja la interacción con la API de Unsplash.
class UnsplashRepository {
  // URL base para la búsqueda de fotos en la API de Unsplash.
  final String baseUrl = 'https://api.unsplash.com/search/photos';

  /// Método searchPhotos que realiza una solicitud a la API de Unsplash para buscar fotos basadas en un término de búsqueda (query).
  /// Retorna una lista de objetos Photo si la solicitud es exitosa.
  Future<List<Photo>> searchPhotos(String query) async {
    // Realiza una solicitud HTTP GET a la API de Unsplash.
    final response = await http.get(
      Uri.parse('$baseUrl?query=$query'), // Construye la URL de la solicitud con el término de búsqueda.
      headers: {
        // Cabecera de autorización que incluye la clave API obtenida de las variables de entorno.
        'Authorization': 'Client-ID ${dotenv.env['UNSPLASH_API_KEY']}',
      },
    );

    // Imprime el cuerpo de la respuesta HTTP para depuración.
    debugPrint(response.body);

    // Verifica si la solicitud fue exitosa (código de estado 200).
    if (response.statusCode == 200) {
      // Decodifica la respuesta JSON en un mapa de datos.
      final Map<String, dynamic> data = json.decode(response.body);
      
      // Extrae la lista de resultados (fotos) del mapa de datos.
      final List<dynamic> results = data['results'];
      
      // Mapea cada elemento JSON en la lista de resultados a un objeto Photo y retorna la lista de fotos.
      return results.map((json) => Photo.fromJson(json)).toList();
    } else {
      // Si la solicitud no fue exitosa, lanza una excepción con un mensaje de error.
      throw Exception('Error al cargar las imagenes');
    }
  }
}
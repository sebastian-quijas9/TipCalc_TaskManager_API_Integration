/// Clase Photo que representa una foto con sus atributos principales.
/// Esta clase modela los datos que se obtienen de la API de Unsplash.
class Photo {
  final String id; // Identificador único de la foto.
  final String title; // Título o descripción de la foto.
  final String thumbnailUrl; // URL de la imagen en miniatura.
  final String fullImageUrl; // URL de la imagen en tamaño completo.

  // Constructor de la clase Photo.  Todos los campos son requeridos y deben ser proporcionados al crear una instancia de Photo..
  Photo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.fullImageUrl,
  });

  /// Constructor que crea una instancia de Photo a partir de un JSON.
  /// Toma un Map<String, dynamic> que representa el JSON y extrae los valores necesarios.
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json[
          'id'], // Asigna el valor del campo id en el JSON a la propiedad id.

      // Asigna el valor del campo description en el JSON a la propiedad title.
      // Si description es null, asigna 'Sin título' como valor por defecto.
      title: json['description'] ?? 'Sin título',

      // Asigna la URL de la imagen en miniatura desde la clave thumb dentro del campo urls en el JSON.
      thumbnailUrl: json['urls']['thumb'],

      // Asigna la URL de la imagen en tamaño completo desde la clave regular dentro del campo urls en el JSON.
      fullImageUrl: json['urls']['regular'],
    );
  }
}

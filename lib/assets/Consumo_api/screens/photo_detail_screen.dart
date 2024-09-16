import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Importa el paquete shimmer para el efecto de carga.
import 'package:technical_challenge/assets/Consumo_api/models/photo_model.dart';

class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  const PhotoDetailScreen({required this.photo, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Icono de regresar en color blanco.
          onPressed: () {
            Navigator.of(context).pop(); // Navega de regreso a la pantalla anterior.
          },
        ),
        title: const Row(
          children: [
             Text(
              'Detalles', // Texto del título del AppBar.
              style: TextStyle(
                color: Colors.white, // Color del texto en blanco.
                fontWeight: FontWeight.bold, // Texto en negrita.
                overflow: TextOverflow.ellipsis, // Trunca el texto si es muy largo.
              ),
              maxLines: 1, // El texto se muestra en una sola línea.
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding alrededor del cuerpo de la pantalla.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinea el contenido al inicio en la horizontal.
          children: [
            // Imagen principal con efecto de carga.
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0), // Esquinas redondeadas para la imagen.
                  child: Image.network(
                    photo.fullImageUrl, // URL de la imagen en tamaño completo.
                    fit: BoxFit.cover, // Asegura que la imagen cubra el área disponible sin distorsión.
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      // Efecto shimmer mientras la imagen se carga.
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: double.infinity, // El ancho ocupa todo el espacio disponible.
                          height: double.infinity, // La altura ocupa todo el espacio disponible.
                          color: Colors.grey.shade300, // Color de fondo para el shimmer.
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), // Espacio entre la imagen y la descripción.
            // Descripción de la foto con fondo gris.
            Container(
              padding: const EdgeInsets.all(12.0), // Padding interno dentro del contenedor.
              decoration: BoxDecoration(
                color: Colors.grey.shade200, // Fondo gris para la descripción.
                borderRadius: BorderRadius.circular(8.0), // Esquinas redondeadas para el contenedor.
              ),
              child: Text(
                photo.title, // Muestra la descripción de la foto.
                style: const TextStyle(
                  fontSize: 16, // Tamaño de la fuente para la descripción.
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

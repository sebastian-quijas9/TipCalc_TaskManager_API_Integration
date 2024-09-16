import 'package:flutter/material.dart';
import 'package:technical_challenge/assets/Consumo_api/models/photo_model.dart';
import 'package:technical_challenge/assets/Consumo_api/screens/photo_detail_screen.dart';

// Cada foto se muestra como un GridTile, y al hacer clic en una foto, se navega a una pantalla de detalles.
class PhotoGrid extends StatelessWidget {
  // Lista de fotos que se mostrarán en la cuadrícula.
  final List<Photo> photos;

  /// Constructor de PhotoGrid que requiere una lista de fotos.
  const PhotoGrid({required this.photos, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // Define cómo se organiza la cuadrícula con un número fijo de columnas.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Número de columnas en la cuadrícula.
        crossAxisSpacing: 8, // Espacio horizontal entre los elementos de la cuadrícula.
        mainAxisSpacing: 8, // Espacio vertical entre los elementos de la cuadrícula.
      ),
      itemCount: photos.length, // Número total de elementos en la cuadrícula.
      itemBuilder: (context, index) {
        // Obtiene la foto actual basada en el índice.
        final photo = photos[index];
        return GestureDetector(
          // Detecta toques en el elemento de la cuadrícula.
          onTap: () {
            // Navega a la pantalla de detalles de la foto cuando se hace clic en una foto.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PhotoDetailScreen(photo: photo), // Pasa la foto seleccionada a la pantalla de detalles.
              ),
            );
          },
          child: GridTile(
            // GridTile es un widget que organiza la imagen y el texto superpuesto en la cuadrícula.
            footer: GridTileBar(
              // Barra en la parte inferior del GridTile que muestra el título de la foto.
              backgroundColor: Colors.black54, // Fondo semitransparente para el texto del título.
              title: Text(
                photo.title, // Título de la foto.
                textAlign: TextAlign.center, // Alinea el texto al centro.
              ),
            ),
            // Muestra la imagen en miniatura de la foto dentro de la cuadrícula.
            child: Image.network(
              photo.thumbnailUrl, // URL de la imagen en miniatura.
              fit: BoxFit.cover, // Asegura que la imagen cubra todo el espacio disponible en el tile sin distorsión.
            ),
          ),
        );
      },
    );
  }
}
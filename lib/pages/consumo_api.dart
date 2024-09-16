import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_challenge/assets/Consumo_api/blocs/search_bloc.dart';
import 'package:technical_challenge/assets/Consumo_api/blocs/search_event.dart';
import 'package:technical_challenge/assets/Consumo_api/blocs/search_state.dart';
import 'package:technical_challenge/assets/Consumo_api/widgets/photo_grid.dart';
import 'package:shimmer/shimmer.dart';

class ApiPage extends StatelessWidget {
  const ApiPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controlador para capturar el texto ingresado en el campo de búsqueda.
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
            16.0), // Añade padding alrededor del cuerpo principal de la página.
        child: Column(
          children: [
            // Campo de texto para ingresar el término de búsqueda.
            TextField(
              controller: controller, // Asigna el controlador al TextField.
              decoration: const InputDecoration(
                labelText: 'Buscar fotos',
                border:
                    OutlineInputBorder(), // Borde alrededor del campo de texto.
                suffixIcon: Icon(Icons
                    .search), // Icono de búsqueda al final del campo de texto.
              ),
              // Acción a realizar cuando el usuario presiona Enter después de ingresar el término de búsqueda.
              onSubmitted: (query) {
                // Envía un evento al SearchBloc para iniciar la búsqueda con el término ingresado.
                context.read<SearchBloc>().add(SearchPhotosEvent(query));
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              // BlocBuilder escucha los cambios de estado en el BLoC y reconstruye el widget según el estado actual.
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  // Si el estado es de carga, muestra la cuadrícula de carga animada.
                  if (state is SearchLoading) {
                    return buildLoadingGrid(); // Muestra la silueta de cuadros de carga mientras se realiza la búsqueda.
                  }
                  // Si la búsqueda se completó con éxito, muestra la cuadrícula de fotos.
                  else if (state is SearchLoaded) {
                    return PhotoGrid(
                        photos: state
                            .photos); // Muestra las fotos en una cuadrícula.
                  }
                  // Si ocurre un error durante la búsqueda, muestra un mensaje de error.
                  else if (state is SearchError) {
                    return Center(
                        child: Text(state
                            .message)); // Muestra el mensaje de error en el centro de la pantalla.
                  }
                  // Si aún no se ha realizado ninguna búsqueda, muestra un mensaje inicial.
                  else {
                    return const Center(
                        child: Text(
                            'Ingresa un término de búsqueda.')); // Muestra un mensaje que invita a ingresar un término de búsqueda.
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construye una cuadrícula de cuadros animados que simulan la carga de las imágenes.
  Widget buildLoadingGrid() {
    return GridView.builder(
      itemCount: 12,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Número de columnas en la cuadrícula.
        crossAxisSpacing: 10, // Espaciado horizontal entre las columnas.
        mainAxisSpacing: 10, // Espaciado vertical entre las filas.
      ),
      // Construye cada elemento de la cuadrícula.
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor:
              Colors.grey.shade300, // Color base para el efecto de shimmer.
          highlightColor: Colors.grey
              .shade100, // Color de resaltado que crea el efecto de brillo.
          child: Container(
            color: Colors
                .grey.shade200, // Color de fondo que simula el cuadro de carga.
          ),
        );
      },
    );
  }
}

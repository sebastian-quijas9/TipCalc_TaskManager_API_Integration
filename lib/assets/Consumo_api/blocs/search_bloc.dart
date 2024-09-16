import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_challenge/assets/Consumo_api/blocs/search_event.dart';
import 'package:technical_challenge/assets/Consumo_api/blocs/search_state.dart';
import 'package:technical_challenge/assets/Consumo_api/repositories/unsplash_repository.dart';

/// Recibe eventos relacionados con la búsqueda y emite estados según el resultado.
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  // Repositorio de Unsplash que maneja las solicitudes a la API.
  final UnsplashRepository repository;

  /// Constructor de SearchBloc que inicializa el repositorio y el estado inicial.
  SearchBloc(this.repository) : super(SearchInitial()) {
    // Registra el manejador de eventos para `SearchPhotosEvent`.
    // Cuando se recibe un `SearchPhotosEvent`, se ejecuta `_onSearchPhotos`.
    on<SearchPhotosEvent>(_onSearchPhotos);
  }

  /// Método privado que maneja el evento `SearchPhotosEvent`.
  /// Este método se ejecuta de forma asíncrona.
  void _onSearchPhotos(
      SearchPhotosEvent event, Emitter<SearchState> emit) async {
    // Emite el estado `SearchLoading`, indicando que la búsqueda está en proceso.
    emit(SearchLoading());
    try {
      // Realiza la búsqueda de fotos utilizando el repositorio.
      final photos = await repository.searchPhotos(event.query);

      // Si la búsqueda es exitosa, emite el estado `SearchLoaded` con las fotos encontradas.
      emit(SearchLoaded(photos));
    } catch (e) {
      // Si ocurre un error durante la búsqueda, emite el estado `SearchError` con un mensaje de error.
      emit(const SearchError('Fallo al cargar las imagenes'));
    }
  }
}

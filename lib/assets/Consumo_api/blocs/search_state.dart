import 'package:equatable/equatable.dart'; 
import 'package:technical_challenge/assets/Consumo_api/models/photo_model.dart';

/// Clase abstracta SearchState que representa los diferentes estados posibles en el proceso de búsqueda.
/// Extiende Equatable para facilitar la comparación de instancias de estado.
abstract class SearchState extends Equatable {
  const SearchState(); // Constructor constante para SearchState.

  /// Propiedad props que retorna una lista de propiedades que se usarán para comparar instancias de estado.
  /// Aquí se devuelve una lista vacía, ya que no hay propiedades en la clase abstracta.
  @override
  List<Object> get props => [];
}

/// Estado inicial SearchInitial que indica que no se ha iniciado ninguna búsqueda.
/// Este es el estado por defecto cuando la búsqueda no ha comenzado.
class SearchInitial extends SearchState {}

/// Estado SearchLoading que indica que la búsqueda está en progreso.
/// Este estado se emite cuando se está realizando la búsqueda de fotos.
class SearchLoading extends SearchState {}

/// Estado SearchLoaded que indica que la búsqueda se ha completado con éxito.
/// Contiene una lista de objetos Photo que representan los resultados de la búsqueda.
class SearchLoaded extends SearchState {
  final List<Photo> photos; // Lista de fotos obtenidas de la búsqueda.

  /// Constructor para SearchLoaded que toma la lista de fotos como argumento.
  const SearchLoaded(this.photos);

  /// Sobrescribe la propiedad props para incluir la lista de fotos en la comparación.
  /// Esto permite que dos instancias de SearchLoaded sean consideradas iguales si contienen las mismas fotos.
  @override
  List<Object> get props => [photos];
}

/// Estado SearchError que indica que ocurrió un error durante la búsqueda.
/// Contiene un mensaje de error que describe el problema.
class SearchError extends SearchState {
  final String message; // Mensaje que describe el error ocurrido.

  /// Constructor para SearchError que toma el mensaje de error como argumento.
  const SearchError(this.message);

  /// Sobrescribe la propiedad props para incluir el mensaje de error en la comparación.
  /// Esto permite que dos instancias de SearchError sean consideradas iguales si tienen el mismo mensaje.
  @override
  List<Object> get props => [message];
}

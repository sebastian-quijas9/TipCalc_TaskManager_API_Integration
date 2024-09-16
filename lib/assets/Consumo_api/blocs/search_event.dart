import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent(); // Constructor constante para SearchEvent.

  /// Propiedad props que retorna una lista de propiedades que se usarán para comparar instancias de eventos.
  /// Aquí se devuelve una lista vacía, ya que no hay propiedades en la clase.
  @override
  List<Object> get props => [];
}

/// Representa el evento de búsqueda de fotos basado en un término de búsqueda.
class SearchPhotosEvent extends SearchEvent {
  final String query; // Término de búsqueda que se utilizará para buscar fotos.

  /// Constructor para SearchPhotosEvent que toma el término de búsqueda como argumento.
  const SearchPhotosEvent(this.query);

  /// Sobrescribe la propiedad props para incluir el término de búsqueda en la comparación.
  /// Esto permite que dos instancias de SearchPhotosEvent sean consideradas iguales si tienen el mismo término de búsqueda.
  @override
  List<Object> get props => [query];
}

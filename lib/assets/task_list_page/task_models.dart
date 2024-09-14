// lib/models/task_model.dart
class Task {
  String title; // Título de la tarea
  bool isCompleted; // Estado de la tarea (completada o no)

  // Constructor de la clase Task
  Task({required this.title, this.isCompleted = false});
}

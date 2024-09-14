// lib/providers/task_provider.dart
import 'package:flutter/material.dart';
import 'package:technical_challenge/assets/task_list_page/task_models.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = []; // Lista privada de tareas

  List<Task> get tasks => _tasks; // Para acceder a la lista de tareas desde otros widgets

  // Método para agregar una nueva tarea
  void addTask(String title) {
    _tasks.add(Task(title: title)); // Añade una nueva tarea a la lista
    notifyListeners();
  }

  // Método para eliminar una tarea por su índice
  void removeTask(int index) {
    _tasks.removeAt(index); // Elimina la tarea de la lista
    notifyListeners(); 
  }

  // Método para marcar/desmarcar una tarea como completada
  void toggleTaskCompletion(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted; // Cambia el estado de completado
    notifyListeners(); // Notifica a los widgets que deben actualizarse
  }
}

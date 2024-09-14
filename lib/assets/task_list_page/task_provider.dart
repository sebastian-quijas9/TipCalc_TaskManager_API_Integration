// lib/providers/task_provider.dart
import 'package:flutter/material.dart';
import 'package:technical_challenge/assets/task_list_page/task_models.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = []; // Lista privada de tareas.

  List<Task> get tasks => _tasks; // Lista completa de tareas.

  // Lista de tareas pendientes.
  List<Task> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList();

  // Lista de tareas completadas.
  List<Task> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  // Método para agregar una nueva tarea.
  void addTask(String title) {
    _tasks.add(Task(title: title)); // Añade una nueva tarea a la lista.
    notifyListeners(); // Notifica a los widgets que deben actualizarse.
  }

  // Método para eliminar una tarea por su índice.
  void removeTask(int index) {
    _tasks.removeAt(index); // Elimina la tarea de la lista.
    notifyListeners(); // Notifica a los widgets que deben actualizarse.
  }

  // Método para marcar/desmarcar una tarea como completada.
  void toggleTaskCompletion(int index) {
    _tasks[index].isCompleted =
        !_tasks[index].isCompleted; // Cambia el estado de completado.
    notifyListeners(); // Notifica a los widgets que deben actualizarse.
  }
}

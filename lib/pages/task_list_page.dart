import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'package:technical_challenge/assets/task_list_page/task_models.dart';
import 'package:technical_challenge/assets/task_list_page/task_provider.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtiene el TaskProvider para interactuar con la lista de tareas.
    final taskProvider = Provider.of<TaskProvider>(context);
    // Controlador para el campo de texto donde se ingresa una nueva tarea.
    final taskController = TextEditingController();

    return Column(
      children: [
        // Campo de texto para añadir una nueva tarea.
        Padding(
          padding: const EdgeInsets.all(
              16.0), // Espacio alrededor del campo de texto.
          child: TextField(
            controller: taskController, // Controlador del campo de texto.
            decoration: const InputDecoration(
              labelText: 'Nueva Tarea', // Etiqueta dentro del campo de texto.
            ),
          ),
        ),
        // Botón para agregar una nueva tarea.
        ElevatedButton(
          onPressed: () {
            // Si el campo de texto no está vacío, añade la tarea.
            if (taskController.text.isNotEmpty) {
              taskProvider.addTask(taskController
                  .text); // Añade la tarea a través del TaskProvider.
              taskController
                  .clear(); // Limpia el campo de texto después de añadir la tarea.
            }
          },
          child:
              const Text('Agregar Tarea'), // Texto que se muestra en el botón.
        ),
        // Expande el ListView para ocupar todo el espacio disponible.
        Expanded(
          child: ListView(
            children: [
              // Sección de tareas pendientes.
              ..._buildTaskSection(
                  context, 'Tareas', taskProvider.pendingTasks, false),

              // Sección de tareas completadas (solo si hay alguna completada).
              if (taskProvider.completedTasks.isNotEmpty)
                ..._buildTaskSection(
                    context, 'Finalizadas', taskProvider.completedTasks, true),
            ],
          ),
        ),
      ],
    );
  }

  // Método para construir una sección de la lista de tareas.
  List<Widget> _buildTaskSection(
      BuildContext context, String title, List<Task> tasks, bool completed) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return [
      // Título de la sección (Tareas o Tareas Completas).
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600]!,
          ),
        ),
      ),
      // Itera sobre cada tarea en la lista de tareas (pendientes o completadas).
      ...tasks.map((task) {
        final index = taskProvider.tasks
            .indexOf(task); // Encuentra el índice de la tarea actual.
        return PageTransitionSwitcher(
          duration:
              const Duration(milliseconds: 300), // Duración de la animación.
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            // Usa una transición compartida a lo largo del eje vertical.
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
          child: Dismissible(
            key: ValueKey(
                task.title), // Clave única basada en el título de la tarea.
            onDismissed: (direction) {
              taskProvider
                  .removeTask(index); // Elimina la tarea cuando se desliza.
            },
            background: Container(
              color: Colors.red, // Fondo rojo al deslizar para eliminar.
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(Icons.delete,
                  color: Color.fromARGB(255, 148, 4, 4)), // Icono de papelera.
            ),
            child: ListTile(
              title: Text(
                task.title,
                // Si la tarea está completada, se muestra con un texto tachado.
                style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration
                          .lineThrough // Texto tachado si la tarea está completada.
                      : TextDecoration
                          .none, // Texto normal si la tarea no está completada.
                  color: task.isCompleted
                      ? Colors.green
                      : Colors.black, // Verde si está completada, negro si no.
                ),
              ),
              // Checkbox para marcar la tarea como completada o no.
              leading: Checkbox(
                value:
                    task.isCompleted, // Estado del checkbox (completada o no).
                onChanged: (_) {
                  taskProvider.toggleTaskCompletion(
                      index); // Cambia el estado de la tarea.
                },
              ),
              // Botón para eliminar la tarea.
              trailing: IconButton(
                icon: const Icon(Icons.delete), // Icono de la papelera.
                onPressed: () => taskProvider
                    .removeTask(index), // Elimina la tarea al presionar.
              ),
            ),
          ),
        );
      }),
    ];
  }
}

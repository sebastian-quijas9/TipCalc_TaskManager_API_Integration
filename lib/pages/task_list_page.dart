import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_challenge/assets/task_list_page/task_provider.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final taskController = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: taskController,
            decoration: const InputDecoration(
              labelText: 'Nueva Tarea',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (taskController.text.isNotEmpty) {
              taskProvider.addTask(taskController.text);
              taskController.clear();
            }
          },
          child: const Text('Agregar Tarea'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) {
                    taskProvider.toggleTaskCompletion(index);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => taskProvider.removeTask(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

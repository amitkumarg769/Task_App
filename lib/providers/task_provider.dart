import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:todoapp/db/database_helper.dart';
import 'package:todoapp/models/task_model.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasksData = await DatabaseHelper.instance.fetchTasks();
    state = tasksData
        .map((task) => Task(
              id: task['id'],
              title: task['title'],
              isCompleted: task['isCompleted'] == 1,
            ))
        .toList();
  }

  Future<void> addTask(Task task) async {
    await DatabaseHelper.instance.addTask({
      'id': task.id,
      'title': task.title,
      'isCompleted': task.isCompleted ? 1 : 0,
    });
    state = [...state, task];
  }

  Future<void> updateTask(Task updatedTask) async {
    await DatabaseHelper.instance.updateTask({
      'title': updatedTask.title,
      'isCompleted': updatedTask.isCompleted ? 1 : 0,
    }, updatedTask.id);
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task
    ];
  }

  Future<void> deleteTask(int id) async {
    await DatabaseHelper.instance.deleteTask(id);
    state = state.where((task) => task.id != id).toList();
  }
}

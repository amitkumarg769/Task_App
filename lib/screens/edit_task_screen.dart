import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/providers/task_provider.dart';

class EditTaskScreen extends ConsumerStatefulWidget {
  const EditTaskScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  late TextEditingController _controller;
  Task? task;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch the passed arguments (task) if editing
    task = ModalRoute.of(context)?.settings.arguments as Task?;
    _controller = TextEditingController(text: task?.title ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                final title = _controller.text.trim();
                if (title.isNotEmpty) {
                  final newTask = Task(
                    id: task?.id ?? DateTime.now().millisecondsSinceEpoch,
                    title: title,
                    isCompleted: task?.isCompleted ?? false,
                  );

                  final taskNotifier = ref.read(taskProvider.notifier);
                  if (task == null) {
                    // Adding a new task
                    taskNotifier.addTask(newTask);
                  } else {
                    // Updating an existing task
                    taskNotifier.updateTask(newTask);
                  }

                  Navigator.pop(context); // Go back to the Task List screen
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}



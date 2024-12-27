import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/models/task_model.dart';

class TaskTile extends ConsumerWidget {
  final Task task;

  const TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          //decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      
      onTap: () {
        // Navigate to the Add/Edit Task Screen (Edit mode)
        Navigator.pushNamed(context, '/EditTask', arguments: task);
      },
      
    );
  }
}

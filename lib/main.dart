import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/screens/edit_task_screen.dart';
import 'package:todoapp/screens/task_list_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   runApp(const ProviderScope(child: MyApp()));
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final appDir = await getApplicationDocumentsDirectory();
//   Hive.init(appDir.path);
//   runApp(const ProviderScope(child: MyApp()));
// }

void main() async{
    WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter()); // Register Hive Task Adapter
  runApp(
      const ProviderScope(child: MyApp())); // Wrap the app with ProviderScope
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const TaskListScreen(),
        '/EditTask': (context) => const EditTaskScreen(),
      },
    );
  }
}

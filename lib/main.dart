import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/modules/app/models/application.dart';
import 'package:todo/modules/tasks/models/task.dart';
import 'package:todo/modules/tasks/models/tasks.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<Tasks>(
            create: (_) => Tasks(),
          ),
        ],
        child: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  final _textController = TextEditingController();

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('todos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textController,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(hintText: 'What needs to be done?'),
              onSubmitted: (value) {
                Provider.of<Tasks>(context, listen: false).addTask(
                  Task(isCompleted: false, description: value),
                );
                _textController.text = '';
              },
            ),
            Expanded(
              child: Consumer<Tasks>(builder: (context, tasks, child) {
                return ListView.builder(
                  itemCount: tasks.tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks.tasks[index];
                    return CheckboxListTile(
                      value: task.isCompleted,
                      title: Text(task.description),
                      onChanged: (value) {
                        tasks.setCompleteTask(task, value ?? false);
                      },
                    );
                  },
                );
              }),
            ),
            Consumer<Tasks>(
              builder: (context, tasks, child) {
                return ButtonBar(
                  children: [
                    Text('${tasks.tasksToComplete} item left'),
                    ElevatedButton(
                        child: Text('All'),
                        onPressed: () => tasks.setTaskFilter(TaskFilter.all)),
                    ElevatedButton(
                        child: Text('Active'),
                        onPressed: () =>
                            tasks.setTaskFilter(TaskFilter.active)),
                    ElevatedButton(
                        child: Text('Completed'),
                        onPressed: () =>
                            tasks.setTaskFilter(TaskFilter.completed))
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

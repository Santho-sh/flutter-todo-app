import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main.dart';

class ActiveTodos extends StatelessWidget {
  const ActiveTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        return Text(appState.newTodo);
        // Todos list
        // Completed toggle
        // Add new todo button
      },
    );
  }
}

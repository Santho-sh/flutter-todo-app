import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class CompletedTodos extends StatelessWidget {
  const CompletedTodos({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    // If Todo list is empty
    if (appState.completedTodos.isEmpty) {
      return const Center(
        child: Text('No Todos'),
      );
    }

    return ListView(
      children: [
        for (var completedTodo in appState.completedTodos)
          Todo(
            todo: completedTodo,
          )
      ],
    );
  }
}

class Todo extends StatelessWidget {
  const Todo({super.key, required this.todo});

  final String todo;

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    return ListTile(
      leading: const Icon(Icons.label_important),
      title: Row(
        children: [
          Expanded(child: Text(todo)),
          // Mark Uncomplete button
          ElevatedButton(
            onPressed: () => appState.markUncomplete(todo),
            child: const Icon(Icons.remove_circle_outline),
          ),
          // Delete button
          ElevatedButton(
            onPressed: () => appState.deleteTodo(todo),
            child: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
    );
  }
}

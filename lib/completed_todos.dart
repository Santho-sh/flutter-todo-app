import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'delete_todo.dart';
import 'app_state.dart';

class CompletedTodos extends StatelessWidget {
  const CompletedTodos({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    // If Todo list is empty
    if (appState.completedTodos.isEmpty) {
      return const Center(
        child: Text('No Completed Todos'),
      );
    }

    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Completed Tasks",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
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
    final ColorScheme colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: const Icon(Icons.check),
      title: Row(
        children: [
          Expanded(
            child: Text(
              todo,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          // Mark Uncomplete button
          Row(
            children: [
              IconButton(
                onPressed: () => appState.markUncomplete(todo),
                icon: const Icon(Icons.remove_circle_outline),
                style: IconButton.styleFrom(
                  iconSize: 20,
                  foregroundColor: colors.onSecondaryContainer,
                  backgroundColor: colors.secondaryContainer,
                  disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
                  hoverColor: colors.onSecondaryContainer.withOpacity(0.08),
                  focusColor: colors.onSecondaryContainer.withOpacity(0.12),
                  highlightColor: colors.onSecondaryContainer.withOpacity(0.12),
                ),
              ),
              const SizedBox(width: 10),
              // Delete button
              DeleteTodo(todo: todo),
            ],
          ),
        ],
      ),
    );
  }
}

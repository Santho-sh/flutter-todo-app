import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_todo.dart';
import 'app_state.dart';

class ActiveTodos extends StatelessWidget {
  const ActiveTodos({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    // If Todo list is empty
    if (appState.activeTodos.isEmpty) {
      return Center(
        child: Column(
          children: const [
            Expanded(
              child: Center(
                child: Text('No Todos'),
              ),
            ),

            // Add todo button
            Padding(
              padding: EdgeInsets.all(8.0),
              child: AddTodo(),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
            child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Tasks",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            for (var activeTodo in appState.activeTodos)
              Todo(
                todo: activeTodo,
              )
          ],
        )),

        // Add todo button
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: AddTodo(),
        ),
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
      leading: const Icon(Icons.adjust),
      title: Row(
        children: [
          Expanded(
              child: Text(
            todo,
            style: const TextStyle(fontSize: 20),
          )),
          IconButton(
            onPressed: () => appState.markComplete(todo),
            icon: const Icon(Icons.check),
            style: IconButton.styleFrom(
              iconSize: 20,
              foregroundColor: colors.onSecondaryContainer,
              backgroundColor: colors.secondaryContainer,
              disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
              hoverColor: colors.onSecondaryContainer.withOpacity(0.08),
              focusColor: colors.onSecondaryContainer.withOpacity(0.12),
              highlightColor: colors.onSecondaryContainer.withOpacity(0.12),
            ),
          )
        ],
      ),
    );
  }
}

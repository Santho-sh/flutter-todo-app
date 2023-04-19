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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Completed Todos",
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

    return ListTile(
      leading: const Icon(Icons.check_box_outlined),
      title: Row(
        children: [
          Expanded(child: Text(todo)),
          // Mark Uncomplete button
          ElevatedButton(
            onPressed: () => appState.markUncomplete(todo),
            child: const Icon(Icons.remove_circle_outline),
          ),
          // Delete button
          DeleteTodo(todo: todo),
        ],
      ),
    );
  }
}

class DeleteTodo extends StatelessWidget {
  const DeleteTodo({super.key, required this.todo});
  final String todo;

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    return ElevatedButton(
      child: const Icon(Icons.delete_outline_rounded),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: const Text("Confirm Delete?"),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => {
                    appState.deleteTodo(todo),
                    Navigator.pop(context, false),
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

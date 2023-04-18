import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main.dart';

class ActiveTodos extends StatelessWidget {
  const ActiveTodos({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    // If Todo list is empty
    if (appState.activeTodos.isEmpty) {
      return Center(
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Text('No Todos'),
              ),
            ),
            // Add todo button

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
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
            for (var todo in appState.activeTodos)
              ListTile(
                leading: const Icon(Icons.favorite),
                title: Text(todo),
              )
          ],
        )),
        // Add todo button
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
    // Todos list
    // Completed toggle
  }
}

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

    return ListTile(
      leading: const Icon(Icons.label_important),
      title: Row(
        children: [
          Expanded(child: Text(todo)),
          ElevatedButton(
            onPressed: () => appState.markComplete(todo),
            child: const Icon(Icons.check),
          )
        ],
      ),
    );
  }
}

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    return ElevatedButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // variable to store input textfield data
            var myController = TextEditingController();

            return AlertDialog(
              scrollable: true,
              title: const Text("New Todo"),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: myController,
                        decoration: const InputDecoration(
                          labelText: "Todo",
                          icon: Icon(Icons.add_box_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  child: const Text("Add"),
                  onPressed: () {
                    appState.addTodo(myController.text);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

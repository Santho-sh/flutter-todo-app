import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    return FilledButton(
      style: ElevatedButton.styleFrom(fixedSize: const Size(70, 40)),
      child: const Icon(Icons.add_rounded),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // variable to store input textfield data
            var myController = TextEditingController();

            return AlertDialog(
              scrollable: true,
              title: const Text("New Task"),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: myController,
                        decoration: const InputDecoration(
                          labelText: "Task",
                          icon: Icon(Icons.add_circle_outline),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                FilledButton.tonal(
                  child: const Text("Add"),
                  onPressed: () {
                    int added = appState.addTodo(myController.text);
                    Navigator.pop(context, false);
                    if (added == 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: colors.primaryContainer,
                          duration: const Duration(seconds: 1),
                          content: Text(
                            'New Task Added',
                            style: TextStyle(color: colors.onPrimaryContainer),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: colors.errorContainer,
                          duration: const Duration(seconds: 1),
                          content: Text(
                            'Enter Valid Task',
                            style: TextStyle(color: colors.onErrorContainer),
                          ),
                        ),
                      );
                    }
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

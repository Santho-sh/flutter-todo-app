import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class CompletedTodos extends StatelessWidget {
  const CompletedTodos({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    return Text(appState.newTodo);
  }
}

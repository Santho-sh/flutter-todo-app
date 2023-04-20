import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  late SharedPreferences prefs;
  var activeTodos = <String>[];
  var completedTodos = <String>[];

  AppState() {
    initState();
  }

  void initState() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList("activeTodos") != null) {
      activeTodos = prefs.getStringList("activeTodos")!;
    }
    if (prefs.getStringList("completedTodos") != null) {
      completedTodos = prefs.getStringList("completedTodos")!;
    }
  }

  int addTodo(String todo) {
    if (todo.trim() != "") {
      activeTodos.add(todo.trim());
      prefs.setStringList("activeTodos", activeTodos);
      notifyListeners();
      return 1;
    }
    return 0;
  }

  void removeTodo(String todo) {
    if (todo.contains(todo)) {
      activeTodos.remove(todo);
      prefs.setStringList("activeTodos", activeTodos);
      notifyListeners();
    }
  }

  void deleteTodo(String todo) {
    if (activeTodos.contains(todo)) {
      activeTodos.remove(todo);
      prefs.setStringList("activeTodos", activeTodos);
      notifyListeners();
    } else if (completedTodos.contains(todo)) {
      completedTodos.remove(todo);
      prefs.setStringList("completedTodos", completedTodos);
      notifyListeners();
    }
  }

  void markComplete(todo) {
    if (activeTodos.contains(todo)) {
      completedTodos.add(todo);
      activeTodos.remove(todo);

      prefs.setStringList("activeTodos", activeTodos);
      prefs.setStringList("completedTodos", completedTodos);

      notifyListeners();
    }
  }

  void markUncomplete(todo) {
    if (completedTodos.contains(todo)) {
      activeTodos.add(todo);
      completedTodos.remove(todo);

      prefs.setStringList("activeTodos", activeTodos);
      prefs.setStringList("completedTodos", completedTodos);

      notifyListeners();
    }
  }
}

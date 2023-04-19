import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'completed_todos.dart';
import 'active_todos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const HomePage(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  var newTodo = 'newone';
  var activeTodos = <String>['Hello', 'Test', 'Tata', 'Test2'];
  var completedTodos = <String>['Bye', 'Completed'];

  void addTodo(String todo) {
    activeTodos.add(todo);
    notifyListeners();
  }

  void removeTodo(String todo) {
    if (todo.contains(todo)) {
      activeTodos.remove(todo);
      notifyListeners();
    }
  }

  void deleteTodo(String todo) {
    if (activeTodos.contains(todo)) {
      activeTodos.remove(todo);
      notifyListeners();
    } else if (completedTodos.contains(todo)) {
      completedTodos.remove(todo);
      notifyListeners();
    }
  }

  void markComplete(todo) {
    if (activeTodos.contains(todo)) {
      completedTodos.add(todo);
      activeTodos.remove(todo);
      notifyListeners();
    }
  }

  void markUncomplete(todo) {
    if (completedTodos.contains(todo)) {
      activeTodos.add(todo);
      completedTodos.remove(todo);
      notifyListeners();
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (_selectedPage) {
      case 0:
        page = const ActiveTodos();
        break;
      case 1:
        page = const CompletedTodos();
        break;
      default:
        throw UnimplementedError('no widget for $_selectedPage');
    }

    void itemTapped(int index) {
      setState(() {
        _selectedPage = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        leading: const Icon(Icons.toll_outlined),
      ),
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.outlined_flag_sharp),
            label: 'Completed',
          ),
        ],
        currentIndex: _selectedPage,
        selectedItemColor: Colors.amber[900],
        onTap: itemTapped,
      ),
    );
  }
}

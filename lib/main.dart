import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

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
        theme: _buildTheme(Brightness.light),
        home: const HomePage(),
      ),
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
  );
}

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
        backgroundColor: const Color.fromRGBO(255, 147, 85, 1),
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

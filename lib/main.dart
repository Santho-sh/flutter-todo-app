import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'completed_todos.dart';
import 'active_todos.dart';
import 'app_state.dart';

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
        title: 'Tasks',
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
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  );
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
          title: const Text('ToDo'), leading: const Icon(Icons.toll_outlined)),
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant_photo_rounded),
            label: 'Completed',
          ),
        ],
        currentIndex: _selectedPage,
        onTap: itemTapped,
      ),
    );
  }
}

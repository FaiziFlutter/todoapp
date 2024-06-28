import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens.dart/tabs.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 131, 57, 0)),
  textTheme: GoogleFonts.latoTextTheme(),
  useMaterial3: true,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: theme,
      home: const TabScreen(),
    );
  }
}

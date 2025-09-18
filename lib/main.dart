import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FunChefApp());
}

class FunChefApp extends StatelessWidget {
  const FunChefApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FunChef',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.orange.shade50,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

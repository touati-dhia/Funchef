import 'package:flutter/material.dart';
import 'recipe_input_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: const Text("FunChef"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
          ),
          child: const Text("Start Cooking!", style: TextStyle(fontSize: 22)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RecipeInputScreen()),
            );
          },
        ),
      ),
    );
  }
}

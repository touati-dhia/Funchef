import 'package:flutter/material.dart';
import 'free_recipes_screen.dart';
import 'recipe_input_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 40),
                  Text('🍳 FunChef',
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.orange.shade800)),
                  const SizedBox(height: 12),
                  Text('Turn any recipe into a fun, toddler-friendly step-by-step guide with illustrations.',
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade800), textAlign: TextAlign.center),
                ],
              ),
              Expanded(child: Image.asset('assets/placeholder.png', fit: BoxFit.contain)),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const FreeRecipesScreen(jsonUrl: 'https://yourcdn.com/free_recipes.json'),
                          ),
                        );
                      },
                      child: const Text('Browse Free Recipes', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const RecipeInputScreen()));
                      },
                      child: const Text('Create Your Recipe', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

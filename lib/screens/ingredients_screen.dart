import 'dart:io';
import 'package:flutter/material.dart';
import '../models/ingredient_model.dart';
import '../models/recipe_model.dart';
import '../services/ingredient_icon_service.dart';
import 'recipe_step_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IngredientsScreen extends StatelessWidget {
  final List<IngredientModel> ingredients;
  final List<RecipeStepModel> steps;

  const IngredientsScreen({super.key, required this.ingredients, required this.steps});

  Widget _buildImage(String? url, double size) {
    if (url == null) return Icon(Icons.restaurant, size: size, color: Colors.orange);
    if (url.startsWith('http') && url.endsWith('.svg')) {
      return SizedBox(width: size, height: size, child: SvgPicture.network(url));
    }
    if (url.startsWith('http')) {
      return CachedNetworkImage(imageUrl: url, width: size, height: size, placeholder: (_, __) => const CircularProgressIndicator());
    }
    // assume local file path
    return Image.file(File(url), width: size, height: size, fit: BoxFit.contain);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingredients')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Ingredients', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: ingredients.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final ing = ingredients[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildImage(ing.imageUrl, 80),
                      const SizedBox(height: 8),
                      Text(ing.name, style: const TextStyle(fontSize: 18)),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeStepScreen(steps: steps)));
              },
              child: const Text('Start Cooking'),
            ),
          ],
        ),
      ),
    );
  }
}

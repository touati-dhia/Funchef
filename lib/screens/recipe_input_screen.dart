import 'dart:io';
import 'package:flutter/material.dart';
import '../services/openai_service.dart';
import '../services/stability_service.dart';
import '../services/ingredient_icon_service.dart';
import '../models/ingredient_model.dart';
import '../models/recipe_model.dart';
import 'ingredients_screen.dart';

class RecipeInputScreen extends StatefulWidget {
  const RecipeInputScreen({super.key});

  @override
  State<RecipeInputScreen> createState() => _RecipeInputScreenState();
}

class _RecipeInputScreenState extends State<RecipeInputScreen> {
  final TextEditingController _recipeController = TextEditingController();
  final TextEditingController _openAIController = TextEditingController();
  final TextEditingController _stabilityController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _generate() async {
    final recipeText = _recipeController.text.trim();
    final openaiKey = _openAIController.text.trim();
    final stabilityKey = _stabilityController.text.trim();

    if (recipeText.isEmpty) {
      setState(() => _error = 'Please paste a recipe first.');
      return;
    }
    if (openaiKey.isEmpty) {
      setState(() => _error = 'Please provide your OpenAI API key to generate steps.');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final openai = OpenAIService(openaiKey);
      final structured = await openai.generateStructuredRecipe(recipeText);

      final ingList = <IngredientModel>[];
      final stepList = <RecipeStepModel>[];

      // Ingredients: prefer icon map URLs; otherwise optionally generate with Stability
      final stability = stabilityKey.isNotEmpty ? StabilityService(stabilityKey) : null;

      int ingIndex = 0;
      for (final ing in structured['ingredients'] as List<dynamic>) {
        final name = (ing['name'] as String).trim();
        String? imageUrl;

        // try known icon map
        final mapUrl = ingredientIconMap[name.toLowerCase()];
        if (mapUrl != null) {
          imageUrl = mapUrl;
        } else if (stability != null) {
          // generate a simple ingredient illustration
          final filename = 'ingredient_${DateTime.now().millisecondsSinceEpoch}_$ingIndex';
          final path = await stability.generateAndSaveImage('Cute cartoon-style illustration of $name, toddler-friendly', filename);
          imageUrl = path;
        } else {
          // fallback to placeholder remote image
          imageUrl = 'https://via.placeholder.com/256?text=${Uri.encodeComponent(name)}';
        }

        ingList.add(IngredientModel(name: name, imageUrl: imageUrl));
        ingIndex++;
      }

      // Steps: generate images with Stability if available
      int stepIndex = 0;
      for (final s in structured['steps'] as List<dynamic>) {
        final instruction = (s['instruction'] as String).trim();
        String? imageUrl;
        if (stability != null) {
          final filename = 'step_${DateTime.now().millisecondsSinceEpoch}_$stepIndex';
          final path = await stability.generateAndSaveImage('Cute cartoon-style illustration of: $instruction, toddler-friendly', filename);
          imageUrl = path;
        } else {
          imageUrl = 'https://via.placeholder.com/512?text=${Uri.encodeComponent(instruction.substring(0, instruction.length.clamp(0, 20)))}';
        }
        stepList.add(RecipeStepModel(instruction: instruction, imageUrl: imageUrl));
        stepIndex++;
      }

      if (!mounted) return;
      setState(() => _loading = false);

      final recipe = RecipeModel(title: 'Custom Recipe', ingredients: ingList, steps: stepList);

      Navigator.push(context, MaterialPageRoute(builder: (_) => IngredientsScreen(ingredients: recipe.ingredients, steps: recipe.steps)));
    } catch (e) {
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Your Recipe')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _openAIController,
              decoration: const InputDecoration(labelText: 'OpenAI API Key', hintText: 'sk-...'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _stabilityController,
              decoration: const InputDecoration(labelText: 'Stability API Key (optional)', hintText: 'sk-...'),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _recipeController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Paste your recipe here...'),
              ),
            ),
            const SizedBox(height: 12),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            _loading ? const CircularProgressIndicator() : SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: _generate, child: const Text('Generate')),
            ),
          ],
        ),
      ),
    );
  }
}

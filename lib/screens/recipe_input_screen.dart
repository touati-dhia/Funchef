import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/recipe_step.dart';
import 'recipe_step_screen.dart';

class RecipeInputScreen extends StatefulWidget {
  const RecipeInputScreen({super.key});

  @override
  State<RecipeInputScreen> createState() => _RecipeInputScreenState();
}

class _RecipeInputScreenState extends State<RecipeInputScreen> {
  final TextEditingController _controller = TextEditingController();

  Recipe dummyRecipe = Recipe(
    title: "Banana Bread",
    steps: [
      RecipeStep(
        instruction: "Mash the bananas!",
        lottieAsset: "assets/lottie/banana.json",
        soundAsset: "assets/sounds/mash.mp3",
      ),
      RecipeStep(
        instruction: "Crack the eggs!",
        lottieAsset: "assets/lottie/egg.json",
        soundAsset: "assets/sounds/crack.mp3",
      ),
      RecipeStep(
        instruction: "Mix everything together!",
        lottieAsset: "assets/lottie/mix.json",
        soundAsset: "assets/sounds/mix.mp3",
      ),
      RecipeStep(
        instruction: "Bake it in the oven!",
        lottieAsset: "assets/lottie/oven.json",
        soundAsset: "assets/sounds/ding.mp3",
      ),
    ],
  );

  void _startRecipe() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RecipeStepScreen(steps: dummyRecipe.steps)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose or Paste Recipe")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Paste your recipe here...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: _startRecipe,
              child: const Text("Generate Recipe", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

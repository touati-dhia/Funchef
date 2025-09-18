import 'package:flutter/material.dart';
import '../services/free_recipe_service.dart';
import '../services/ingredient_icon_service.dart';
import '../models/ingredient_model.dart';
import '../models/recipe_model.dart';
import 'ingredients_screen.dart';

class FreeRecipesScreen extends StatefulWidget {
  final String jsonUrl;
  const FreeRecipesScreen({super.key, required this.jsonUrl});

  @override
  State<FreeRecipesScreen> createState() => _FreeRecipesScreenState();
}

class _FreeRecipesScreenState extends State<FreeRecipesScreen> {
  late Future<List<dynamic>> _recipesFuture;
  final _serviceKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _recipesFuture = FreeRecipeService(jsonUrl: widget.jsonUrl).fetchFreeRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Free Recipes')),
      body: FutureBuilder<List<dynamic>>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.isEmpty) return const Center(child: Text('No free recipes available.'));

          final recipes = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: recipes.length,
            itemBuilder: (_, i) {
              final recipe = RecipeModel.fromJson(recipes[i] as Map<String, dynamic>);
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(recipe.title, style: const TextStyle(fontSize: 20)),
                  subtitle: Text('${recipe.steps.length} steps'),
                  leading: IngredientIcon(ingredient: recipe.ingredients.isNotEmpty ? recipe.ingredients[0].name : 'food', size: 50),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => IngredientsScreen(ingredients: recipe.ingredients, steps: recipe.steps),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'recipe_step.dart';

class Recipe {
  final String title;
  final List<Ingredient> ingredients;
  final List<RecipeStep> steps;

  Recipe({required this.title, required this.ingredients, required this.steps});
}

class Ingredient {
  final String name;
  final String imageUrl;

  Ingredient({required this.name, required this.imageUrl});
}
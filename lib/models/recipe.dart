import 'recipe_step.dart';

class Recipe {
  final String title;
  final List<RecipeStep> steps;

  Recipe({required this.title, required this.steps});
}

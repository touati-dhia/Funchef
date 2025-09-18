import 'ingredient_model.dart';

class RecipeStepModel {
  final String instruction;
  final String? imageUrl; // network or local path

  RecipeStepModel({required this.instruction, this.imageUrl});

  factory RecipeStepModel.fromJson(Map<String, dynamic> json) => RecipeStepModel(
        instruction: json['instruction'] as String,
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'instruction': instruction,
        'imageUrl': imageUrl,
      };
}

class RecipeModel {
  final String title;
  final List<IngredientModel> ingredients;
  final List<RecipeStepModel> steps;

  RecipeModel({required this.title, required this.ingredients, required this.steps});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    final ings = (json['ingredients'] as List<dynamic>).map((e) => IngredientModel.fromJson(e as Map<String, dynamic>)).toList();
    final steps = (json['steps'] as List<dynamic>).map((e) => RecipeStepModel.fromJson(e as Map<String, dynamic>)).toList();
    return RecipeModel(title: json['title'] as String, ingredients: ings, steps: steps);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'ingredients': ingredients.map((e) => e.toJson()).toList(),
        'steps': steps.map((s) => s.toJson()).toList(),
      };
}

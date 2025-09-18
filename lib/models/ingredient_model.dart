class IngredientModel {
  final String name;
  final String? imageUrl; // may be network URL or local file path

  IngredientModel({required this.name, this.imageUrl});

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
      };
}

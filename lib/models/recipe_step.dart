class RecipeStep {
  final String instruction;
  final String? imageUrl;
  final String? lottieAsset;
  final String? soundAsset;

  RecipeStep({
    required this.instruction,
    this.imageUrl,
    this.lottieAsset,
    this.soundAsset,
  });
}

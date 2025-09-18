import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A small mapping of common ingredient names to icon URLs (svg/png).
/// You can extend this or load it from remote JSON in production.
const ingredientIconMap = {
  'banana': 'https://api.iconify.design/noto:banana.svg',
  'flour': 'https://api.iconify.design/noto:baguette-bread.svg',
  'egg': 'https://api.iconify.design/noto:egg.svg',
  'milk': 'https://api.iconify.design/noto:glass-of-milk.svg',
  'butter': 'https://api.iconify.design/noto:butter.svg',
};

class IngredientIcon extends StatelessWidget {
  final String ingredient;
  final double size;
  const IngredientIcon({super.key, required this.ingredient, this.size = 64});

  @override
  Widget build(BuildContext context) {
    final url = ingredientIconMap[ingredient.toLowerCase()];
    if (url == null) return Icon(Icons.restaurant, size: size, color: Colors.orange);

    // simple SVG detection
    if (url.endsWith('.svg')) {
      return SizedBox(
        width: size,
        height: size,
        child: SvgPicture.network(url, placeholderBuilder: (context) => const CircularProgressIndicator()),
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      width: size,
      height: size,
      placeholder: (c, s) => const CircularProgressIndicator(),
      errorWidget: (c, s, e) => Icon(Icons.broken_image, size: size),
    );
  }
}

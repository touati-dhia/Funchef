import 'dart:io';
import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecipeStepScreen extends StatefulWidget {
  final List<RecipeStepModel> steps;
  const RecipeStepScreen({super.key, required this.steps});

  @override
  State<RecipeStepScreen> createState() => _RecipeStepScreenState();
}

class _RecipeStepScreenState extends State<RecipeStepScreen> {
  int current = 0;

  void next() {
    if (current < widget.steps.length - 1) {
      setState(() => current++);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You finished the recipe! 🎉')));
    }
  }

  Widget _buildImage(String? url) {
    if (url == null) return const Icon(Icons.image_not_supported, size: 120);
    if (url.startsWith('http') && url.endsWith('.svg')) return SizedBox(height: 240, child: SvgPicture.network(url));
    if (url.startsWith('http')) return CachedNetworkImage(imageUrl: url, height: 240, placeholder: (_, __) => const CircularProgressIndicator());
    return Image.file(File(url), height: 240, fit: BoxFit.contain);
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.steps[current];
    return Scaffold(
      appBar: AppBar(title: Text('Step ${current + 1}/${widget.steps.length}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: Center(child: _buildImage(step.imageUrl))),
            const SizedBox(height: 12),
            Text(step.instruction, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: next,
              style: ElevatedButton.styleFrom(minimumSize: const Size(140, 44)),
              child: Text(current < widget.steps.length - 1 ? 'Next' : 'Finish'),
            ),
          ],
        ),
      ),
    );
  }
}

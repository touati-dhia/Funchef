import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/recipe_step.dart';
import 'recipe_finished_screen.dart';

class RecipeStepScreen extends StatefulWidget {
  final List<RecipeStep> steps;

  const RecipeStepScreen({super.key, required this.steps});

  @override
  _RecipeStepScreenState createState() => _RecipeStepScreenState();
}

class _RecipeStepScreenState extends State<RecipeStepScreen> {
  int currentStep = 0;
  final AudioPlayer _player = AudioPlayer();

  void _playSound(String? soundAsset) async {
    if (soundAsset != null) {
      await _player.stop();
      await _player.play(AssetSource(soundAsset));
    }
  }

  void nextStep() {
    _playSound(widget.steps[currentStep].soundAsset);

    if (currentStep < widget.steps.length - 1) {
      setState(() {
        currentStep++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RecipeFinishedScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.steps[currentStep];

    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text("Step ${currentStep + 1} of ${widget.steps.length}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            Expanded(
              child: GestureDetector(
                onTap: () => _playSound(step.soundAsset),
                child: Center(
                  child: step.lottieAsset != null
                      ? Lottie.asset(step.lottieAsset!, repeat: true)
                      : (step.imageUrl != null
                          ? Image.network(step.imageUrl!, fit: BoxFit.contain)
                          : const Icon(Icons.image_not_supported, size: 100)),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(step.instruction,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
            ),

            ElevatedButton(
              onPressed: nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(140, 44), // ✅ fixed width & height
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                currentStep == widget.steps.length - 1 ? "Finish!" : "Next",
                style: const TextStyle(fontSize: 20),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

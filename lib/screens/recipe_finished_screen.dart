import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class RecipeFinishedScreen extends StatefulWidget {
  const RecipeFinishedScreen({super.key});

  @override
  State<RecipeFinishedScreen> createState() => _RecipeFinishedScreenState();
}

class _RecipeFinishedScreenState extends State<RecipeFinishedScreen> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 3));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("🎉 All Done!",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("Back to Home", style: TextStyle(fontSize: 22)),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controller,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
            ),
          ),
        ],
      ),
    );
  }
}

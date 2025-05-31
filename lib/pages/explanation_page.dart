import 'package:flutter/material.dart';

class ExplanationPage extends StatelessWidget {
  const ExplanationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ich bin eine Erklärseite."),
      ),
      body: const Center(
        child: Text("Willkommen + Erklärung"),
      ),
    );
  }
}

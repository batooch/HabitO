import 'package:flutter/material.dart';

class CreateHabitPage extends StatelessWidget {
  const CreateHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ich bin eine Seite um neue Gewohnheiten zu erstellen."),
      ),
      body: Text("Erstelle eine neue Gewohnheit lossssss."),
    );
  }
}

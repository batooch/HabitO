import 'package:flutter/material.dart';

class CreateHabitPage extends StatelessWidget {
  const CreateHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Was möchtest du zur Gewohnheit machen?"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Gewohnheit erstellen",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
                onPressed: () {

                },
                child: const Text("Erstellen"))
          ],
        ),


      )
    );
  }
}

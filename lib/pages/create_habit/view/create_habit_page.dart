import 'package:flutter/material.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {

  final TextEditingController _habitController = TextEditingController();

  @override
  void dispose() {
    _habitController.dispose();
    super.dispose();
  }

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
              controller: _habitController,
              decoration: const InputDecoration(
                labelText: "Gewohnheit erstellen",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
                onPressed: () {
                  print(_habitController.text);
                },
                child: const Text("Erstellen"))
          ],
        ),


      )
    );
  }
}

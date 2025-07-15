import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../controllers/habit_list_controller.dart';

class HabitSuggestions extends StatelessWidget {
  const HabitSuggestions({super.key});

  Future<List<String>> fetchSuggestions() async {
    final controller = HabitListController();

    final habits = await controller.fetchHabits();
    final titles = habits.map((h) => h.title).toList();

    final url = Uri.parse(
      "https://66c8-2a02-8071-8282-e060-f029-45e-d26a-e11a.ngrok-free.app/chat/habits",
    );
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(titles),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception('Failed to load suggestions: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: fetchSuggestions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Fehler: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Keine Vorschläge gefunden.');
        }

        final habits = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: habits.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                title: Text(habits[index], style: TextStyle(fontSize: 16)),
              ),
            );
          },
        );
      },
    );
  }
}

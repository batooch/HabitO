import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HabitSuggestions extends StatelessWidget {
  const HabitSuggestions({super.key});

  Future<List<String>> fetchSuggestions() async {
    final url = Uri.parse(
        "https://c926-2a01-599-b07-11b3-7096-9ff8-5447-c6.ngrok-free.app/chat/habits");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(["wasser trinken"]),
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
          return const CircularProgressIndicator();
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
                    horizontal: 16, vertical: 8),
                title: Text(
                  habits[index],
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class OriService {
  final _baseUrl = 'https://habit-o-backend-98404024318.europe-west1.run.app';

  Future<List<String>> fetchSuggestions(List<String> titles) async {
    final url = Uri.parse('$_baseUrl/chat/habits');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(titles),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception('Failed to load suggestions: ${response.statusCode}');
    }
  }
}

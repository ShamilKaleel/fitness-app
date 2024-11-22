import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exercise.dart';

class ApiService {
  static const String _baseUrl = 'https://exercisedb.p.rapidapi.com';
  static const Map<String, String> _headers = {
    'x-rapidapi-key': '5f3287a535msh4f40f616472d57fp18b4a9jsn6f3883b64326',
    'x-rapidapi-host': 'exercisedb.p.rapidapi.com',
  };

  static Future<List<Exercise>> fetchExercises(String bodyPart) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/exercises/bodyPart/$bodyPart?limit=10&offset=0'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => Exercise.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load exercises for $bodyPart');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class TMDbService {
  final String apiKey = dotenv.env['TMDB_API_KEY'] ?? '';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    }
    else {
      throw Exception('Failed to load movies');
    }
  }
}

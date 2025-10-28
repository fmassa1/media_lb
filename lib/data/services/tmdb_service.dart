import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:media_lb/data/models/tv_show.dart';
import '../models/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import 'dart:io';


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

  Future<Movie> fetchMovieDetails(int movieId) async {

    final response = await http.get(
      Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey&append_to_response=credits,videos,recommendations,reviews,images',),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<TVShow>> getPopularTV() async {
    final response = await http.get(
      Uri.parse('$baseUrl/tv/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((json) => TVShow.fromJson(json)).toList();
    }
    else {
      throw Exception('Failed to load movies');
    }
  }
}

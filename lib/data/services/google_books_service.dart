import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/books.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleBooksService {
  final String apiKey = dotenv.env['GOOGLE_BOOKS_KEY'] ?? '';
  final String baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  Future<List<Book>> getPopularBooks({String query = 'red rising'}) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$query&orderBy=relevance&maxResults=20&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List items = data['items'] ?? [];
      return items.map((json) => Book.fromJson(json['volumeInfo'])).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}

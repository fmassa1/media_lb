import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/services/google_books_service.dart';
import '../data/models/books.dart';

final googleBooksServiceProvider = Provider((ref) => GoogleBooksService());

final popularBooksProvider = FutureProvider<List<Book>>((ref) async {
  final service = ref.watch(googleBooksServiceProvider);
  return service.getPopularBooks();
});

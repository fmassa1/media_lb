import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/movie.dart';
import '../data/services/tmdb_service.dart';

final tmdbServiceProvider = Provider((ref) => TMDbService());

final popularMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final service = ref.read(tmdbServiceProvider);
  return service.getPopularMovies();
});

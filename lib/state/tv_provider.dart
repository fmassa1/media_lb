import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/tv_show.dart';
import '../data/services/tmdb_service.dart';

final tmdbServiceProvider = Provider((ref) => TMDbService());

final popularTVProvider = FutureProvider<List<TVShow>>((ref) async {
  final service = ref.read(tmdbServiceProvider);
  return service.getPopularTV();
});
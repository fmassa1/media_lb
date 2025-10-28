import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/movie_provider.dart';
import 'movie_details.dart';

class MovieListScreen extends ConsumerWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMovies = ref.watch(popularMoviesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Popular Movies')),
      body: asyncMovies.when(
        data: (movies) => ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return ListTile(
              leading: Image.network(
                'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(movie.title),
              subtitle: Text(
                movie.overview,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailScreen(movie: movie),
                  ),
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

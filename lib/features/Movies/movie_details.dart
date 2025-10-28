import 'package:flutter/material.dart';
import '../../data/models/movie.dart';
import '../../../state/movie_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MovieDetailScreen extends ConsumerWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMovieDetail = ref.watch(movieDetailProvider(movie.id));
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster and title
            if (movie.posterPath != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),

            Text(
              movie.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            if (movie.tagline != null && movie.tagline!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '"${movie.tagline!}"',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                  ),
                ),
              ),

            const SizedBox(height: 12),
            Text(
              'Release Date: ${movie.releaseDate}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Rating: ${movie.voteAverage.toStringAsFixed(1)} (${movie.voteCount} votes)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (movie.runtime != null)
              Text('Runtime: ${movie.runtime} min'),

            const Divider(height: 24),

            Text(
              'Overview',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(movie.overview),

            const Divider(height: 24),

            if (movie.genres.isNotEmpty) _buildListSection('Genres', movie.genres),
            if (movie.cast.isNotEmpty) _buildListSection('Cast', movie.cast),
            if (movie.directors.isNotEmpty) _buildListSection('Directors', movie.directors),
            if (movie.trailers.isNotEmpty) _buildListSection('Trailers (YouTube Keys)', movie.trailers),
            if (movie.recommendations.isNotEmpty)
              _buildListSection('Recommended', movie.recommendations),
          ],
        ),
      ),
    );
  }

  Widget _buildListSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: items
                .map((e) => Chip(
              label: Text(e),
              backgroundColor: Colors.blueGrey[50],
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

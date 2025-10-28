import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/movie.dart';
import '../../../state/movie_provider.dart';
import 'recommended_movies_list.dart';

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
      body: asyncMovieDetail.when(
        data: (movieDetail) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster
              if (movieDetail.backdropPath != null)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath}',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Title
              Text(
                movieDetail.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              // ID
              Text(
                'Movie ID: ${movieDetail.id}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              // Tagline
              if (movieDetail.tagline != null && movieDetail.tagline!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '"${movieDetail.tagline!}"',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
                  ),
                ),

              const SizedBox(height: 12),

              // Meta info
              Text(
                'Release Date: ${movieDetail.releaseDate}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Rating: ${movieDetail.voteAverage.toStringAsFixed(1)} (${movieDetail.voteCount} votes)',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (movieDetail.runtime != null)
                Text('Runtime: ${movieDetail.runtime} min'),

              const Divider(height: 24),

              // Overview
              Text(
                'Overview',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(movieDetail.overview),

              const Divider(height: 24),

              // Lists
              if (movieDetail.genres.isNotEmpty)
                _buildListSection('Genres', movieDetail.genres),
              if (movieDetail.cast.isNotEmpty)
                _buildListSection('Cast', movieDetail.cast),
              if (movieDetail.directors.isNotEmpty)
                _buildListSection('Directors', movieDetail.directors),
              if (movieDetail.trailers.isNotEmpty)
                _buildListSection('Trailers (YouTube Keys)', movieDetail.trailers),

              if(movieDetail.recommendations.isNotEmpty)
                RecommendedMoviesList(recommendations: movieDetail.recommendations),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            'Failed to load details:\n$err',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
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
                .map(
                  (e) => Chip(
                label: Text(e),
                backgroundColor: Colors.blueGrey[50],
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/media.dart';
import '../../../state/tv_provider.dart';
import '../../core/widgets/recommended_list.dart';
import '../../core/widgets/crew_list.dart';
import 'seasons_list.dart';


class tvShowDetailScreen extends ConsumerWidget {
  final Media tvShow;

  const tvShowDetailScreen({super.key, required this.tvShow});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTVDetail = ref.watch(tvDetailProvider(tvShow.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(tvShow.title),
      ),
      body: asyncTVDetail.when(
        data: (tvDetail) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster
              if (tvDetail.backdropPath != null)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${tvDetail.backdropPath}',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Title
              Text(
                tvDetail.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              // ID
              Text(
                'TV ID: ${tvDetail.id}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              // Tagline
              if (tvDetail.tagline != null && tvDetail.tagline!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '"${tvDetail.tagline!}"',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
                  ),
                ),

              const SizedBox(height: 12),

              // Meta info
              Text(
                'Release Date: ${tvDetail.releaseDate}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Rating: ${tvDetail.voteAverage.toStringAsFixed(1)} (${tvDetail.voteCount} votes)',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (tvDetail.runtime != null)
                Text('Runtime: ${tvDetail.runtime} min'),

              const Divider(height: 24),

              // Overview
              Text(
                'Overview',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(tvDetail.overview),

              const Divider(height: 24),

              SeasonList(seasons: tvDetail.seasons),
              // Lists
              if (tvDetail.genres.isNotEmpty)
                _buildListSection('Genres', tvDetail.genres),

              if (tvDetail.creators.isNotEmpty)
                CrewList(crewMembers: tvDetail.creators, category: "Creators"),

              if (tvDetail.cast.isNotEmpty)
                CrewList(crewMembers: tvDetail.cast, category: "Cast"),

              if (tvDetail.crew.isNotEmpty)
                CrewList(crewMembers: tvDetail.crew, category: "Crew"),

              if (tvDetail.trailers.isNotEmpty)
                _buildListSection('Trailers (YouTube Keys)', tvDetail.trailers),

              if(tvDetail.recommendations.isNotEmpty)
                RecommendedList(recommendations: tvDetail.recommendations),
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

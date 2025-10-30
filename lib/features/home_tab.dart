import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_lb/state/tv_provider.dart';
import '../state/movie_provider.dart';
import '../core/widgets/media_list.dart';


class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPopularMovies = ref.watch(popularMoviesProvider);
    final asyncTopRatedMovies = ref.watch(topRatedMoviesProvider);

    final asyncPopularTVShows = ref.watch(popularTVProvider);
    final asyncTopRatedTVShows = ref.watch(topRatedTVProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Browse Media')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            asyncPopularMovies.when(
              data: (movies) => MediaList(
                title: 'Popular Movies',
                mediaList: movies,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error loading movies: $e')),
            ),

            asyncTopRatedMovies.when(
              data: (movies) => MediaList(
                title: 'Top Rated Movies',
                mediaList: movies,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error loading movies: $e')),
            ),

            asyncPopularTVShows.when(
              data: (shows) => MediaList(
                title: 'Popular TV Shows',
                mediaList: shows,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error loading TV shows: $e')),
            ),

            asyncTopRatedTVShows.when(
              data: (shows) => MediaList(
                title: 'Top Rated TV Shows',
                mediaList: shows,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error loading TV shows: $e')),
            ),
          ],
        ),
      ),
    );
  }
}
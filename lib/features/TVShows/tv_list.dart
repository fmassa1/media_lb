import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/tv_provider.dart';
import 'tv_detail.dart';

class TVListScreen extends ConsumerWidget {
  const TVListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMovies = ref.watch(popularTVProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Popular TV Shows')),
      body: asyncMovies.when(
        data: (shows) => ListView.builder(
          itemCount: shows.length,
          itemBuilder: (context, index) {
            final show = shows[index];
            return ListTile(
              leading: Image.network(
                'https://image.tmdb.org/t/p/w92${show.posterPath}',
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(show.title),
              subtitle: Text(
                show.overview,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => tvShowDetailScreen(tvShow: show),
                  ),
                );
              }
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

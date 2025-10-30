import 'package:flutter/material.dart';
import '../../data/models/media.dart';
import '../../features/Movies/movie_details.dart';
import '../../features/TVShows/tv_details.dart';

class MediaList extends StatelessWidget {
  final List<Media> mediaList;
  final String title;

  const MediaList({super.key, required this.mediaList, required this.title});

  @override
  Widget build(BuildContext context) {
    if (mediaList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mediaList.length,
            itemBuilder: (context, index) {
              final recommended = mediaList[index];
              return GestureDetector(
                onTap: () {
                  if (recommended.type == 'tv') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => tvShowDetailScreen(tvShow: recommended),
                      ),
                    );
                  } else if (recommended.type == 'movie') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(movie: recommended),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Unsupported media type')),
                    );
                  }
                },
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (recommended.posterPath != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w200${recommended.posterPath}',
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        recommended.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

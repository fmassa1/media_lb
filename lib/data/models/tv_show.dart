import 'media.dart';
import 'crew.dart';

class TVShow extends Media{
  final String overview;
  final String? tagline;
  final String? backdropPath;
  final String releaseDate;
  final int? runtime;
  final double voteAverage;
  final int voteCount;
  final List<String> genres;
  final List<Crew> cast;
  final List<Crew> creators;
  final List<Crew> crew;
  final List<String> trailers;
  final List<TVShow> recommendations;

  TVShow({
    required super.id,
    required super.title,
    super.posterPath,

    required this.overview,
    required this.releaseDate,
    this.tagline,
    this.backdropPath,
    this.runtime,
    required this.voteAverage,
    required this.voteCount,
    this.genres = const [],
    this.cast = const [],
    this.creators = const [],
    this.crew = const [],
    this.trailers = const [],
    this.recommendations = const [],
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
    final createdBy = json['created_by'] ?? {};
    final credits = json['credits'] ?? {};
    final videos = json['videos'] ?? {};
    final recs = json['recommendations'] ?? {};

    final genres = (json['genres'] as List?)
        ?.map((g) => g['name'] as String)
        .toList() ??
        [];

    final cast = (credits['cast'] as List?)
        ?.map((r) => Crew.fromJson(r))
        .toList() ?? [];

    final creators = createdBy
        .map((creator) {
          final updatedCreator = Map<String, dynamic>.from(creator);
          updatedCreator['job'] = 'Creator';
          return Crew.fromJson(updatedCreator);
        })
        .toList();

    final crew = (credits['crew'] as List?)
        ?.where((c) => c['job'] != 'Director')
        .map((r) => Crew.fromJson(r))
        .toList() ?? [];

    final trailers = (videos['results'] as List?)
        ?.where((v) => v['site'] == 'YouTube')
        .map((v) => v['key'] as String)
        .toList() ??
        [];

    final recommendations = (recs['results'] as List?)
        ?.map((r) => TVShow.fromJson(r))
        .toList() ?? [];

    return TVShow(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      tagline: json['tagline'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'],
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      genres: genres,
      cast: cast,
      creators: creators,
      crew: crew,
      trailers: trailers,
      recommendations: recommendations,
    );
  }
}

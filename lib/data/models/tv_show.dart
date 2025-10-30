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
  final List<Season> seasons;

  TVShow({
    required super.id,
    required super.title,
    super.posterPath,

    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,

    this.tagline,
    this.backdropPath,
    this.runtime,
    this.genres = const [],
    this.cast = const [],
    this.creators = const [],
    this.crew = const [],
    this.trailers = const [],
    this.recommendations = const [],
    this.seasons = const [],
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
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

    final creators = (json['created_by'] as List?)
        ?.map((r) => Crew.fromJson(r))
        .toList() ?? [];

    final crew = (credits['crew'] as List?)
        ?.map((r) => Crew.fromJson(r))
        .toList() ?? [];

    final trailers = (videos['results'] as List?)
        ?.where((v) => v['site'] == 'YouTube')
        .map((v) => v['key'] as String)
        .toList() ??
        [];

    final recommendations = (recs['results'] as List?)
        ?.map((r) => TVShow.fromJson(r))
        .toList() ?? [];

    final seasons = (recs['seasons'] as List?)
        ?.map((r) => Season.fromJson(r))
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
      seasons: seasons
    );
  }
}

class Season {
  final int id;
  final String airDate;
  final int episodeCount;
  final int season;
  final String overview;
  final String? posterPath;
  final double averageRating;

  Season({
    required this.id,
    required this.airDate,
    required this.episodeCount,
    required this.season,
    required this.overview,
    this.posterPath,
    required this.averageRating,

  });

  factory Season.fromJson(Map<String, dynamic> json) {

    return Season(
      id: json['id'],
      airDate: json['air_date'],
      episodeCount: json['episode_count'],
      season: json['season_number'],
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      averageRating: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}

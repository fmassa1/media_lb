class TVShow {
  final int id;
  final String title;
  final String posterPath;
  final String overview;

  TVShow({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      id: json['id'],
      title: json['name'] ?? '',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
    );
  }
}

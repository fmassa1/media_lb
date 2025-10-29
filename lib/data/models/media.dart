abstract class Media {
  final int id;
  final String title;
  final String? posterPath;

  Media({required this.id, required this.title, this.posterPath});
}
abstract class Media {
  final int id;
  final String title;
  final String? posterPath;
  final String type;

  Media({required this.id, required this.title, this.posterPath, required this.type});
}
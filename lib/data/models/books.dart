class Book {
  final String title;
  final String author;
  final String thumbnail;
  final double rating;

  Book({
    required this.title,
    required this.author,
    required this.thumbnail,
    required this.rating,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Unknown Title',
      author: (json['authors'] != null && json['authors'].isNotEmpty)
          ? json['authors'][0]
          : 'Unknown Author',
      thumbnail: json['imageLinks']?['thumbnail'] ?? '',
      rating: (json['averageRating'] != null)
          ? json['averageRating'].toDouble()
          : 0.0,
    );
  }
}

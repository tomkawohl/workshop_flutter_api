class Movie {
  final String title;
  final int tmbdId;
  final String? overview;
  final double rated;
  final String? image;

  Movie({
    required this.title,
    required this.tmbdId,
    required this.rated,
    this.overview,
    this.image,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      tmbdId: json['id'],
      overview: json['overview'],
      rated: (json['vote_average'] as num).toDouble(),
      image: json['poster_path'],
    );
  }
}

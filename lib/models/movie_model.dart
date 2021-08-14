class MovieModel {
  final String originalTitle;
  final String title;
  final int movieId;
  final List<int> genreIds;
  final DateTime? releseDate;
  final String? posterPath;
  final String? backdropPath;

  MovieModel({
    required this.originalTitle,
    required this.title,
    required this.movieId,
    required this.genreIds,
    required this.releseDate,
    required this.posterPath,
    required this.backdropPath,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      originalTitle: json['original_title'],
      title: json['title'],
      movieId: json['id'],
      genreIds: (json['genre_ids'] as List).map((id) => id as int).toList(),
      releseDate: DateTime.tryParse((json['release_date'])),
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
    );
  }
}

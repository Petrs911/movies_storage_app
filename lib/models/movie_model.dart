class MovieModel {
  final String? backdropPath;
  final List<int> genreIds;
  final int movieId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime? releseDate;
  final String title;
  final num voteAverage;
  final int voteCount;

  MovieModel({
    required this.originalTitle,
    required this.title,
    required this.movieId,
    required this.genreIds,
    required this.releseDate,
    required this.posterPath,
    required this.backdropPath,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      originalTitle: json['original_title'],
      title: json['title'],
      movieId: json['id'],
      genreIds: (json['genre_ids'] as List).map((id) => id as int).toList(),
      releseDate: DateTime.tryParse((json['release_date'] ?? '')),
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      originalLanguage: json['original_language'],
      overview: json['overview'],
      popularity: json['popularity'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }
}

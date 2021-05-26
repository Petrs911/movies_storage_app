class MoviesModel {
  final String originalTitle;
  final String title;
  final int releseDate;
  final String image;

  MoviesModel({this.originalTitle, this.title, this.releseDate, this.image});

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      originalTitle: json['original_title'],
      title: json['title'],
      releseDate: json['release_date'].isEmpty
          ? 1
          : DateTime.parse(json['release_date']).year,
      image: json['poster_path'],
    );
  }
}

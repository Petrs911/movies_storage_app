class MoviesModel {
  final String originalTitle;
  final String title;
  final String releseDate;
  final String image;

  MoviesModel({this.originalTitle, this.title, this.releseDate, this.image});

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      originalTitle: json['original_title'],
      title: json['title'],
      releseDate: json['release_date'].isEmpty
          ? ''
          : DateTime.parse(json['release_date']).year.toString(),
      image: json['poster_path'],
    );
  }
}

import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class HiveFilmModel {
  @HiveField(0)
  final String originalTitle;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime? releseDate;

  @HiveField(3)
  final String? posterPath;

  HiveFilmModel({
    required this.originalTitle,
    required this.title,
    required this.releseDate,
    required this.posterPath,
  });

  @override
  bool operator ==(other) {
    return (other is HiveFilmModel) &&
        other.originalTitle == originalTitle &&
        other.posterPath == posterPath &&
        other.releseDate == releseDate &&
        other.title == title;
  }

  @override
  int get hashCode =>
      originalTitle.hashCode ^
      title.hashCode ^
      releseDate.hashCode ^
      posterPath.hashCode;
}

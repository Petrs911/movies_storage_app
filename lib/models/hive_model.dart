import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class HiveModel {
  @HiveField(0)
  final String originalTitle;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime? realeseDate;

  @HiveField(3)
  final String? posterPath;

  HiveModel({
    required this.originalTitle,
    required this.title,
    required this.realeseDate,
    required this.posterPath,
  });
}

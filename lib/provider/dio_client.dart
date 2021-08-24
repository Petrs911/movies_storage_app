import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movies_storage_app/consts/api_key.dart';
import 'package:movies_storage_app/models/movie_model.dart';

class DioClient {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://api.themoviedb.org/3/search/movie?';

  Future<List<MovieModel>> getMoviesList({required String movieName}) async {
    try {
      final response =
          await _dio.get(_baseUrl, queryParameters: <String, dynamic>{
        'api_key': key,
        'language': 'ru',
        'query': movieName,
      });
      if (response.statusCode == 200) {
        final List<dynamic> movieListFromJson = response.data['results'];
        return movieListFromJson.map((e) => MovieModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load movies list');
      }
    } catch (e) {
      throw e;
    }
  }
}

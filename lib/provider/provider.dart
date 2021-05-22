import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:movies_storage_app/consts/api_key.dart';
import 'package:movies_storage_app/model/movie_model.dart';

class MoviesProvider {
  final http.Client httpClient;
  MoviesProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<List<MoviesModel>> fetchMovie(String movieName) async {
    final movieUrl =
        'https://api.themoviedb.org/3/search/movie?api_key=$key&language=ru&query=$movieName&page=1&include_adult=false';

    final movieResponse = await httpClient.get(Uri.parse(movieUrl));

    if (movieResponse.statusCode != 200) {
      throw Exception('Failed to load movies list');
    }

    final movieJson = jsonDecode(movieResponse.body);
    return (movieJson['results'] as List)
        .map((x) => MoviesModel.fromJson(x))
        .toList();
  }
}

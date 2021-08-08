import 'dart:async';

import 'package:movies_storage_app/models/movie_model.dart';
import 'package:movies_storage_app/provider/provider.dart';

class MoviesRepository {
  final MoviesProvider moviesProvider;

  MoviesRepository({required this.moviesProvider});

  Future<List<MovieModel>> getMovies(String movieName) async {
    return moviesProvider.fetchMovie(movieName);
  }
}

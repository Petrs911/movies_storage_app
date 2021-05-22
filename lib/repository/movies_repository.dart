import 'dart:async';

import 'package:meta/meta.dart';

import 'package:movies_storage_app/provider/provider.dart';
import 'package:movies_storage_app/model/movie_model.dart';

class MoviesRepository {
  final MoviesProvider moviesProvider;

  MoviesRepository({@required this.moviesProvider})
      : assert(moviesProvider != null);

  Future<List<MoviesModel>> getMovies(String movieName) async {
    return moviesProvider.fetchMovie(movieName);
  }
}

import 'dart:async';

import 'package:movies_storage_app/models/actor_model.dart';
import 'package:movies_storage_app/models/movie_model.dart';
import 'package:movies_storage_app/provider/dio_client.dart';

class MoviesRepository {
  final DioClient _dioClient;

  MoviesRepository(this._dioClient);

  Future<List<MovieModel>> getMovies(String movieName) async {
    return _dioClient.getMoviesList(movieName: movieName);
  }

  Future<List<ActorModel>> getActors(int movieId) async {
    return _dioClient.getActors(movieId);
  }
}

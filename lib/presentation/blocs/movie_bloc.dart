import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:movies_storage_app/models/movie_model.dart';
import 'package:movies_storage_app/repository/movies_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MoviesRepository moviesRepository;

  MovieBloc({required this.moviesRepository}) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is GetMoviesEvent) {
      yield MovieLoadingState();
      try {
        final List<MovieModel> movieList =
            await moviesRepository.getMovies(event.movieName);
        if (movieList.isEmpty) {
          yield MovieLoadedEmptyListState(movieName: event.movieName);
        } else {
          yield MovieLoadedState(movieList: movieList);
        }
      } catch (e) {
        yield MovieErrorState(error: e.toString());
      }
    }
  }
}

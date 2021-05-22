import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:movies_storage_app/repository/movies_repository.dart';
import 'package:movies_storage_app/model/movie_model.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MoviesRepository moviesRepository;

  MovieBloc({@required this.moviesRepository})
      : assert(moviesRepository != null),
        super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is GetMoviesEvent) {
      yield MovieLoadingState();
      try {
        final List<MoviesModel> movieList =
            await moviesRepository.getMovies(event.movieName);
        yield MovieLoadedState(movieList: movieList);
      } catch (e) {
        yield MovieErrorState(error: e.toString());
      }
    }
  }
}

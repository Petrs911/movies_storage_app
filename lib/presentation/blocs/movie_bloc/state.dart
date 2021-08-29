part of 'bloc.dart';

@immutable
abstract class MoviesState {
  const MoviesState();
}

class InitialState extends MoviesState {}

class MovieLoadingState extends MoviesState {}

class MovieLoadedState extends MoviesState {
  final List<MovieModel> movieList;

  const MovieLoadedState({required this.movieList});
}

class MovieLoadedEmptyListState extends MoviesState {
  final String movieName;

  const MovieLoadedEmptyListState({required this.movieName});
}

class MovieErrorState extends MoviesState {
  final String error;
  const MovieErrorState({required this.error});
}

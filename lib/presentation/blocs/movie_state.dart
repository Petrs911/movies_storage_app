part of 'movie_bloc.dart';

@immutable
abstract class MovieState {
  const MovieState();
}

class MovieInitial extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<MovieModel> movieList;

  const MovieLoadedState({required this.movieList});
}

class MovieLoadedEmptyListState extends MovieState {
  final String movieName;

  const MovieLoadedEmptyListState({required this.movieName});
}

class MovieErrorState extends MovieState {
  final String error;
  const MovieErrorState({required this.error});
}

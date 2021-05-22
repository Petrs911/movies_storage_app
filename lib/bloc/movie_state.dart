part of 'movie_bloc.dart';

@immutable
abstract class MovieState {
  const MovieState();
}

class MovieInitial extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<MoviesModel> movieList;

  const MovieLoadedState({@required this.movieList})
      : assert(movieList != null);
}

class MovieErrorState extends MovieState {
  final String error;
  const MovieErrorState({@required this.error});
}

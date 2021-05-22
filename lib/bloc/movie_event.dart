part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {
  const MovieEvent();
}

class GetMoviesEvent extends MovieEvent {
  final String movieName;

  const GetMoviesEvent({@required this.movieName}) : assert(movieName != null);
}

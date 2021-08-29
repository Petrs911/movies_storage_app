part of 'bloc.dart';

@immutable
abstract class MoviesEvent {
  const MoviesEvent();
}

class GetMoviesEvent extends MoviesEvent {
  final String movieName;

  const GetMoviesEvent({required this.movieName});
}

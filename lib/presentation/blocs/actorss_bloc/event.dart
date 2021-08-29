part of 'bloc.dart';

@immutable
abstract class ActorsEvent {
  const ActorsEvent();
}

class GetActorsEvent extends ActorsEvent {
  final int movieId;

  const GetActorsEvent({required this.movieId});
}

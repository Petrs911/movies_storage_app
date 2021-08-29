part of 'bloc.dart';

@immutable
abstract class ActorsState {
  const ActorsState();
}

class InitialState extends ActorsState {}

class LoadingState extends ActorsState {}

class LoadedState extends ActorsState {
  final List<ActorModel> actorsList;

  const LoadedState({required this.actorsList});
}

class ErrorState extends ActorsState {
  final String error;

  const ErrorState({required this.error});
}

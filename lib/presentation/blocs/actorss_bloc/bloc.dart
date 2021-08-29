import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:movies_storage_app/models/actor_model.dart';
import 'package:movies_storage_app/repository/movies_repository.dart';

part 'event.dart';
part 'state.dart';

class ActorsBloc extends Bloc<ActorsEvent, ActorsState> {
  final MoviesRepository moviesRepository;

  ActorsBloc({required this.moviesRepository}) : super(InitialState());

  @override
  Stream<ActorsState> mapEventToState(
    ActorsEvent event,
  ) async* {
    if (event is GetActorsEvent) {
      yield LoadingState();
      try {
        final List<ActorModel> actorList =
            await moviesRepository.getActors(event.movieId);
        yield LoadedState(actorsList: actorList);
      } catch (e) {
        yield ErrorState(error: e.toString());
      }
    }
  }
}

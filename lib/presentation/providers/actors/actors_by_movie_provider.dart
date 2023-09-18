

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieMapNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider).getActorsByMovie;

  return ActorsByMovieMapNotifier(getActors: actorsRepository);
});


typedef GetActorsCallback = Future<List<Actor>>Function(String movieId);

class ActorsByMovieMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  
  final GetActorsCallback getActors;

  ActorsByMovieMapNotifier({required this.getActors}): super({});

  Future<void> loadActors(String movieId) async {

    if (state[movieId] != null) return;

    //print('realizando pet http');

    final List<Actor> actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
  


}
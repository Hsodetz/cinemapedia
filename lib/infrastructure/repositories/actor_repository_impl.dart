

import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl implements ActorsRepository{
  
  final ActorsDatasource actorsDatasource;
  
  ActorRepositoryImpl(this.actorsDatasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
   
    return actorsDatasource.getActorsByMovie(movieId);

  }
  
}
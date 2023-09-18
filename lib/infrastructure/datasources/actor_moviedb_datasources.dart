

import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';

class ActorMoviedbDatasource implements ActorsDatasource {

 final dio = Dio(
    BaseOptions(baseUrl: Environment.baseUrl, queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-MX',
    }),
  );

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{
    final response = await dio.get('/movie/$movieId/credits');

    final actorDbResponse = CreditsResponse.fromJson(response.data);

    final List<Actor> actors = actorDbResponse.cast
    .map((cast) => ActorMapper.castToEntity(cast))
    .toList();

    return actors;
  }
  
}
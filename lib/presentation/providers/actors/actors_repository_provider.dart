// Este repositorio es inmutable
import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasources.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl( ActorMoviedbDatasource() );
});
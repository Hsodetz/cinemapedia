import 'package:cinemapedia/domain/entities/movie.dart';

// los repositorios son los que van a llamar al datasource

abstract class MovieRepository {
  
  // obtener las peliculas actuales
  Future<List<Movie>> getNowPlaying({int page = 1});

}
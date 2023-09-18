import 'package:cinemapedia/domain/entities/movie.dart';

// los repositorios son los que van a llamar al datasource

abstract class MoviesRepository {
  // obtener las peliculas actuales
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieById(String id);

}

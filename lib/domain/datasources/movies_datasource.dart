import 'package:cinemapedia/domain/entities/movie.dart';


// Los datasources son los origenes de datos.

abstract class MovieDatasource {
  
  // obtener las peliculas actuales
  Future<List<Movie>> getNowPlaying({int page = 1});

}
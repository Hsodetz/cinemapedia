

import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource implements LocalStorageDatasource{

  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationCacheDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
  

  @override
  Future<bool> isMovieFavorite(int id) async{
    // verificamos si la pelicula con el id existe en la base de datos
    final isar = await db;
    final Movie? isFavoriteMovie = await isar.movies
    .filter()
    .idEqualTo(id)
    .findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async{
    final isar = await db;

    final List<Movie> movies = await isar.movies.where()
    .offset(offset)
    .limit(limit)
    .findAll();

    return movies;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async{
    final isar = await db;

    // verificamos si la pelicula existe con el id
    final Movie? favoriteMovie = await isar.movies
    .filter()
    .idEqualTo(movie.id)
    .findFirst();

    // si es diferente de nulo borramos
    if (favoriteMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }

    // si es igual a null insertamos
    isar.writeTxnSync(() => isar.movies.putSync(movie));

  }

}
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
 
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});



class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>>{

  int page = 0;

  // este es el repositorio q va a llamar al datasource
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({required this.localStorageRepository}):super({});
  
  // metodo que me sirve para cargar la siguiente pagina
  Future<List<Movie>> loadNextPage() async{
    final movies = await localStorageRepository.loadMovies(offset: page * 10, limit: 20);
    page++;

    final tempMoviesMap = {};
    for (var movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    // print('$tempMoviesMap');

    state = {...state, ...tempMoviesMap};

    return movies;
  }


}
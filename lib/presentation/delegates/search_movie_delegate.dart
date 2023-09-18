import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;
  final List<Movie> initialMovies;

  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  });

  void clearStreams() {
    debounceMovies.close();
  }

  void _onQueryChanged(String query) {
    print('query string cambio');
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel(); 

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async{ 
      print('biusacndo peliculas');

  
      final List<Movie> movies = await searchMovies(query);

      debounceMovies.add(movies);


    });
      
    
  }

   Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);
            },
          ),
        );
      },
    );
  }

  // Para que aparezca en la barra de busqueda Buscar Película 
  @override
  String get searchFieldLabel => 'Buscar Película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //if (query.isNotEmpty)
        FadeIn(
          animate: query.isNotEmpty,
          child: IconButton(
            onPressed: () => query = '', 
            icon: const Icon(Icons.clear)
          ),
        ),
    ];
  }

  // usamos para cuando la persona no quiera hacer nada, osea cerrar la busqueda
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
   return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);

   return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
    
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network( 
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
    
            const SizedBox(width: 10),
            
            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( movie.title, style: textStyles.titleMedium ),
    
                  ( movie.overview.length > 100 )
                    ? Text( '${movie.overview.substring(0,100)}...' )
                    : Text( movie.overview ),
    
                  Row(
                    children: [
                      Icon( Icons.star_half_rounded, color: Colors.yellow.shade800 ),
                      const SizedBox(width: 5),
                      Text( 
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900 ),
                      ),
                    ],
                  )
    
                  
                ],
              ),
            ),
    
          ],
        ),
      ),
    );
  }
}

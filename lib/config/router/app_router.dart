import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/home_views/categories_views.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // To add an additional Navigator, use ShellRoute and provide a builder that returns a widge
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                path: 'movie/:id',
                name: MovieScreen.nameUrl,
                builder: (context, state) {
                  final movieId =
                      state.pathParameters['id'] ?? 'no se especifico el id';

                  return MovieScreen(movieId: movieId);
                },
              ),
            ]),
        GoRoute(
          path: '/categories',
          builder: (context, state) {
            return const CategoriesView();
          },
        ),
        GoRoute(
          path: '/favorites',
          name: FavoritesView.nameRoute,
          builder: (context, state) {
            return const FavoritesView();
          },
        ),
      ],
    ),

    // Rutas padre/hijo
    // GoRoute(
    //     path: '/',
    //     name: HomeScreen.nameRoute,
    //     builder: (context, state) => const HomeScreen(childView: HomeView(),),
    //     routes: [
    //       GoRoute(
    //         path: 'movie/:id',
    //         name: MovieScreen.nameUrl,
    //         builder: (context, state) {
    //           final movieId =
    //               state.pathParameters['id'] ?? 'no se especifico el id';

    //           return MovieScreen(movieId: movieId);
    //         },
    //       ),
    //     ]),
  ],
);

import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        name: HomeScreen.nameRoute,
        builder: (context, state) => const HomeScreen(),
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
  ],
);

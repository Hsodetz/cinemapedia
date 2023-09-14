import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:go_router/go_router.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/',

  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.nameRoute,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
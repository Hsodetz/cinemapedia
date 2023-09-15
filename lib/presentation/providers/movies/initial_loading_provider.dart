

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider((ref) {

  // evaluamos si estan vacios, osea en falso.
  final bool step3 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final bool step1 = ref.watch(popularMoviesProvider).isEmpty;
  final bool step2 = ref.watch(topRatedMoviesProvider).isEmpty;
  final bool step4 = ref.watch(upcomingMoviesProvider).isEmpty;

  if (step1 || step2 || step3 || step4) return true;

  // terminamos de cargar
  return false;

});
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/presentation/providers/home_feed_dependencies.dart';
import '../../domain/usecases/get_genre_movies.dart';
import '../../domain/usecases/get_vj_movies.dart';
import '../../domain/usecases/get_vjs_and_genres.dart';

final getVjsAndGenresProvider = Provider<GetVjsAndGenres>((ref) {
  return GetVjsAndGenres(ref.watch(movieRepositoryProvider));
});

final getGenreMoviesProvider = Provider<GetGenreMovies>((ref) {
  return GetGenreMovies(ref.watch(movieRepositoryProvider));
});

final getVjMoviesProvider = Provider<GetVjMovies>((ref) {
  return GetVjMovies(ref.watch(movieRepositoryProvider));
});

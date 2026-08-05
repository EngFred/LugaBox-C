import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/tmdb_remote_data_source.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../domain/usecases/get_home_sections.dart';

final tmdbRemoteDataSourceProvider = Provider<TmdbRemoteDataSource>((ref) {
  return TmdbRemoteDataSource(ref.watch(dioProvider));
});

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepositoryImpl(ref.watch(tmdbRemoteDataSourceProvider));
});

final getHomeSectionsProvider = Provider<GetHomeSections>((ref) {
  return GetHomeSections(ref.watch(movieRepositoryProvider));
});

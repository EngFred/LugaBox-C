import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/movie_details_remote_data_source.dart';
import '../../data/repositories/movie_details_repository_impl.dart';
import '../../domain/repositories/movie_details_repository.dart';
import '../../domain/usecases/get_movie_details.dart';

final movieDetailsRemoteDataSourceProvider =
    Provider<MovieDetailsRemoteDataSource>((ref) {
      return MovieDetailsRemoteDataSource(ref.watch(dioProvider));
    });

final movieDetailsRepositoryProvider = Provider<MovieDetailsRepository>((ref) {
  return MovieDetailsRepositoryImpl(
    ref.watch(movieDetailsRemoteDataSourceProvider),
  );
});

final getMovieDetailsProvider = Provider<GetMovieDetails>((ref) {
  return GetMovieDetails(ref.watch(movieDetailsRepositoryProvider));
});

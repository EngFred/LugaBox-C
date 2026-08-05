import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/presentation/providers/home_feed_dependencies.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/repositories/search_repository.dart';
import '../../domain/usecases/search_titles.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepositoryImpl(ref.watch(tmdbRemoteDataSourceProvider));
});

final searchTitlesProvider = Provider<SearchTitles>((ref) {
  return SearchTitles(ref.watch(searchRepositoryProvider));
});

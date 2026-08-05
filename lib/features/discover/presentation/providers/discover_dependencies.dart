import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/presentation/providers/home_feed_dependencies.dart';
import '../../data/repositories/discover_repository_impl.dart';
import '../../domain/repositories/discover_repository.dart';
import '../../domain/usecases/get_discover_feed.dart';

final discoverRepositoryProvider = Provider<DiscoverRepository>((ref) {
  return DiscoverRepositoryImpl(ref.watch(tmdbRemoteDataSourceProvider));
});

final getDiscoverFeedProvider = Provider<GetDiscoverFeed>((ref) {
  return GetDiscoverFeed(ref.watch(discoverRepositoryProvider));
});

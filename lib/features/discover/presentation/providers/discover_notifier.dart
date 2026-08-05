import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_discover_feed.dart';
import 'discover_dependencies.dart';
import 'discover_event.dart';
import 'discover_state.dart';

class DiscoverNotifier extends Notifier<DiscoverState> {
  late final GetDiscoverFeed _getDiscoverFeed;

  @override
  DiscoverState build() {
    _getDiscoverFeed = ref.watch(getDiscoverFeedProvider);
    return const DiscoverState();
  }

  Future<void> onEvent(DiscoverEvent event) {
    return switch (event) {
      DiscoverStarted() => _load(),
    };
  }

  Future<void> _load() async {
    if (state.isLoading || state.feed != null) return;

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final feed = await _getDiscoverFeed();
      state = state.copyWith(feed: feed, isLoading: false, clearError: true);
    } catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_home_sections.dart';
import 'home_feed_dependencies.dart';
import 'home_feed_event.dart';
import 'home_feed_state.dart';

class HomeFeedNotifier extends Notifier<HomeFeedState> {
  late final GetHomeSections _getHomeSections;

  @override
  HomeFeedState build() {
    _getHomeSections = ref.watch(getHomeSectionsProvider);
    return const HomeFeedState();
  }

  Future<void> onEvent(HomeFeedEvent event) {
    return switch (event) {
      HomeFeedStarted() => _load(),
      HomeFeedRefreshRequested() => _load(refreshing: true),
    };
  }

  Future<void> _load({bool refreshing = false}) async {
    if (state.isLoading || state.isRefreshing) return;

    state = state.copyWith(
      isLoading: !state.hasContent,
      isRefreshing: refreshing && state.hasContent,
      clearError: true,
    );

    try {
      final sections = await _getHomeSections();
      state = state.copyWith(
        sections: sections,
        isLoading: false,
        isRefreshing: false,
        clearError: true,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        isRefreshing: false,
        errorMessage:
            'Could not load movies. Check your TMDB API key or connection.',
      );
    }
  }
}

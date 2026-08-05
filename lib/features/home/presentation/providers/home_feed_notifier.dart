import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/movie_section.dart';
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
      HomeFeedSectionPageRequested(:final sectionKey) => _loadSectionPage(
        sectionKey,
      ),
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
      final results = await Future.wait([
        _getHomeSections(),
        ref.read(getGenresProvider)(),
      ]);
      final sections = results[0] as List;
      final genres = results[1] as List;
      state = state.copyWith(
        sections: sections.cast(),
        genres: genres.cast(),
        sectionPages: {
          for (final section in sections.cast())
            section.config.key: section.config.page,
        },
        isLoading: false,
        isRefreshing: false,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        isRefreshing: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> _loadSectionPage(String sectionKey) async {
    if (state.loadingSectionKeys.contains(sectionKey)) return;

    final index = state.sections.indexWhere(
      (section) => section.config.key == sectionKey,
    );
    if (index == -1) return;

    final currentSection = state.sections[index];
    final currentPage =
        state.sectionPages[sectionKey] ?? currentSection.config.page;
    final nextPage = currentPage + 1;

    state = state.copyWith(
      loadingSectionKeys: {...state.loadingSectionKeys, sectionKey},
    );

    try {
      final nextSection = await _getHomeSections.sectionPage(
        currentSection.config,
        nextPage,
      );
      final updatedSections = [...state.sections];
      updatedSections[index] = MovieSection(
        title: currentSection.title,
        subtitle: currentSection.subtitle,
        layout: currentSection.layout,
        movies: [...currentSection.movies, ...nextSection.movies],
        config: currentSection.config,
      );

      state = state.copyWith(
        sections: updatedSections,
        sectionPages: {...state.sectionPages, sectionKey: nextPage},
        loadingSectionKeys: state.loadingSectionKeys
            .where((key) => key != sectionKey)
            .toSet(),
      );
    } catch (_) {
      state = state.copyWith(
        loadingSectionKeys: state.loadingSectionKeys
            .where((key) => key != sectionKey)
            .toSet(),
      );
    }
  }
}
